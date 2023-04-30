create database Personnel;
use Personnel;

create table Personal_information(	--личная информация
 personalNum int constraint personalNum_pk primary key, --индивидуальный номер
 placeBirth varchar(25),	--место рождения
 passport varchar(30),		--паспорт
 address varchar(50),		--адрес проживания
 regAddress varchar(50),	--адрес регистрации
 maritalStat varchar(20),	--семейное положение
 children int,				--дети
 dateBirth varchar(50));	--дата рождения

 create table Department (  --отдел
 idDep int not null identity(1,1) constraint idDep_pk primary key,  --идентификатор отдела
 department varchar(50),    --название отдела
 leader varchar(50),        --начальник
 phoneNum varchar(20),     --номер телефона
location geography);

create table Official_information( --служебная информация
 idEmployee int identity(1,1) constraint idEmployee_pk primary key, --номер сотрудника
 personalNum int constraint personalNum_FK foreign key references personal_information(personalNum), --индивидуальный номер
 surname varchar(50),       --фамилия
 name varchar(50),          --имя
 patronymic varchar(50),    --отчество
 idDep int constraint idDep_ofInf_FK foreign key references Department(idDep),     --код отдел
 education varchar(50),     --образование
 experience varchar(50),    --стаж
 phoneNum varchar(20),      --номер телефона
 salary int,                --зарплата
 status  varchar(20));      --статус сотрудника

create table Vacancy(
idVacancy int identity(1,1) constraint idVacancy_pk primary key, --идентификатор вакансии
idDep int constraint idDep_vac_FK foreign key references Department(idDep), --код отдела
salary int, --зарплата
status varchar(15) NOT NULL CHECK (status IN (N'Доступно', N'Не доступно')));--статус вакансии
--idPost int constraint idPost_vac_FK foreign key references Position(idPosition), --код должности
--idSpec int constraint idSpec_vac_FK foreign key references Specialty(idSpec), --код специальности

-- create table Position(         --должности
--  idPosition int not null identity(1,1) constraint idPost_pk primary key, --идентификатор должности
--  position varchar(50));         --название должности

-- create table Specialty(     --специальности
--  idSpec int not null identity(1,1) constraint idSpec_pk primary key, --идентификатор специальности
--  specialty varchar(50));    --специальность


-- drop database Personnel;
--drop table Position;
--drop table Specialty;
drop table Vacancy;
drop table Official_information;
drop table Department;
drop table Personal_information;