exec sp_configure 'clr enabled', 1;
reconfigure;

exec sp_configure 'show advanced options', 1;
reconfigure;

exec sp_configure 'clr strict security', 0;
reconfigure;
go

ALTER DATABASE Personnel SET TRUSTWORTHY ON


drop procedure WriteToFile;
drop type JobDescription;
drop assembly MyAssembly;


----------------------ASSEMBLY------------------------

CREATE ASSEMBLY MyAssembly FROM 
'F:\__3 курс 1 сем\БД2\Laba_3_Kris\Laba_3_2\bin\Debug\Laba_3_2.dll' 
WITH PERMISSION_SET = UNSAFE;


----------------------PROCEDURE------------------------
CREATE PROCEDURE dbo.WriteToFile
@filename nvarchar(255),
@data nvarchar(MAX)
AS EXTERNAL NAME MyAssembly.[Laba_3_2.StoredProcedure].WriteToFile;

exec dbo.WriteToFile 'F:\L.txt', 'Laba 3';


----------------------TYPE------------------------
CREATE TYPE JobDescription EXTERNAL NAME MyAssembly.[Laba_3_2.JobDescription];

declare @jobDescription as dbo.JobDescription;
set @jobDescription = '+375291111111, qwe';
print @jobDescription.ToString();