-- 1.	�������� ��� ����� �� ������ ������� ������ �������������� ����:
alter table STUDENT add hid hierarchyid;            -- hid - ��� ������� ������ �������������� ����
alter table STUDENT add h_level as hid.GetLevel();  -- h_level - ��� ������� ������, ����������� ������� ��������

-- ��������� ������� ������� �������������� ����:
insert into STUDENT (STUDENT, STUDENT_NAME, FACULTY, PHONE_NUMBER, HOME_ADDRESS, hid) values ('���', '������� ����� ���������', '����', '+375298833333', geography::STPointFromText('POINT(-75.9814 40.7638)', 4326), '/1/');
insert into STUDENT (STUDENT, STUDENT_NAME, FACULTY, PHONE_NUMBER, HOME_ADDRESS, hid) values ('���', '�������� ����� ������������', '���', '+375298834433', geography::STPointFromText('POINT(-75.9814 40.2338)', 4326), '/1/1/');
insert into STUDENT (STUDENT, STUDENT_NAME, FACULTY, PHONE_NUMBER, HOME_ADDRESS, hid) values ('���', '������ ����� �������������', '����', '+375293333333', geography::STPointFromText('POINT(-75.9814 44.7640)', 4326), '/1/2/');
insert into STUDENT (STUDENT, STUDENT_NAME, FACULTY, PHONE_NUMBER, HOME_ADDRESS, hid) values ('���', '������ ������� ����������', '����', '+375298233333', geography::STPointFromText('POINT(-75.9514 43.7640)', 4326), '/1/2/1/');

insert into STUDENT (STUDENT, STUDENT_NAME, FACULTY, PHONE_NUMBER, HOME_ADDRESS, hid) values
                                         ('���', '���������� ���� ��������', '����', '+375293333333', geography::STPointFromText('POINT(-75.9814 44.7640)', 4326), '/3/1/'),
                                         ('���', '������ ���� �������������', '����', '+375298233333', geography::STPointFromText('POINT(-75.9514 43.7640)', 4326), '/3/1/1/');



-- 2. ������� ���������, ������� ��������� ��� ����������� ���� � ��������� ������ �������� (�������� � �������� ����).
create or alter procedure sp_get_child_nodes(@node hierarchyid)
as
begin
    declare @level int;
    select @level = hid.GetLevel() from STUDENT where hid = @node;
    select * from STUDENT where hid.IsDescendantOf(@node) = 1 and hid.GetLevel() > @level;
end;

-- ����� ���������:
EXEC sp_get_child_nodes '/1/2/';



-- 3.	������� ���������, ������� ������� ����������� ���� (�������� � �������� ����).
CREATE OR ALTER PROCEDURE sp_add_child_node(@node hierarchyid)
AS
BEGIN
    DECLARE @parent_level int, @child_node hierarchyid;

    SELECT @parent_level = hid.GetLevel() FROM STUDENT WHERE hid = @node;
    SET @child_node = @node.GetDescendant(NULL, NULL);

    INSERT INTO STUDENT (STUDENT, STUDENT_NAME, FACULTY, PHONE_NUMBER, HOME_ADDRESS, hid)
    VALUES ('���', '���������� ������ ��������', '����', '+375298233333',
            geography::STPointFromText('POINT(-75.9514 43.7640)', 4326),
            @child_node);
END;

-- ����� ���������:
EXEC sp_add_child_node '/3/'    -- add a new child node with a hierarchyid value of '/3/1/'



-- 4.	������� ���������, ������� ���������� ��� ����������� ����� (������ �������� � �������� �������� ������������� ����, ������ �������� � �������� ����, � ������� ���������� �����������).
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

-- ����� ���������:
EXEC sp_move_subtree '/3/1/', '/3/1/1/';   -- move the subtree with a root node of '/3/1/' to the node '/3/1/1/'
