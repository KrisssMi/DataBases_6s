-- 1 --
create table report
(
    id number generated always as identity,
    xml_col xmltype,
    constraint report_pk primary key (id)
);
select * from report;
drop table report;

-- 2 --
CREATE OR REPLACE PROCEDURE generate_xml
AS
    xml_col XMLTYPE;
BEGIN
    SELECT XMLELEMENT("report",
                      XMLELEMENT("total", (SELECT SUM(salary) FROM Official_information)),
                      XMLELEMENT("report_date", SYSDATE),
                      XMLELEMENT("employees",
                                 XMLAGG(XMLELEMENT("employee",
                                            XMLFOREST(oi.personalNum AS "personalNum",
                                                      oi.surname AS "surname",
                                                      oi.name AS "name",
                                                      oi.patronymic AS "patronymic",
                                                      d.department AS "department",
                                                      oi.education AS "education",
                                                      oi.experience AS "experience",
                                                      oi.salary AS "salary",
                                                      oi.status AS "status")
                                            )
                                 )
                      )
    )
    INTO xml_col
    FROM Official_information oi
             INNER JOIN Department d ON oi.idDep = d.idDep
    GROUP BY oi.personalNum, oi.surname, oi.name, oi.patronymic, d.department, oi.education, oi.experience, oi.salary, oi.status;

    INSERT INTO report (xml_col) VALUES (xml_col);
EXCEPTION
    WHEN OTHERS THEN
        -- Обработка ошибок
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
        RAISE;
END;

begin
    generate_xml;
END;

select * from report;
select * from OFFICIAL_INFORMATION;
select * from PERSONAL_INFORMATION;
select * from VACANCY;
select * from DEPARTMENT;


-- 4 --
create index report_xml_idx on report (xml_col) indextype is XDB.XMLIndex;

--test the index in oracle
SELECT *
FROM report
WHERE XMLExists('/report[total=100]' PASSING xml_col);


-- 5 --
create or replace procedure extract_xml_value(p_report_id int, p_xpath varchar2)
as
    xml_col xmltype;
    xml_val varchar2(100);
begin
    select xml_col
    into xml_col
    from report
    where id = p_report_id;

    select to_char(xml_col.extract('//report/' || p_xpath).getclobval())
    into xml_val
    from dual;

    dbms_output.put_line(xml_val);
end extract_xml_value;

begin
    extract_xml_value(1, 'total');
end;