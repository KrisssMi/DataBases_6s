create database WebServer;
CREATE LOGIN mylogin WITH PASSWORD = '1234';
CREATE USER User FOR LOGIN mylogin;
create database client1;