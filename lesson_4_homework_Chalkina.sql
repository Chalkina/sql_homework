--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3)
--Компьютерная фирма: Вывести список всех продуктов и производителя с указанием типа продукта (pc, printer, laptop). 
--Вывести: model, maker, type
select model, maker, type
from product

--task14 (lesson3)
--Компьютерная фирма: При выводе всех значений из таблицы printer дополнительно вывести для тех, 
--у кого цена вышей средней PC - "1", у остальных - "0"

select *,
  case when price > avg(price) then 1
  when price <= avg(price) then 0 
  end flag
  from printer
  group by code, model, color, type, price
  
--task15 (lesson3)
--Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL)
select class, name, launched 
from ships
where class is null
--task16 (lesson3)
--Корабли: Укажите сражения, которые произошли в годы, не совпадающие ни с одним из годов спуска кораблей на воду.
  
with q1 as (
select name, extract(year from date) as year 
from battles 
)
select *
from q1 
where year not in (select launched
      from ships
      where launched is not null)

--task17 (lesson3)
--Корабли: Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships.
select distinct battle from outcomes
where ship in (select name
               from ships
               where class = 'kongo')
--task1  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_300) для всех товаров (pc, printer, laptop) с флагом, 
--если стоимость больше > 300. Во view три колонки: model, price, flag
create view all_products_flag_300 as 

select *,
case when price > 300 then 1
  else 0 
  end flag
from (

select product.model, price  
from pc 
join product 
on pc.model = product.model 

union all 
select product.model, price   
from printer 
join product 
on printer.model = product.model 

union all 
select product.model, price   
from laptop 
join product 
on laptop.model = product.model 
) a 
group by model, price, flag; 

--task2  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_avg_price) для всех товаров (pc, printer, laptop) с флагом, 
--если стоимость больше cредней . Во view три колонки: model, price, flag
create view all_products_flag_avg_price as 

with tab_1 as (
select product.model, price  
from pc 
join product 
on pc.model = product.model 
  
union all 
select product.model, price   
from printer 
join product 
on printer.model = product.model 
  
union all 
select product.model, price   
from laptop 
join product 
on laptop.model = product.model
)
select model, price,
case when price > (select avg(price) from tab_1) then 1 else 0 end flag from tab_1
   
--task3  (lesson4)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'. 
--Вывести model

with tab_2 as (
select product.model, price  
from pc 
join product 
on pc.model = product.model 
where maker = 'D' and maker = 'C'  
union all 
select product.model, price   
from printer 
join product 
on printer.model = product.model 
  
union all 
select product.model, price   
from laptop 
join product 
on laptop.model = product.model
)
select model,
case when price > (select avg(price) from tab_2) then 1 else 0 end flag from tab_2


--task4 (lesson4)
-- Компьютерная фирма: Вывести все товары производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'. 
--Вывести model

with tab_2 as (
select product.model, price  
from pc 
join product 
on pc.model = product.model 
where maker = 'D' and maker = 'C'  

union all 
select product.model, price   
from printer 
join product 
on printer.model = product.model 
  
union all 
select product.model, price   
from laptop 
join product 
on laptop.model = product.model
)
select model,
case when price > (select avg(price) from tab_2) then 1 else 0 end flag from tab_2
--task5 (lesson4)
-- Компьютерная фирма: Какая средняя цена среди уникальных продуктов производителя = 'A' (printer & laptop & pc)
with tab_3 as
(
    select price, product.maker 
    from PC 
    join product
    on pc.model = product.model
    where maker = 'A'
  union 
    select price, product.maker
    from printer 
    join product
    on printer.model = product.model 
    where maker = 'A'
  union 
    select price, product.maker
    from laptop 
    join product
    on laptop.model = product.model
    where maker = 'A'
)  
select maker, price,
case when price > (select avg(price) from tab_3) then 1 else 0 end flag from tab_3
--task6 (lesson4)
-- Компьютерная фирма: Сделать view с количеством товаров (название count_products_by_makers) по каждому производителю. 
--Во view: maker, count
create view count_products_by_makers as 

SELECT count(*), type, maker
FROM product 
GROUP BY type, maker 
--task7 (lesson4)
-- По предыдущему view (count_products_by_makers) сделать график в colab (X: maker, y: count)
--- построено в Colab
---https://github.com/Chalkina/sql_homework/blob/main/lesson4_task7_count_products_by_makers.ipynb
--task8 (lesson4)
-- Компьютерная фирма: Сделать копию таблицы printer (название printer_updated) и удалить из нее все принтеры производителя 'D'
create table printer_updated as

select product.model, price   
from pc 
join product 
on pc.model = product.model 
where maker not like 'D'
union all 
select product.model, price   
from printer 
join product 
on printer.model = product.model 
where maker not like 'D'
union all 
select product.model, price   
from laptop 
join product 
on laptop.model = product.model 
where maker not like 'D' ; 

--task9 (lesson4)
-- Компьютерная фирма: Сделать на базе таблицы (printer_updated) view с дополнительной колонкой производителя 
--(название printer_updated_with_makers)
create view printer_updated_with_makers as 
select*
from
(insert into printer_updated
values('maker'));

--task10 (lesson4)
-- Корабли: Сделать view c количеством потопленных кораблей и классом корабля (название sunk_ships_by_classes). 
--Во view: count, class (если значения класса нет/IS NULL, то заменить на 0)
create view sunk_ships_by_classes as

SELECT aa.class, SUM(aa.sunks) Sunks 
FROM (

SELECT c.class, COUNT(a.ship) sunks 
FROM Outcomes a INNER JOIN 
Ships b ON a.ship = b.name INNER JOIN 
Classes c ON b.class = c.class
WHERE a.result = 'sunk'
GROUP BY c.class
UNION

SELECT c.class, COUNT(a.ship)
FROM Outcomes a INNER JOIN 
Classes c ON a.ship = c.class
WHERE a.result = 'sunk'
GROUP BY c.class
UNION

SELECT c.class, 0 
FROM Classes c
) aa
GROUP BY aa.class;

--task11 (lesson4)
-- Корабли: По предыдущему view (sunk_ships_by_classes) сделать график в colab (X: class, Y: count)
---построено в Colab
--https://github.com/Chalkina/sql_homework/blob/main/lesson4_sunks.ipynb
--task12 (lesson4)
-- Корабли: Сделать копию таблицы classes (название classes_with_flag) и добавить в нее flag: 
--если количество орудий больше или равно 9 - то 1, иначе 0
create table classes_with_flag AS
select*,
 case when numGuns >= 9 then 1
 else 0
 end flag
 from classes
--task13 (lesson4)
-- Корабли: Сделать график в colab по таблице classes с количеством классов по странам (X: country, Y: count)
--построено в Colab
 --https://github.com/Chalkina/sql_homework/commit/42ba894f571663192a7050a503f6b47c928b445d
 create view total_classes as

SELECT country,
        COUNT(*) AS total,
        SUM(CASE WHEN class = 'Tennessee' THEN 1 ELSE 0 END) AS Tennessee,
        SUM(CASE WHEN class = 'Yamato' THEN 1 ELSE 0 END) AS Yamato,
        SUM(CASE WHEN class = 'Renown' THEN 1 ELSE 0 END) AS Renown,
        SUM(CASE WHEN class = 'Revenge' THEN 1 ELSE 0 END) AS Revenge,
        SUM(CASE WHEN class = 'Kongo' THEN 1 ELSE 0 END) AS Kongo,
        SUM(CASE WHEN class = 'Bismarck' THEN 1 ELSE 0 END) AS Bismarck,
        SUM(CASE WHEN class = 'Iowa' THEN 1 ELSE 0 END) AS Iowa, 
        SUM(CASE WHEN class = 'North Carolina' THEN 1 ELSE 0 END) AS North_Carolina
from classes
GROUP by country;
 
--task14 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название начинается с буквы "O" или "M".

select*, 
  case 
  when name like 'O%' then 2
  when name like 'M%' THEN 1 ELSE 0 END count_name
  from ships
--task15 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название состоит из двух слов.

SELECT name,
        COUNT(*) AS total,
        SUM(CASE WHEN name like '% %' THEN 1 ELSE 0 END) AS Te
from ships
GROUP by name;
--task16 (lesson4)
-- Корабли: Построить график с количеством запущенных на воду кораблей и годом запуска (X: year, Y: count)
--построен в Colab https://github.com/Chalkina/sql_homework/blob/main/lesson4_task16_count_launched.ipynb
 create view count_launched as

select count(*), launched 
from (
select name, launched
from ships) a
group by launched;

--task10 (lesson4)
-- Компьютерная фирма: На базе products_price_categories_with_makers построить по каждому производителю график (X: category_price, Y: count)
--построено в Colab https://github.com/Chalkina/sql_homework/blob/main/lesson4_task10_products_price_categories_with_makers.ipynb
--task11 (lesson4)
-- Компьютерная фирма: На базе products_price_categories_with_makers построить по A & D график (X: category_price, Y: count)
--построено в Colab https://github.com/Chalkina/sql_homework/blob/main/lesson4_task11_products_price_categories_with_makers_2.ipynb
create view products_price_categories_with_makers_2 as 
select count(*), category_price, maker
from (
  select *, 
  case 
  when price > 1000 then 2
  when price < 1000 and price > 500 then 1
  else 0 
  end category_price
  from (
    select product.maker, price  
    from pc 
    join product 
    on pc.model = product.model 
    
    union all 
    select product.maker, price   
    from printer 
    join product 
    on printer.model = product.model 
    
    union all 
    select product.maker, price   
    from laptop 
    join product 
    on laptop.model = product.model 
  ) a where maker like 'A'
 
) b 
group by category_price, maker