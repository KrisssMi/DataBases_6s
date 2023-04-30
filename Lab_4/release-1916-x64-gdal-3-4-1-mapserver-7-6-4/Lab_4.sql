CREATE SPATIAL INDEX MySpatialIndex ON Department(location) USING GEOGRAPHY_GRID;
select location from Department;

begin
    declare @a geography
    declare @b geography
    set @a=(select location from Department where idDep=1)
    set @b=(select location from Department where idDep=2)
    select @a.STIntersection(@b)    -- высчитывает пересечение двух точек
    select @a.STDistance(@b)        -- высчитывает расстояние между двумя точками
    select @a.STDifference(@b)      -- вычитает одну точку из другой
    select @a.STUnion(@b)           -- объединяет две точки в одну
end;


----------------------------------- 1 ---------------------------------------
create database map;
use map;
select * from map;

go
declare @g geometry = geometry::STGeomFromText('Point(0 0)', 0);
select @g.STBuffer(5), @g.STBuffer(5).ToString() as WKT from map;


----------------------------------- 5 -------------------------------------------
begin
    declare @b geography=geography::STPointFromText('POINT(-73.9852 40.7575)', 4326);
    declare @a geography=geography::STPointFromText('POINT(-73.9452 60.7235)', 4326);
    declare @refined geography=@a.STUnion(@b);
    select @refined;
end;