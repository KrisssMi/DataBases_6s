-- 1.	Добавить для одной из таблиц столбец данных иерархического типа:
alter table Official_information add hid hierarchyid;           -- hid - имя столбца данных иерархического типа
alter table Official_information add h_level as hid.GetLevel(); -- h_level - имя столбца данных, содержащего уровень иерархии

-- 	Заполнить столбец данных иерархического типа:
insert into Official_information(personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary, status, hid)
values (14, 'Даревский', 'Денис', 'Денисович', 1, 'Высшее', 5, '8-800-555-35-35', 10000, 'Работает', '/1/');
insert into Official_information(personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary, status, hid)
values (10, 'Cтепанов', 'Степан', 'Степанович', 1, 'Высшее', 5, '8-800-555-35-35', 10000, 'Работает', '/1/1/');
insert into Official_information(personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary, status, hid)
values (9, 'Сидоров', 'Сидор', 'Сидорович', 1, 'Высшее', 5, '8-800-555-35-35', 10000, 'Работает', '/1/1/1/');
insert into Official_information(personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary, status, hid)
values (11, 'Иванов', 'Иван', 'Иванович', 1, 'Высшее', 5, '8-800-555-35-35', 10000, 'Работает', '/1/2/');

insert into Official_information(personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary, status, hid)
values (14, 'New', 'New', 'New', 1, 'Высшее', 5, '8-800-555-35-35', 430, 'Работает', '/2/');
insert into Official_information(personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary, status, hid)
values (13, 'New2', 'New2', 'New2', 1, 'Высшее', 5, '8-800-555-35-35', 430, 'Работает', '/2/1/');

-- 2.	Создать процедуру, которая отобразит все подчиненные узлы с указанием уровня иерархии (параметр – значение узла).
create or alter procedure sp_get_child_nodes(@node hierarchyid)
as
begin
    declare @level int;
    select @level = hid.GetLevel() from Official_information where hid = @node;
    select * from Official_information where hid.IsDescendantOf(@node) = 1 and hid.GetLevel() > @level;
end;

-- Вызов процедуры:
EXEC sp_get_child_nodes '/1/';


-- 3.	Создать процедуру, которая добавит подчиненный узел (параметр – значение узла).
CREATE OR ALTER PROCEDURE sp_add_child_node(@node hierarchyid)
AS
BEGIN
    DECLARE @parent_level int, @child_node hierarchyid;

    SELECT @parent_level = hid.GetLevel() FROM Official_information WHERE hid = @node;
    SET @child_node = @node.GetDescendant(NULL, NULL);                                  -- вернет все элементы в иерархии или поддереве, начиная с корневого элемента

    INSERT INTO Official_information (personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary, status, hid)
    VALUES (1, 'New', 'New', 'New', 1, 'Высшее', 5, '8-800-555-35-35', 430, 'Работает', @child_node);
END;

-- Вызов процедуры:
EXEC sp_add_child_node '/3/'    -- add a new child node with a hierarchyid value of '/3/1/'


-- 4.	Создать процедуру, которая переместит всю подчиненную ветку
CREATE OR ALTER PROCEDURE sp_move_subtree
    @source_node hierarchyid,       -- значение верхнего перемещаемого узла
    @destination_node hierarchyid   -- значение узла, в который происходит перемещение
AS
BEGIN
   if @source_node=@destination_node
       begin
            raiserror ('Source and destination nodes are the same. Cannot move', 16, 1)
       end

       declare @source_node_level hierarchyid
       select @source_node_level = hid from Official_information where hid = @source_node

         declare @destination_node_level hierarchyid
         select @destination_node_level = hid from Official_information where hid = @destination_node

   if @source_node_level is null or @destination_node_level is null
        begin
            raiserror ('Invalid node value. Node does not exist', 16, 1)
        end

        declare @shift_amount int
        select @shift_amount = @destination_node_level.GetLevel() - @source_node_level.GetLevel()

   begin transaction
   update Official_information
   set hid = hid.GetAncestor(@shift_amount)                             -- используется для извлечения узла(ов)-предка данного узла в иерархии
   where hid.IsDescendantOf(@source_node) = 1

    update Official_information
    set hid = @destination_node.GetDescendant(NULL, NULL)
    where hid = @source_node
    commit transaction
END;

-- Вызов процедуры:
EXEC sp_move_subtree '/2/', '/2/1/';          -- move the subtree with a root node of '/3/1/' to the node '/3/1/1/'