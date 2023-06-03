create database Personnel_Lab_9;
use Personnel_Lab_9;
alter database Personnel_Lab_9 collate Cyrillic_General_CI_AS;
drop table Personal_information;
drop table Official_information;
drop table HR;
drop table Department;
drop table Company;

create table Personal_information(	--������ ����������
 personalNum int constraint personalNum_pk primary key, --�������������� �����
 placeBirth varchar(25),	--����� ��������
 passport varchar(30),		--�������
 address varchar(50),		--����� ����������
 regAddress varchar(50),	--����� �����������
 maritalStat varchar(20),	--�������� ���������
 children int,				--����
 dateBirth varchar(50));	--���� ��������

 create table Department (  --�����
 idDep int not null identity(1,1) constraint idDep_pk primary key,  --������������� ������
 department varchar(50),    --�������� ������
 leader varchar(50),        --���������
 phoneNum varchar(20),     --����� ��������
location geography);

create table Official_information( --��������� ����������
 idEmployee int identity(1,1) constraint idEmployee_pk primary key, --����� ����������
 personalNum int constraint personalNum_FK foreign key references personal_information(personalNum), --�������������� �����
 surname varchar(50),       --�������
 name varchar(50),          --���
 patronymic varchar(50),    --��������
 idDep int constraint idDep_ofInf_FK foreign key references Department(idDep),     --��� �����
 education varchar(50),     --�����������
 experience varchar(50),    --����
 phoneNum varchar(20),      --����� ��������
 salary int,                --��������
 status  varchar(20));      --������ ����������

create table Vacancy(
idVacancy int identity(1,1) constraint idVacancy_pk primary key, --������������� ��������
idDep int constraint idDep_vac_FK foreign key references Department(idDep), --��� ������
salary int, --��������
status varchar(15) NOT NULL CHECK (status IN (N'��������', N'�� ��������')));--������ ��������

CREATE TABLE HR (
   EmployeeID INT PRIMARY KEY,
   EmployeeName VARCHAR(50) NOT NULL,
   HireDate DATE NOT NULL,  -- ���� �����
   Rejected BIT NOT NULL,   -- ���� ���������� ���������
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
  (1, '��� "��� IT"', '�. ������, ��. ������, �. 10', '+7 (495) 123-45-67'),
  (2, '��� "C.Group"', '�. �����-���������, ��. �������, �. 5', '+7 (812) 765-43-21'),
  (3, '��� "�������� �������"', '�. ������������, ��. �������, �. 1', '+7 (343) 555-55-55');


----------------HR-----------------
INSERT INTO HR (EmployeeID, EmployeeName, HireDate, Rejected, CompanyID)
VALUES
  (1, '������ ���� ��������', '2023-01-01', 0, 1),
  (2, '������ ���� ��������', '2023-02-15', 0, 1),
  (3, '�������� ���� �������������', '2023-03-10', 1, 2),
  (4, '������ ������� ���������', '2023-04-05', 0, 3),
  (5, '�������� ����� ����������', '2023-05-02', 0, 1),
  (6, '�������� ����� ���������', '2022-06-15', 1, 2),
  (7, '������ ���� �������������', '2023-01-15', 1, 1),
  (8, '����������� ���� ����������', '2023-01-25', 1, 3),
  (9, '������ ���� ���������', '2023-02-10', 0, 2),
  (10, '������ ����� �����������', '2023-04-04', 1, 3),
  (11, '������ ������ ����������', '2023-03-03', 0, 1);




--------------------------------------------------------------------------------------------------------------------------
-- 1.
-- ���������� ������ ������ HR �� ������������ ������:
-- �	���������� ������� �����������;
SELECT DISTINCT
   HireDate,
   COUNT(EmployeeID) OVER (PARTITION BY HireDate) AS HiredEmployeesCount
FROM HR
WHERE HireDate BETWEEN '2022-01-01' AND '2023-12-31'
ORDER BY HireDate;

-- �	��������� � ����� ����������� ������� ����������� (� %);
SELECT
   HireDate,
   COUNT(EmployeeID) OVER (PARTITION BY HireDate) AS HiredEmployeesCount,
   CAST(COUNT(EmployeeID) OVER (PARTITION BY HireDate) AS FLOAT) / SUM(COUNT(EmployeeID)) OVER () * 100 AS HiredEmployeesPercentage
FROM HR
WHERE HireDate BETWEEN '2022-01-01' AND '2023-12-31'
group by HireDate, EmployeeID
ORDER BY HireDate;

-- �	��������� � ����� ����������� ����������� ����������� (� %).
SELECT
   HireDate,
   COUNT(EmployeeID) OVER (PARTITION BY HireDate) AS HiredEmployeesCount,   -- ��������� ���������� ������� ����������� ��� ������ ���� �����
   CAST(COUNT(CASE WHEN Rejected = 1 THEN 1 ELSE NULL END) OVER (PARTITION BY HireDate) AS FLOAT) /  SUM(COUNT(EmployeeID)) OVER () * 100 AS RejectedEmployeesPercentage
FROM HR
group by HireDate, EmployeeID, Rejected


-- 2. ���������� ������� ������������ ROW_NUMBER() ��� ��������� ����������� ������� �� �������� (�� 20 ����� �� ������ ��������).
DECLARE @page int = 1;
WITH Rows AS
(
    SELECT *, ROW_NUMBER() OVER (ORDER BY department) AS RowNumber
    FROM Department
)
SELECT * FROM Rows
WHERE RowNumber BETWEEN 21 AND 30 * (@page);


-- 4. ���������� ������� ������������ ROW_NUMBER() ��� �������� ����������:
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


-- 5. ������� ��� ������� ������������ ���� ���������� �������� ����������� �� ��������� 6 ������� ���������.
SELECT
    c.CompanyName,
    DATEPART(YEAR, h.HireDate) AS HireYear,
    DATEPART(MONTH, h.HireDate) AS HireMonth,
    COUNT(*) OVER (PARTITION BY c.CompanyID, DATEPART(YEAR, h.HireDate), DATEPART(MONTH, h.HireDate)
                   ORDER BY h.HireDate
                   ROWS BETWEEN 5 PRECEDING AND CURRENT ROW) AS HiredEmployees  -- �������� �����, �� ������� ����������� ���������� �������
FROM HR h
INNER JOIN Company c ON h.CompanyID = c.CompanyID
WHERE h.HireDate >= DATEADD(MONTH, -6, GETDATE())
ORDER BY c.CompanyName, HireYear, HireMonth;


-- 6. ����� ������������ ���������� ������ ���� ������������� ��� ��������� ��������� � ������������ ������? ������� ��� ���� �������.
SELECT CompanyID, num_resumes
FROM (
  SELECT d.CompanyID, COUNT(*) AS num_resumes,
         RANK() OVER (PARTITION BY d.CompanyID ORDER BY COUNT(*) DESC) AS rank
  FROM HR h
  INNER JOIN Company d ON h.CompanyID = d.CompanyID
  GROUP BY d.CompanyID
) ranked
WHERE rank = 1;
-- ������� ������� RANK() ��������� ������ ����� �� �������� ���������� ������.
-- ���� ������ ����� ������� ���� ���������� ������, ������� ������������ ��������������� ������.