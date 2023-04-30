use Personnel;
alter database Personnel collate Cyrillic_General_CI_AS;

------Personal_information------
insert into Personal_information(personalNum, placeBirth, passport, address, regAddress, maritalStat,children,dateBirth)
  values (1, 'г.Минск', '2507697643', 'г.Минск, ул.Кедышко, д.5а, кв.22', 'г.Минск, ул.Кедышко д.5а, кв.22', 'Женат', 2, '19.09.1998');
insert into Personal_information(personalNum, placeBirth, passport, address, regAddress, maritalStat,children,dateBirth)
  values (2, 'г.Минск', '4407697667', 'г.Минск, ул.Ленина, д.18, кв.42', 'г.Минск, ул.Ленина, д.18, кв.42', 'Не женат', 0, '09.03.1992');
insert into Personal_information(personalNum, placeBirth, passport, address, regAddress, maritalStat,children,dateBirth)
  values (3, 'г.Барановичи', '9807697642', 'г.Барановичи, ул.Тельмана, д.169, кв.68', 'г.Барановичи, ул.Тельмана, д.169, кв.68', 'Не замужем', 0, '29.01.2003');
insert into Personal_information(personalNum, placeBirth, passport, address, regAddress, maritalStat,children,dateBirth)
  values (4, 'г.Брест', '2107697343', 'г.Брест, ул.Белорусская, д.21, кв.712', 'г.Брест, ул.Белорусская, д.21, кв.712', 'Замужем', 1, '01.02.2002');
insert into Personal_information(personalNum, placeBirth, passport, address, regAddress, maritalStat,children,dateBirth)
    values (5, 'г.Минск', '2507697643', 'г.Минск, ул.Пушкина, д.88, кв.1', 'г.Минск, ул.Пушкина, д.88, кв.1', 'Женат', 2, '19.09.1998');
insert into Personal_information(personalNum, placeBirth, passport, address, regAddress, maritalStat,children,dateBirth)
    values (6, 'г.Минск', '4407697667', 'г.Минск, ул.Ленина, д.18, кв.42', 'г.Минск, ул.Ленина, д.18, кв.42', 'Не женат', 0, '09.03.1992');
insert into Personal_information(personalNum, placeBirth, passport, address, regAddress, maritalStat,children,dateBirth)
    values (7, 'г.Барановичи', '9807697642', 'г.Барановичи, ул.Тельмана, д.169, кв.68', 'г.Барановичи, ул.Тельмана, д.169, кв.68', 'Не замужем', 0, '29.01.2003');
insert into Personal_information(personalNum, placeBirth, passport, address, regAddress, maritalStat,children,dateBirth)
    values (8, 'г.Брест', '2107697343', 'г.Брест, ул.Белорусская, д.21, кв.712', 'г.Брест, ул.Белорусская, д.21, кв.712', 'Замужем', 1, '01.02.2002');
insert into Personal_information(personalNum, placeBirth, passport, address, regAddress, maritalStat,children,dateBirth)
    values (9, 'г.Минск', '2507697643', 'г.Минск, ул.Пушкина, д.88, кв.1', 'г.Минск, ул.Пушкина, д.88, кв.1', 'Женат', 2, '19.09.1998');
insert into Personal_information(personalNum, placeBirth, passport, address, regAddress, maritalStat,children,dateBirth)
    values (10, 'г.Минск', '4407697667', 'г.Минск, ул.Ленина, д.18, кв.42', 'г.Минск, ул.Ленина, д.18, кв.42', 'Не женат', 0, '09.03.1992');
insert into Personal_information(personalNum, placeBirth, passport, address, regAddress, maritalStat,children,dateBirth)
    values (11, 'г.Барановичи', '9807697642', 'г.Барановичи, ул.Тельмана, д.169, кв.68', 'г.Барановичи, ул.Тельмана, д.169, кв.68', 'Не замужем', 0, '29.01.2003');
insert into Personal_information(personalNum, placeBirth, passport, address, regAddress, maritalStat,children,dateBirth)
    values (12, 'г.Брест', '2107697343', 'г.Брест, ул.Белорусская, д.21, кв.712', 'г.Брест, ул.Белорусская, д.21, кв.712', 'Замужем', 1, '01.02.2002');
insert into Personal_information(personalNum, placeBirth, passport, address, regAddress, maritalStat,children,dateBirth)
    values (13, 'г.Минск', '2507697643', 'г.Минск, ул.Пушкина, д.88, кв.1', 'г.Минск, ул.Пушкина, д.88, кв.1', 'Женат', 2, '19.09.1998');
insert into Personal_information(personalNum, placeBirth, passport, address, regAddress, maritalStat,children,dateBirth)
    values (14, 'г.Минск', '4407697667', 'г.Минск, ул.Ленина, д.18, кв.42', 'г.Минск, ул.Ленина, д.18, кв.42', 'Не женат', 0, '09.03.1992');

------Department------
insert into Department (department, leader, phoneNum)
  values ('Коммерческий отдел', 'Войтов Антон Иванович', '327-09-07');
insert into Department (department, leader, phoneNum)
  values ('Отдел транспорта и логистики', 'Николаев Иван Олегович', '445-76-05');
insert into Department (department, leader, phoneNum)
  values ('Отдел финансового контроля', 'Полянская Ольга Николаевна', '875-01-34');
insert into Department (department, leader, phoneNum)
  values ('Отдел маркетинга', 'Кротов Александр Викентьевич', '121-07-32');
insert into Department (department, leader, phoneNum)
    values ('Отдел кадров', 'Кузнецова Анна Александровна', '123-45-67');
insert into Department (department, leader, phoneNum)
    values ('Отдел закупок', 'Погорелова Юлия Андреевна', '126-41-87');
insert into Department (department, leader, phoneNum)
    values ('Отдел продаж', 'Некрасова Регина Олеговна', '983-25-78');


insert into Department(department, leader, phoneNum, location) values ('Sales', 'John Smith', '555-555-5555', geography::STGeomFromText('POINT(-73.9814 40.7648)', 4326));
insert into Department(department, leader, phoneNum, location) values ('Marketing', 'Jane Doe', '555-555-5555', geography::STGeomFromText('POINT(-74.0060 40.7395)', 4326));
insert into Department(department, leader, phoneNum, location) values ('Engineering', 'John Doe', '555-555-5555', geography::STGeomFromText('POINT(-122.362 47.658)', 4326));
insert into Department(department, leader, phoneNum, location) values ('Accounting', 'Jane Smith', '555-555-5555', geography::STGeomFromText('POINT(-122.363 47.659)', 4326));
insert into Department(department, leader, phoneNum, location) values ('Human Resources', 'John Smith', '555-555-5555', geography::STGeomFromText('POINT(-122.364 47.660)', 4326));
insert into Department(department, leader, phoneNum, location) values ('Legal', 'Jane Doe', '555-555-5555', geography::STGeomFromText('POINT(-122.365 47.661)', 4326));
insert into Department(department, leader, phoneNum, location) values ('IT', 'John Doe', '555-555-5555', geography::STGeomFromText('POINT(-122.366 47.662)', 4326));
insert into Department(department, leader, phoneNum, location) values ('Facilities', 'Jane Smith', '555-555-5555', geography::STGeomFromText('POINT(-122.367 47.663)', 4326));
insert into Department(department, leader, phoneNum, location) values ('Executive', 'John Smith', '555-555-5555', geography::STGeomFromText('POINT(-122.368 47.664)', 4326));
insert into Department(department, leader, phoneNum, location) values ('Finance', 'Jane Doe', '555-555-5555', geography::STGeomFromText('POINT(-122.369 47.665)', 4326));
insert into Department(department, leader, phoneNum, location) values ('Operations', 'John Doe', '555-555-5555', geography::STGeomFromText('POINT(-122.370 47.666)', 4326));
insert into Department(department, leader, phoneNum, location) values ('Customer Service', 'Jane Smith', '555-555-5555', geography::STGeomFromText('POINT(-122.371 47.667)', 4326));
insert into Department(department, leader, phoneNum, location) values ('Research', 'John Smith', '555-555-5555', geography::STGeomFromText('POINT(-122.372 47.668)', 4326));
insert into Department(department, leader, phoneNum, location) values ('Quality Assurance', 'Jane Doe', '555-555-5555', geography::STGeomFromText('POINT(-122.373 47.669)', 4326));
insert into Department(department, leader, phoneNum, location) values ('Training', 'John Doe', '555-555-5555', geography::STGeomFromText('POINT(-122.374 47.670)', 4326));
insert into Department(department, leader, phoneNum, location) values ('Purchasing', 'Jane Smith', '555-555-5555', geography::STGeomFromText('POINT(-122.375 47.671)', 4326));
insert into Department(department, leader, phoneNum, location) values ('Shipping', 'John Smith', '555-555-5555', geography::STGeomFromText('POINT(-122.376 47.672)', 4326));
insert into Department(department, leader, phoneNum, location) values ('Receiving', 'Jane Doe', '555-555-5555', geography::STGeomFromText('POINT(-122.377 47.673)', 4326));
insert into Department(department, leader, phoneNum, location) values ('Inventory', 'John Doe', '555-555-5555', geography::STGeomFromText('POINT(-122.378 47.674)', 4326));
insert into Department(department, leader, phoneNum, location) values ('Maintenance', 'Jane Smith', '555-555-5555', geography::STGeomFromText('POINT(-122.379 47.675)', 4326));
insert into Department(department, leader, phoneNum, location) values ('Security', 'John Smith', '555-555-5555', geography::STGeomFromText('POINT(-122.380 47.676)', 4326));
insert into Department(department, leader, phoneNum, location) values ('Safety', 'Jane Doe', '555-555-5555', geography::STGeomFromText('POINT(-122.381 47.677)', 4326));
insert into Department(department, leader, phoneNum, location) values ('Production', 'John Doe', '555-555-5555', geography::STGeomFromText('POINT(-122.382 47.678)', 4326));
insert into Department(department, leader, phoneNum, location) values ('Manufacturing', 'Jane Smith', '555-555-5555', geography::STGeomFromText('POINT(-122.383 47.679)', 4326));
insert into Department(department, leader, phoneNum, location) values ('Distribution', 'John Smith', '555-555-5555', geography::STGeomFromText('POINT(-122.384 47.680)', 4326));
insert into Department(department, leader, phoneNum, location) values ('Logistics', 'Jane Doe', '555-555-5555', geography::STGeomFromText('POINT(-122.385 47.681)', 4326));
insert into Department(department, leader, phoneNum, location) values ('Supply Chain', 'John Doe', '555-555-5555', geography::STGeomFromText('POINT(-122.386 47.682)', 4326));
insert into Department(department, leader, phoneNum, location) values ('Warehouse', 'Jane Smith', '555-555-5555', geography::STGeomFromText('POINT(-122.387 47.683)', 4326));


------Position------
-- insert into Position (position) values ('Руководитель отдела');
-- insert into Position (position) values ('Менеджер по продажам');
-- insert into Position (position) values ('Финансовый аналитик');
-- insert into Position (position) values ('Инженер-программист');
-- insert into Position (position) values ('Учитель');
-- insert into Position (position) values ('Врач');

------Specialty------
-- insert into  Specialty (specialty) values ('Маркетолог');
-- insert into  Specialty (specialty) values ('Экономист');
-- insert into  Specialty (specialty) values ('Веб-дизайнер');
-- insert into  Specialty (specialty) values ('Разработчик');
-- insert into  Specialty (specialty) values ('Терапевт');
-- insert into  Specialty (specialty) values ('Диспетчер');
-- insert into  Specialty (specialty) values ('Кассир');
-- insert into  Specialty (specialty) values ('Юрист');
-- insert into  Specialty (specialty) values ('Специалист по закупкам');
-- insert into  Specialty (specialty) values ('Специалист по продажам');

------Official_information------
insert into Official_information (personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary, status)
    values (1, 'Иванов', 'Иван', 'Иванович', 1, 'Высшее','5 лет', '80(29)192-34-98', 2000, 'Работает');
insert into Official_information (personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary, status)
    values (2, 'Петров', 'Петр', 'Петрович', 13, 'Высшее', '4 года', '80(29)679-22-58', 1800, 'Работает');
insert into Official_information (personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary, status)
    values (3, 'Полякова', 'Анна', 'Семеновна', 20, 'Средне-специальное', '3 года', '80(44)231-00-12', 800, 'Не работает');
insert into Official_information (personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary, status)
    values (4, 'Шуляк', 'Карина', 'Андреевна', 23, 'Высшее', '7 лет', '80(44)873-10-39', 1300, 'Работает');
insert into Official_information (personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary, status)
    values (5, 'Адамов', 'Илья', 'Александрович', 13, 'Средне-специальное', '2 года', '80(29)812-45-23', 600, 'Не работает');
insert into Official_information (personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary, status)
    values (6, 'Кузнецов', 'Александр', 'Александрович', 1, 'Высшее', '5 лет', '80(29)192-34-98', 2000, 'Работает');
insert into Official_information (personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary, status)
    values (7, 'Сидоров', 'Алексей', 'Алексеевич', 13, 'Высшее', '4 года', '80(29)679-22-58', 1800, 'Работает');
insert into Official_information (personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary, status)
    values (8, 'Смирнова', 'Анна', 'Семеновна', 20, 'Средне-специальное', '3 года', '80(44)231-00-12', 800, 'Не работает');
insert into Official_information (personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary, status)
    values (9, 'Кузьмина', 'Карина', 'Андреевна', 23, 'Высшее', '7 лет', '80(44)873-10-39', 1300, 'Работает');
insert into Official_information (personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary, status)
    values (10, 'Кузнецова', 'Анна', 'Александровна', 13, 'Средне-специальное', '2 года', '80(29)812-45-23', 600, 'Не работает');
insert into Official_information (personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary, status)
    values (11, 'Иванов', 'Иван', 'Иванович', 1, 'Высшее','5 лет', '80(29)192-34-98', 2000, 'Работает');
insert into Official_information (personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary, status)
    values (12, 'Петров', 'Петр', 'Петрович', 13, 'Высшее', '4 года', '80(29)679-22-58', 1800, 'Работает');
insert into Official_information (personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary, status)
    values (13, 'Сидорова', 'Анна', 'Семеновна', 20, 'Средне-специальное', '3 года', '80(44)231-00-12', 800, 'Не работает');
insert into Official_information (personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary, status)
    values (14, 'Кузьмина', 'Карина', 'Андреевна', 23, 'Высшее', '7 лет', '80(44)873-10-39', 1300, 'Работает');

------Vacancy------
insert into Vacancy(idDep, salary, status) values ( 1, 1000, 'Доступно');
insert into Vacancy(idDep, salary, status) values ( 12, 1800, N'Не доступно');
insert into Vacancy(idDep, salary, status) values ( 13, 1700, N'Доступно');
insert into Vacancy(idDep, salary, status) values ( 24, 1100, N'Не доступно');
insert into Vacancy(idDep, salary, status) values ( 11, 2000, N'Доступно');
insert into Vacancy(idDep, salary, status) values ( 22, 1500, N'Не доступно');
insert into Vacancy(idDep, salary, status) values ( 23, 1670, N'Доступно');
insert into Vacancy(idDep, salary, status) values ( 14, 1200, N'Не доступно');
insert into Vacancy(idDep, salary, status) values ( 15, 1300, N'Доступно');
insert into Vacancy(idDep, salary, status) values ( 16, 1400, N'Не доступно');
insert into Vacancy(idDep, salary, status) values ( 17, 1600, N'Доступно');
insert into Vacancy(idDep, salary, status) values ( 18, 1700, N'Не доступно');
insert into Vacancy(idDep, salary, status) values ( 19, 1800, N'Доступно');
insert into Vacancy(idDep, salary, status) values ( 20, 1900, N'Не доступно');
insert into Vacancy(idDep, salary, status) values ( 21, 2000, N'Доступно');

--insert into Vacancy(idVacancy, idDep, idPost, idSpec, salary, status) values (2, 1, 1, 3, 700, N'Не доступно');
--insert into Vacancy(idVacancy, idDep, idPost, idSpec, salary, status) values (3, 2, 1, 1, 1100, N'Доступно');
--insert into Vacancy(idVacancy, idDep, idPost, idSpec, salary, status) values (4, 2, 1, 1, 950, N'Не доступно');
--insert into Vacancy(idVacancy, idDep, idPost, idSpec, salary, status) values (5, 3, 1, 2, 1250, N'Доступно');
--insert into Vacancy(idVacancy, idDep, idPost, idSpec, salary, status) values (6, 2, 4, 3, 1000, N'Не доступно');
--insert into Vacancy(idVacancy, idDep, idPost, idSpec, salary, status) values (7, 3, 1, 2, 700, N'Не доступно');
--insert into Vacancy(idVacancy, idDep, idPost, idSpec, salary, status) values (8, 1, 2, 3, 1950, N'Доступно');
--insert into Vacancy(idVacancy, idDep, idPost, idSpec, salary, status) values (9, 2, 4, 2, 2000, N'Не доступно');
--insert into Vacancy(idVacancy, idDep, idPost, idSpec, salary, status) values (10, 4, 3, 2, 1050, N'Доступно');
--insert into Vacancy(idVacancy, idDep, idPost, idSpec, salary, status) values (11, 3, 3, 3, 1300, N'Не доступно');


------Official_information------
insert into Official_information (idEmployee, personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary, status)
    values (14376298, 1, 'Иванов', 'Иван', 'Иванович', 1, 'Высшее', '5 лет', '80(29)192-34-98', 2000, 'Работает');
insert into Official_information (idEmployee, personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary, status)
    values (16581963, 2, 'Петров', 'Петр', 'Петрович', 1,'Высшее', '4 года', '80(29)679-22-58', 1800, 'Работает');
insert into Official_information (idEmployee, personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary, status)
    values (14572945, 3, 'Полякова', 'Анна', 'Семеновна', 2, 'Средне-специальное', '3 года', '80(44)231-00-12', 800, 'Не работает');
insert into Official_information (idEmployee, personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary, status)
    values (18572523, 4, 'Шуляк', 'Карина', 'Андреевна', 2, 'Высшее', '7 лет', '80(44)873-10-39', 1300, 'Работает');
insert into Official_information (idEmployee, personalNum, surname, name, patronymic, idDep, education, experience, phoneNum, salary, status)
    values (16682934, 5, 'Адамов', 'Илья', 'Александрович', 3, 'Средне-специальное', '2 года', '80(29)812-45-23', 600, 'Не работает');
