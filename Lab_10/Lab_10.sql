-- 1. Показать и объяснить, какой режим аутентификации используется для экземпляра SQL Server.


-- 2. Создать необходимые учетные записи, роли и пользователей. Объяснить назначение привилегий.
	create Login Kristina_M with password='Kristina29';	--логин
	create user Kristina_User for login Kristina_M;		--привязка пользователя к логину
	create user JustUser without login;					--пользователь
	create role user_role;								--роль

-- привилегии:
	grant select, insert, update, delete on orders to user_role;
	revoke update on orders from user_role;
	EXEC sp_addrolemember @rolename = 'user_role', @membername = 'Kristina_User';


-- 3. Продемонстрируйте заимствование прав для любой процедуры в базе данных.
	create login Masha with password = 'Mashaaa01';
	create login Sasha with password = 'Sashaaa02';
	create user Masha for login Masha;
	create user Sasha for login Sasha;

	exec sp_addrolemember 'db_datareader', 'Masha';
	exec sp_addrolemember 'db_ddladmin', 'Masha';
	deny select on orders to Sasha;
	go 
	create procedure Us_GetOrders 
		with execute as 'Masha'
		as select * from Orders;

	alter authorization on Us_GetOrders to Masha;
	grant execute on Us_GetOrders to Sasha;
	
	--
	setuser 'Sasha';
	exec Us_GetOrders;
	select * from orders;
	setuser;


-- 4. Создать для экземпляра SQL Server объект аудита.
use master;
go

create server audit Audit 
	to file(
		filepath = '/opt/mssql/bin',
		maxsize = 10 mb,
		max_rollover_files = 0,
		reserve_disk_space = off
	) with ( queue_delay = 1000, on_failure = continue);

create server audit PAudit to application_log;
create server audit AAudit to security_log;

select * from sys.server_audits;

drop server audit PAudit;
drop server audit AAudit;
drop server audit Audit;
-------------------------------------------------------

-- 5. Задать для серверного аудита необходимые спецификации.
	create server audit specification ServerAuditSpecification
		for server audit Audit
		add (database_change_group)
		with (state=on)

-- Delete the server audit specification
DROP SERVER AUDIT SPECIFICATION [ServerAuditSpecification];
GO



-- 6. Запустить серверный аудит, продемонстрировать журнал аудита.
	alter server audit Audit with (state=on);

	create database primer;
	drop database primer;
	go

	select statement from fn_get_audit_file('/opt/mssql/bin/Audit_050F8722-F7E3-472C-BB66-B3606141C176_0_133293855538270000.sqlaudit', null, null);	


-- 7-9. Создать необходимые объекты аудита.
use Personnel;
go
	create database audit specification DatabaseAuditSpecification
		for server audit Audit
		add (insert on [Personnel].dbo.Department by dbo)
		with (state=on);

	select * from [Personnel].dbo.Department;
	insert into  [Personnel].dbo.Department(department) values ('NewDep');
go

select statement from fn_get_audit_file('/opt/mssql/bin/Audit_050F8722-F7E3-472C-BB66-B3606141C176_0_133293855538270000.sqlaudit', null, null);	



--10. Остановить аудит БД и сервера
	alter server audit CAudit with (state=off);
	alter server audit PAudit with (state=off);
	alter server audit AAudit with (state=off);


-- 11. Создать для экземпляра SQL Server ассиметричный ключ шифрования
use [Personnel];
create asymmetric key AsymmetricKey
	with algorithm = rsa_2048
	encryption by password = 'passAsymm!';


-- 12. Зашифровать и расшифровать данные при помощи этого ключа.
declare @opentext nvarchar(25);
declare @encryptedtext nvarchar (256);

set @opentext = 'Encrypted text';
print @opentext;

set @encryptedtext = EncryptByAsymKey(AsymKey_ID('AsymmetricKey'), @opentext);
print @encryptedtext;

set @opentext = DecryptByAsymKey(AsymKey_ID('AsymmetricKey'), @encryptedtext, N'passAsymm!');
print @opentext;


-- 13. Создать для экземпляра SQL Server сертификат.
use [Personnel];
go
create certificate TestCert5
	encryption by password = N'pa$$W0RD'
		with subject = N'Sample Certificate',
	expiry_date = N'2023-12-31';

DROP DATABASE ENCRYPTION KEY;
DROP CERTIFICATE TestCert5;


-- 14. Зашифровать и расшифровать данные при помощи этого сертификата.
declare @open_text nvarchar(50);
set @open_text = 'Encrypted text with certificate';
print @open_text;

declare @encr_text nvarchar(256);
set @encr_text = EncryptByCert(Cert_ID('TestCert5'), @open_text);
print @encr_text;

set @open_text = CAST(DecryptByCert(Cert_ID('TestCert5'), @encr_text, N'pa$$W0RD') as nvarchar(50));
print @open_text;


-- 15. Создать для экземпляра SQL Server симметричный ключ шифрования данных.
use [Personnel];
create symmetric key EKey
with algorithm = AES_256
encryption by password = N'pa$$W0RD';

open symmetric key EKey
decryption by password = N'pa$$W0RD';

create symmetric key DKey
with algorithm = AES_256
encryption by symmetric key EKey;

open symmetric key DKey
decryption by symmetric key EKey;


-- 16. Зашифровать и расшифровать данные при помощи этого ключа.
declare @openn_text nvarchar(512);
set @openn_text = 'Encrypted text with symmetric key';
print @openn_text;

declare @encri_text nvarchar(1024);
set @encri_text = EncryptByKey(Key_GUID('DKey'), @openn_text);
print @encri_text;

set @openn_text = CAST(DecryptByKey(@encri_text) as nvarchar(512));
print @openn_text;

close symmetric key EKey;
close symmetric key DKey;


-- 17. Продемонстрировать прозрачное шифрование базы данных.
use master;
go

create master key encryption by password = 'pa$$w@rD';
go

create certificate transparent
	with subject = 'Certificate to encrypt [Personnel] DB ', 
	expiry_date = '2023-12-31';
go

use [Personnel];
go

create database encryption key
with algorithm = AES_256
encryption by server certificate transparent;
go

alter database [Personnel] 
set encryption on;
go

select encryption_state from sys.dm_database_encryption_keys;

alter database [Personnel] 
set encryption off;
go


-- 18. Продемонстрировать применение хэширования.
select HashBytes('SHA1', 'Demonstration of the use of hashing in a database') as SHA1;
select HashBytes('MD4', 'Demonstration of the use of hashing in a database') as MD4;
select HashBytes('MD5', 'Demonstration of the use of hashing in a database') as MD5;


-- 19. Продемонстрировать применение ЭЦП при помощи сертификата.
	--подписывает текст сертификатом и возвращает подпись
	use [Personnel];
	select * from sys.certificates;

	-- подписываем
	select SIGNBYCERT(257, N'Kristina29', N'pa$$W0RD') as ЭЦП;	--сертификат	

	--0 - изменены, 1 - не изменены
	select VERIFYSIGNEDBYCERT(257, 'Kristina29', 0x0100070204000000C6CC7B56F261DBEEBB9DCAD9F2A1973C535EBB261966996EDF7770BFA2B9AC92B7839F55EBC55F7ADCBE56247F2D28CB7B41E85D487E3046BF288EFAF4D3BA4C9FEF751B0BEA23573AA852FBCC3E13D7760A18FC26C5765C45AA6D767DAABEA33B16DE680BAFD4B2EE22DABAF329194564C70426E8C956CF4B4B8476444BB2672B112EB6270D4D966CF14184C4549546A2F5FCDBF3D47015D4F2CCA5168FC989BB3024A27E13BD98D1B413F1B634C93C9D2C4E1CED83B498BA569C6E5C63B98D26A42572047CAA7787A3CE6251D1E7CAA29F6D08D5DE7417DBDBA31BCE33B38D829018796DDBFD1449225ED8D93EF1C66FFDF2B3674288ACB24CE5A5F945AA142569F233B15C39FCAAA26369F00B1CCFE17E2809A7515FA2D31E8CED21D7DF88E864C085413E798DA11B92E13DEC4CDC2B296589DB18F5EC4A578CEF15CE8D249445A4D53683AD38094C929D8BAB59E54162081DB87D58D8E8601BFAD99B936CFF0C02F1211EA6D8E324A81C1FC61B47B70446616E37F89715EC4D283ED92B61);
	

-- 20. Сделать резервную копию необходимых ключей и сертификатов. (!)
backup certificate TestCert5
	to file = N'/opt/mssql/bin/BackupTestCert5.cer'
		with private key(
			file = N'/opt/mssql/bin/BackupTestCert5.pvk',
			encryption by password = N'pa$$W0RD',
			decryption by password = N'pa$$W0RD');

use master;
BACKUP MASTER KEY TO FILE = '/opt/mssql/bin\BackupMasterKey.key'
        ENCRYPTION BY PASSWORD = 'p@$$wOrd';