--1. �������� ������� Report:
create table Report (
id INTEGER primary key identity(1,1),
xml_column XML
);

select * from Report;


-- 2. ��������� XML:
create procedure generateXML
as
declare @generation XML
set @generation = (select	department [�����],
					passport [�������], 
					GETDATE() [����]
	from Official_information officialInfo
					join Department dep on officialInfo.idDep = dep.idDep
					join Personal_information personalInf on personalInf.personalNum = officialInfo.personalNum
	FOR XML AUTO);
	SELECT @generation
go

execute generateXML;


-- 3. ������� XML � �������:
create procedure InsertReport
as
DECLARE  @insertion XML
SET @insertion = (select department [�����],
					passport [�������], 
					GETDATE() [����]
	from Official_information officialInfo
					join Department dep on officialInfo.idDep = dep.idDep
					join Personal_information personalInfo on personalInfo.personalNum = officialInfo.personalNum
for xml raw);
insert into Report values(@insertion);
go
  
execute InsertReport;
select * from Report;


--4. ������ ��� XML-��������:
create primary xml index IndexOnReport on Report(xml_column);
create xml index xmlIndexS on Report(xml_column) using xml index IndexOnReport for path;


--5. ����������:
create procedure SelectReport
as
select xml_column.query('/row')
	as[xml_column]
	from Report
	for xml auto, type;
go
execute SelectReport;


--drop procedure SelectReport;
--drop procedure InsertReport;
--drop procedure generateXML;
--drop table Report;