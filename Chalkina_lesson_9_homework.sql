--task1  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem
SELECT CASE 
    WHEN Grades.Grade < 8 THEN 'NULL' 
    ELSE Students.Name 
    END 
, Grades.Grade, Students.Marks 
FROM Students, Grades 
WHERE Students.Marks >= Grades.Min_mark AND Students.Marks <= Grades.Max_mark 
ORDER BY Grades.Grade DESC, Students.Name;

--task2  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/occupations/problem
max(case when columnname = 'Doctor' then value end) Doctor,
max(case when columnname = 'Professor' then value end) Professor,
max(case when columnname = 'Singer' then value end) Singer,
max(case when columnname = 'Actor' then value end) Actor
from OCCUPATIONS,
order by Doctor, Professor, Singer, Actor;

--task3  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-9/problem
select distinct city
from station
where city not like 'A%' and city not like 'E%' and city not like 'I%' and city not like 'O%' and city not like 'U%'
order by city;

--task4  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-10/problem
select distinct city
from station
where city not like '%a' and city not like '%e' and city not like '%i' and city not like '%o' and city not like '%u'
order by city;

--task5  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-11/problem
SELECT DISTINCT CITY 
FROM STATION 
WHERE (CITY NOT IN (SELECT DISTINCT CITY FROM STATION WHERE CITY LIKE '%a' OR CITY LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' OR CITY LIKE '%u'))
OR 
(CITY NOT IN (SELECT CITY FROM STATION WHERE CITY LIKE 'A%' OR CITY LIKE 'E%' OR CITY LIKE 'I%' OR CITY LIKE 'O%' OR CITY LIKE 'U%'));

--task6  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-12/problem
SELECT DISTINCT CITY 
FROM STATION 
WHERE (CITY NOT IN (SELECT DISTINCT CITY FROM STATION WHERE CITY LIKE '%a' OR CITY LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' OR CITY LIKE '%u'))
AND
(CITY NOT IN (SELECT CITY FROM STATION WHERE CITY LIKE 'A%' OR CITY LIKE 'E%' OR CITY LIKE 'I%' OR CITY LIKE 'O%' OR CITY LIKE 'U%'));

--task7  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/salary-of-employees/problem
select name
from Employee
where salary > 2000 and months < 10
order by employee_id;

--task8  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem
SELECT CASE 
    WHEN Grades.Grade < 8 THEN 'NULL' 
    ELSE Students.Name 
    END 
, Grades.Grade, Students.Marks 
FROM Students, Grades 
WHERE Students.Marks >= Grades.Min_mark AND Students.Marks <= Grades.Max_mark 
ORDER BY Grades.Grade DESC, Students.Name;