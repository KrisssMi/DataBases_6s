create database ASP;

create table PhoneBook (
    Id int identity(1,1) primary key,
    Name nvarchar(30),
    Phone nvarchar(30)
);

insert into PhoneBook values ('Kristina', '+375447270388');
insert into PhoneBook values ('Natasha', '+375448753765');
insert into PhoneBook values ('Vasya', '+375295530663');
insert into PhoneBook values ('Timofei', '+375333316545');
insert into PhoneBook values ('Dima', '+375442785524');

select * from PhoneBook;