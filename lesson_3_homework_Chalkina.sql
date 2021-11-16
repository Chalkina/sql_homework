--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task1
--Корабли: Для каждого класса определите число кораблей этого класса, потопленных в сражениях. Вывести: класс и число потопленных кораблей.
select
  class
  SUM(CASE WHEN result='sunk' THEN 1 ELSE 0 END) as sunks
  from (
    select c.class, name from classes c
      left join ships s on c.class=s.class
    union
    select class, ship from classes
      join outcomes on class=ship
  ) as sh
  left join outcomes o on sh.name=o.ship
  group by class
--task2
--Корабли: Для каждого класса определите год, когда был спущен на воду первый корабль этого класса. Если год спуска на воду головного корабля неизвестен, определите минимальный год спуска на воду кораблей этого класса. Вывести: класс, год.
SELECT c.class, t.y
FROM classes c
LEFT JOIN
(SELECT class, MIN(launched) AS y
FROM ships
GROUP BY class) AS t ON c.class = t.class

--task3
--Корабли: Для классов, имеющих потери в виде потопленных кораблей и не менее 3 кораблей в базе данных, вывести имя класса и число потопленных кораблей.
SELECT class, COUNT(result) AS sunk
FROM (
SELECT class, result
FROM Ships LEFT JOIN
Outcomes ON ship=name AND
result = 'sunk' AND
not(name=class)
union all
SELECT distinct class, result
FROM Classes
JOIN Outcomes
ON class=ship and result='sunk') T
GROUP BY class
HAVING COUNT(class) > 2 AND
COUNT(result) > 0

--task4
--Корабли: Найдите названия кораблей, имеющих наибольшее число орудий среди всех кораблей такого же водоизмещения (учесть корабли из таблицы Outcomes).
SELECT name
FROM (SELECT O.ship AS name, numGuns, displacement
FROM Outcomes INNER JOIN
Classes ON O.ship = C.class AND
O.ship NOT IN (SELECT name
FROM Ships
)
UNION
SELECT S.name AS name, numGuns, displacement
FROM Ships INNER JOIN
Classes ON S.class = C.class
) OS INNER JOIN
(SELECT MAX(numGuns) AS MaxNumGuns, displacement
FROM Outcomes INNER JOIN
Classes ON O.ship = C.class AND
O.ship NOT IN (SELECT name
FROM Ships
)
GROUP BY displacement
UNION
SELECT MAX(numGuns) AS MaxNumGuns, displacement
FROM Ships INNER JOIN
Classes ON S.class = C.class
GROUP BY displacement
) GD ON OS.numGuns = GD.MaxNumGuns AND
OS.displacement = GD.displacement

--task5
--Компьютерная фирма: Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker
SELECT DISTINCT maker
FROM product 
WHERE maker IN (
SELECT p.maker 
FROM product as p INNER JOIN pc as pc ON p.model=pc.model 
WHERE ram =(
SELECT MIN(ram)
FROM pc
) AND 
pc.speed=(
SELECT MAX(speed) 
FROM pc 
WHERE speed IN (
SELECT speed 
FROM pc 
WHERE ram=(
SELECT MIN(ram) FROM pc)))) 
AND type='printer'