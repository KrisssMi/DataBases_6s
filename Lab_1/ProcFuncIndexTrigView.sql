use Personnel;
alter database Personnel collate Cyrillic_General_CI_AS;

------------------VIEWS------------------
create view Department_view as select department, leader from Department;
create view Employee_view as select idEmployee, personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary, status from Official_information where status = 'Работает';
create view Employee2_view as select idEmployee, personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary, status from Official_information where status = 'Не работает';
create view Vacancy_view as select idVacancy, idDep, salary, status from Vacancy where status=N'Не доступно';    -- вакансии, которые недоступны в данный момент
create view AvailableVacancy_view as select idVacancy, idDep, salary, status from Vacancy where status= N'Доступно';

select * from Department_view;
select * from Employee_view;
select * from Employee2_view;
select * from Vacancy_view;


drop view Vacancy_view;
drop view AvailableVacancy_view;

------------------INDEXES------------------
create index idx1 on Official_information (idEmployee);
create nonclustered index idx2 on Personal_information(personalNum, passport, children desc, dateBirth);
-- индекс для поля с уникальными значениями:
create unique index idx3 on Official_information (personalNum);
-- создание индекса покрытия:
create index idx4 on Department(idDep, department) INCLUDE (leader);
-- создание фильтруемого индекса:
create index idx5 on Official_information(idEmployee, name, surname, salary) where (salary>=500 and salary<=1000);

-- проверка наличия индексов
select * from sys.indexes where object_id = object_id('Official_information');
select * from sys.indexes where object_id = object_id('Personal_information');


------------------TRIGGERS------------------
-- 1. При добавлении нового сотрудника в таблицу Personal_information, вывести на экран сообщение 'Сотрудник добавлен'
create trigger tr1 on Personal_information
after insert
as
begin
    print 'Сотрудник добавлен';
end;

drop trigger tr1;

insert into Personal_information(personalNum, placeBirth, passport, address, regAddress, maritalStat, children, dateBirth)
  values (15, 'г.Лида', '657697643', 'г.Лида, ул.Машерова, д.67', 'г.Лида, ул.Машерова, д.67', 'Замужем', 0, '30.11.2000');
delete from Personal_information where personalNum = 15;


-- 2. При удалении сотрудника из таблицы Official_information, вывести на экран сообщение 'Сотрудник удален'
create trigger tr2 on Official_information
after delete
as
begin
    print 'Сотрудник удален';
end;

drop trigger tr2;

insert into Official_information(idEmployee, personalNum, surname, name, patronymic, idDep, idPost, education, idSpec, experience, phoneNum, salary, status) values
 (14376248, 15, 'Иванов', 'Иван', 'Иванович', 1, 1, 'Высшее', 1, '5 лет', '80(29)192-34-98', 2000, 'Работает');
delete from Official_information where idEmployee = 14376248;


-- 3. При изменении зарплаты сотрудника в таблице Official_information, вывести на экран сообщение 'Зарплата изменена'
create trigger tr3 on Official_information
after update
as
begin
    print 'Зарплата изменена';
end;

drop trigger tr3;

update Official_information set salary = 1850 where personalNum = 2;
select * from Official_information where personalNum = 2;


------------------FUNCTIONS------------------
-- 1. Средняя зарплата в отделе
create function avg_salary_func(@idDep int)
	returns real
    as begin declare @avgw real = 0;
	set @avgw = (select avg(salary) from Official_information where idDep=@idDep);
	return @avgw;
	end;

select dbo.avg_salary_func(2) [Средняя зарплата отдела]


-- 2. Суммарная зарплата в отделе
create function sum_salary_func(@idDep int)
    returns real
    as begin declare @sumw real = 0;
    set @sumw = (select sum(salary) from Official_information where idDep=@idDep);
    return @sumw;
    end;

select dbo.sum_salary_func(1) [Суммарная зарплата отдела]


-- 3. Количество сотрудников в отделе, которые не работают
create function count_emp_func(@idDep int)
    returns int
    as begin declare @count int = 0;
    set @count = (select count(idEmployee) from Official_information where idDep=@idDep and status = 'Не работает');
    return @count;
    end;

select dbo.count_emp_func(3) [Количество сотрудников в отделе, которые не работают]
select dbo.count_emp_func(1) [Количество сотрудников в отделе, которые не работают]


------------------PROCEDURES------------------
-- 1. Добавление нового сотрудника в базу данных
CREATE OR ALTER PROCEDURE Add_Official_Inf_Proc
    @personalNum int,
    @surname varchar(50),
	@name varchar(50),
	@patronymic varchar(50),
	@idDep int,
	@education varchar(50),
	@experience varchar(50),
	@phoneNum varchar(20),
	@salary int,
	@status varchar(20)
AS
BEGIN
INSERT INTO Official_information(personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary,status)
VALUES(@personalNum, @surname, @name, @patronymic, @idDep, @education, @experience, @phoneNum, @salary, @status)
END;
--
-- insert into Personal_information(personalNum) values (16);
exec Add_Official_Inf_Proc 12, 'Петров', 'Петр', 'Петрович', 1, 'Высшее', '5 лет', '80(29)192-34-98', 2000, 'Работает';
-- delete from Official_information where idEmployee=16;
select * from Official_information;


-- 2. Изменение данных о сотруднике
CREATE OR ALTER PROCEDURE Update_Official_Inf_Proc
    @idEmployee int,
    @personalNum int,
    @surname varchar(50),
    @name varchar(50),
    @patronymic varchar(50),
    @idDep int,
    @education varchar(50),
    @experience varchar(50),
    @phoneNum varchar(20),
    @salary int,
    @status varchar(20)
AS
BEGIN
UPDATE Official_information SET personalNum = @personalNum, surname = @surname, name = @name, patronymic = @patronymic, idDep = @idDep, education = @education, experience = @experience, phoneNum = @phoneNum, salary = @salary, status = @status WHERE idEmployee = @idEmployee
END;

exec Update_Official_Inf_Proc 17, 12, 'new', 'Петр', 'Петрович', 1, 'Высшее', '5 лет', '80(29)192-34-98', 2000, 'Работает';
select * from Official_information;


-- 3. Удаление сотрудника из базы данных
CREATE OR ALTER PROCEDURE Delete_Official_Inf_Proc
    @idEmployee int
AS
BEGIN
DELETE FROM Official_information WHERE idEmployee = @idEmployee
END;

exec Delete_Official_Inf_Proc 17975680;


-- 4. Добавление нового отдела в базу данных
CREATE OR ALTER PROCEDURE Add_Department_Proc
    @nameDep varchar(50),
    @leader varchar(50),
    @phoneNum varchar(20)
AS
BEGIN
INSERT INTO Department(department, leader, phoneNum) VALUES(@nameDep, @leader, @phoneNum)
END;

exec Add_Department_Proc 'Бухгалтерия', 'Жегало Алиса Руслановна', '80(33)343-1746'
select * from Department;


-- 5. Получение списка всех работающих сотрудников
CREATE OR ALTER PROCEDURE Get_Working_Emp_Proc
AS
BEGIN
SELECT * FROM Official_information WHERE status = 'Работает'
END;

exec Get_Working_Emp_Proc;


-- 6. Поиск информации о конкретном сотруднике
CREATE OR ALTER PROCEDURE Get_Emp_By_Id
    @personalNum int
AS
BEGIN
	SELECT * FROM Personal_information INNER JOIN Official_information
	     ON Personal_information.personalNum = Official_information.personalNum where Personal_information.personalNum = @personalNum
END;

exec Get_Emp_By_Id 4;


-- 7. Добавление новой вакансии в базу данных
CREATE OR ALTER PROCEDURE Add_Vacancy_Proc
    @idDep int,
    @salary int,
    @status varchar(15)
AS
BEGIN
INSERT INTO Vacancy(idDep, salary, status) VALUES(@idDep, @salary, @status)
END;

exec Add_Vacancy_Proc 1, 2000, N'Доступно';
exec Add_Vacancy_Proc 13,

-- 8. Добавление личной информации о сотруднике
CREATE OR ALTER PROCEDURE Add_Personal_Inf_Proc
    @personalNum int,
    @placeBirth varchar(25),
    @passport varchar(30),
    @address varchar(50),
    @regAddress varchar(50),
    @maritalStat varchar(20),
    @children int,
    @dateBirth varchar(50)
AS
BEGIN
INSERT INTO Personal_information(personalNum, placeBirth, passport, address, regAddress, maritalStat, children, dateBirth)
VALUES(@personalNum, @placeBirth, @passport, @address, @regAddress, @maritalStat, @children, @dateBirth)
END;

exec Add_Personal_Inf_Proc 16, 'Киев', 'АА 123456', 'ул. Ленина 1', 'ул. Ленина 1', 'Женат', 0, '1990-01-01'


-- 9. Удаление личной информации о сотруднике:
CREATE OR ALTER PROCEDURE Delete_Personal_Inf_Proc
    @personalNum int
AS
BEGIN
DELETE FROM Personal_information WHERE personalNum = @personalNum
END;

exec Delete_Personal_Inf_Proc 16


-- 10. Обновление личной информации о сотруднике
CREATE OR ALTER PROCEDURE Update_Personal_Inf_Proc
    @personalNum int,
    @placeBirth varchar(25),
    @passport varchar(30),
    @address varchar(50),
    @regAddress varchar(50),
    @maritalStat varchar(20),
    @children int,
    @dateBirth varchar(50)
AS
BEGIN
UPDATE Personal_information SET placeBirth = @placeBirth, passport = @passport, address = @address, regAddress = @regAddress, maritalStat = @maritalStat, children = @children, dateBirth = @dateBirth WHERE personalNum = @personalNum
END;

exec Update_Personal_Inf_Proc 16, 'Киев', 'АА 123456', 'ул. Ленина 1', 'ул. Ленина 1', 'Женат', 0, '1990-01-01'
select * from Personal_information


-- 11. Удаление вакансии из базы данных
CREATE OR ALTER PROCEDURE Delete_Vacancy_Proc
    @idVacancy int
AS
BEGIN
DELETE FROM Vacancy WHERE idVacancy = @idVacancy
END;

exec Delete_Vacancy_Proc 1


-- 12. Обновление вакансии
CREATE OR ALTER PROCEDURE Update_Vacancy_Proc
    @idVacancy int,
    @idDep int,
    @salary int,
    @status nvarchar(15)
AS
BEGIN
UPDATE Vacancy SET idDep = @idDep, salary = @salary, status=@status WHERE idVacancy = @idVacancy
END;

exec Update_Vacancy_Proc 2, 4, 2, 1, 1500, N'Доступно'