create database Personnel_Lab_9;
use Personnel_Lab_9;
alter database Personnel_Lab_9 collate Cyrillic_General_CI_AS;
drop table Personal_information;
drop table Official_information;
drop table HR;
drop table Department;
drop table Company;

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

CREATE TABLE HR (
   EmployeeID INT PRIMARY KEY,
   EmployeeName VARCHAR(50) NOT NULL,
   HireDate DATE NOT NULL,  -- дата найма
   Rejected BIT NOT NULL,   -- флаг отклонения кандидата
   CompanyID INT NOT NULL,
   CONSTRAINT fk_CompanyID FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID)
);
drop table HR;

CREATE TABLE Company (
  CompanyID INT PRIMARY KEY,
  CompanyName VARCHAR(50) NOT NULL,
  Address VARCHAR(100) NOT NULL,
  PhoneNumber VARCHAR(20) NOT NULL
);


----------------COMPANY-----------------
INSERT INTO Company (CompanyID, CompanyName, Address, PhoneNumber)
VALUES
  (1, 'ООО "Мир IT"', 'г. Москва, ул. Ленина, д. 10', '+7 (495) 123-45-67'),
  (2, 'ООО "C.Group"', 'г. Санкт-Петербург, ул. Пушкина, д. 5', '+7 (812) 765-43-21'),
  (3, 'ЗАО "Стальные магнаты"', 'г. Екатеринбург, ул. Сталина, д. 1', '+7 (343) 555-55-55');


----------------HR-----------------
INSERT INTO HR (EmployeeID, EmployeeName, HireDate, Rejected, CompanyID)
VALUES
  (1, 'Иванов Иван Иванович', '2023-01-01', 0, 1),
  (2, 'Петров Петр Петрович', '2023-02-15', 0, 1),
  (3, 'Сидорова Анна Александровна', '2023-03-10', 1, 2),
  (4, 'Козлов Дмитрий Сергеевич', '2023-04-05', 0, 3),
  (5, 'Смирнова Елена Викторовна', '2023-05-02', 0, 1),
  (6, 'Николаев Игорь Андреевич', '2022-06-15', 1, 2),
  (7, 'Адамов Илья Александрович', '2023-01-15', 1, 1),
  (8, 'Герасимович Егор Алексеевич', '2023-01-25', 1, 3),
  (9, 'Карпов Илья Сергеевич', '2023-02-10', 0, 2),
  (10, 'Жегало Алиса Геннадьевна', '2023-04-04', 1, 3),
  (11, 'Лынько Дарина Михайловна', '2023-03-03', 0, 1);




--------------------------------------------------------------------------------------------------------------------------
-- 1.
-- Вычисление итогов работы HR за определенный период:
-- •	количество нанятых сотрудников;
SELECT DISTINCT
   HireDate,
   COUNT(EmployeeID) OVER (PARTITION BY HireDate) AS HiredEmployeesCount
FROM HR
WHERE HireDate BETWEEN '2022-01-01' AND '2023-12-31'
ORDER BY HireDate;

-- •	сравнение с общим количеством нанятых сотрудников (в %);
SELECT
   HireDate,
   COUNT(EmployeeID) OVER (PARTITION BY HireDate) AS HiredEmployeesCount,
   CAST(COUNT(EmployeeID) OVER (PARTITION BY HireDate) AS FLOAT) / SUM(COUNT(EmployeeID)) OVER () * 100 AS HiredEmployeesPercentage
FROM HR
WHERE HireDate BETWEEN '2022-01-01' AND '2023-12-31'
group by HireDate, EmployeeID
ORDER BY HireDate;

-- •	сравнение с общим количеством отвергнутых сотрудников (в %).
SELECT
   HireDate,
   COUNT(EmployeeID) OVER (PARTITION BY HireDate) AS HiredEmployeesCount,   -- вычисляет количество нанятых сотрудников для каждой даты найма
   CAST(COUNT(CASE WHEN Rejected = 1 THEN 1 ELSE NULL END) OVER (PARTITION BY HireDate) AS FLOAT) /  SUM(COUNT(EmployeeID)) OVER () * 100 AS RejectedEmployeesPercentage
FROM HR
group by HireDate, EmployeeID, Rejected


-- 2. Применение функции ранжирования ROW_NUMBER() для разбиения результатов запроса на страницы (по 20 строк на каждую страницу).
DECLARE @page int = 1;
WITH Rows AS
(
    SELECT *, ROW_NUMBER() OVER (ORDER BY department) AS RowNumber
    FROM Department
)
SELECT * FROM Rows
WHERE RowNumber BETWEEN 21 AND 30 * (@page);


-- 4. Применение функции ранжирования ROW_NUMBER() для удаления дубликатов:
CREATE TABLE TableForTask4 (
    ID INT PRIMARY KEY,
    NAME VARCHAR(50)
);
INSERT INTO TableForTask4 VALUES (1, 'Name_1');
INSERT INTO TableForTask4 VALUES (2, 'Name_2');
INSERT INTO TableForTask4 VALUES (3, 'Name_1');
INSERT INTO TableForTask4 VALUES (4, 'Name_4');
WITH Rows AS
(
  SELECT
    ROW_NUMBER() OVER (PARTITION BY NAME ORDER BY ID) AS RowNumber,
    *
  FROM TableForTask4
)
DELETE FROM Rows WHERE RowNumber > 1;
SELECT * FROM TableForTask4;
DROP TABLE TableForTask4;


-- 5. Вернуть для каждого юридического лица количество принятых сотрудников за последние 6 месяцев помесячно.
SELECT
    c.CompanyName,
    DATEPART(YEAR, h.HireDate) AS HireYear,
    DATEPART(MONTH, h.HireDate) AS HireMonth,
    COUNT(*) OVER (PARTITION BY c.CompanyID, DATEPART(YEAR, h.HireDate), DATEPART(MONTH, h.HireDate)
                   ORDER BY h.HireDate
                   ROWS BETWEEN 5 PRECEDING AND CURRENT ROW) AS HiredEmployees  -- диапазон строк, на которых выполняется агрегатная функция
FROM HR h
INNER JOIN Company c ON h.CompanyID = c.CompanyID
WHERE h.HireDate >= DATEADD(MONTH, -6, GETDATE())
ORDER BY c.CompanyName, HireYear, HireMonth;


-- 6. Какое максимальное количество резюме было предоставлено для получения должности в определенном отделе? Вернуть для всех отделов.
SELECT CompanyID, num_resumes
FROM (
  SELECT d.CompanyID, COUNT(*) AS num_resumes,
         RANK() OVER (PARTITION BY d.CompanyID ORDER BY COUNT(*) DESC) AS rank
  FROM HR h
  INNER JOIN Company d ON h.CompanyID = d.CompanyID
  GROUP BY d.CompanyID
) ranked
WHERE rank = 1;
-- Оконная функция RANK() ранжирует каждый отдел по убыванию количества резюме.
-- Ранг строки равен единице плюс количество рангов, которые предшествуют рассматриваемой строке.