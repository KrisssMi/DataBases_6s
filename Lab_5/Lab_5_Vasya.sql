-- 1.	Добавить для одной из таблиц столбец данных иерархического типа:
alter table STUDENT add hid hierarchyid;            -- hid - имя столбца данных иерархического типа
alter table STUDENT add h_level as hid.GetLevel();  -- h_level - имя столбца данных, содержащего уровень иерархии

-- Заполнить столбец данными иерархического типа:
insert into STUDENT (STUDENT, STUDENT_NAME, FACULTY, PHONE_NUMBER, HOME_ADDRESS, hid) values ('ГДА', 'Горячко Дарья Андреевна', 'ИДиП', '+375298833333', geography::STPointFromText('POINT(-75.9814 40.7638)', 4326), '/1/');
insert into STUDENT (STUDENT, STUDENT_NAME, FACULTY, PHONE_NUMBER, HOME_ADDRESS, hid) values ('СДВ', 'Сазонова Дарья Владимировна', 'ИЭФ', '+375298834433', geography::STPointFromText('POINT(-75.9814 40.2338)', 4326), '/1/1/');
insert into STUDENT (STUDENT, STUDENT_NAME, FACULTY, PHONE_NUMBER, HOME_ADDRESS, hid) values ('НОА', 'Нистюк Ольга Александровна', 'ХТиТ', '+375293333333', geography::STPointFromText('POINT(-75.9814 44.7640)', 4326), '/1/2/');
insert into STUDENT (STUDENT, STUDENT_NAME, FACULTY, PHONE_NUMBER, HOME_ADDRESS, hid) values ('КЭА', 'Корево Эвелина Алексеевна', 'ИДиП', '+375298233333', geography::STPointFromText('POINT(-75.9514 43.7640)', 4326), '/1/2/1/');

insert into STUDENT (STUDENT, STUDENT_NAME, FACULTY, PHONE_NUMBER, HOME_ADDRESS, hid) values
                                         ('МГП', 'Михалкевич Глеб Петрович', 'ХТиТ', '+375293333333', geography::STPointFromText('POINT(-75.9814 44.7640)', 4326), '/3/1/'),
                                         ('АИА', 'Адамов Илья Александрович', 'ИДиП', '+375298233333', geography::STPointFromText('POINT(-75.9514 43.7640)', 4326), '/3/1/1/');



-- 2. Создать процедуру, которая отобразит все подчиненные узлы с указанием уровня иерархии (параметр – значение узла).
create or alter procedure sp_get_child_nodes(@node hierarchyid)
as
begin
    declare @level int;
    select @level = hid.GetLevel() from STUDENT where hid = @node;
    select * from STUDENT where hid.IsDescendantOf(@node) = 1 and hid.GetLevel() > @level;
end;

-- Вызов процедуры:
EXEC sp_get_child_nodes '/1/2/';



-- 3.	Создать процедуру, которая добавит подчиненный узел (параметр – значение узла).
CREATE OR ALTER PROCEDURE sp_add_child_node(@node hierarchyid)
AS
BEGIN
    DECLARE @parent_level int, @child_node hierarchyid;

    SELECT @parent_level = hid.GetLevel() FROM STUDENT WHERE hid = @node;
    SET @child_node = @node.GetDescendant(NULL, NULL);

    INSERT INTO STUDENT (STUDENT, STUDENT_NAME, FACULTY, PHONE_NUMBER, HOME_ADDRESS, hid)
    VALUES ('МКП', 'Мельникова Карина Петровна', 'ИДиП', '+375298233333',
            geography::STPointFromText('POINT(-75.9514 43.7640)', 4326),
            @child_node);
END;

-- Вызов процедуры:
EXEC sp_add_child_node '/3/'    -- add a new child node with a hierarchyid value of '/3/1/'



-- 4.	Создать процедуру, которая переместит всю подчиненную ветку (первый параметр – значение верхнего перемещаемого узла, второй параметр – значение узла, в который происходит перемещение).
CREATE OR ALTER PROCEDURE sp_move_subtree
    @source_node hierarchyid,
    @destination_node hierarchyid
AS
BEGIN
   if @source_node=@destination_node
       begin
            raiserror ('Source and destination nodes are the same. Cannot move', 16, 1)
       end

       declare @source_node_level hierarchyid
       select @source_node_level = hid from STUDENT where hid = @source_node

         declare @destination_node_level hierarchyid
         select @destination_node_level = hid from STUDENT where hid = @destination_node

   if @source_node_level is null or @destination_node_level is null
        begin
            raiserror ('Invalid node value. Node does not exist', 16, 1)
        end

        declare @shift_amount int
        select @shift_amount = @destination_node_level.GetLevel() - @source_node_level.GetLevel()

   begin transaction
   update STUDENT
   set hid = hid.GetAncestor(@shift_amount)
   where hid.IsDescendantOf(@source_node) = 1

    update STUDENT
    set hid = @destination_node.GetDescendant(NULL, NULL)
    where hid = @source_node

    commit transaction
END;

-- Вызов процедуры:
EXEC sp_move_subtree '/3/1/', '/3/1/1/';   -- move the subtree with a root node of '/3/1/' to the node '/3/1/1/'
