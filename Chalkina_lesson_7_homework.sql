--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1  (lesson7)
-- sqlite3: Сделать тестовый проект с БД (sqlite3, project name: task1_7). В таблицу table1 записать 1000 строк с случайными значениями 
--(3 колонки, тип int) от 0 до 1000.
-- Далее построить гистаграмму распределения этих трех колонко

--task2  (lesson7)
-- oracle: https://leetcode.com/problems/duplicate-emails/
SELECT*
FROM  Person
WHERE email IN (SELECT email FROM Person GROUP BY email HAVING COUNT(*) > 1)
ORDER BY email
--task3  (lesson7)
-- oracle: https://leetcode.com/problems/employees-earning-more-than-their-managers/
select name as Employee 
    from Employee as t
    where salary > (select salary from Employee where id=t.ManagerId)
--task4  (lesson7)
-- oracle: https://leetcode.com/problems/rank-scores/
SELECT *,
rank() OVER(ORDER BY score) as  rnk,
DENSE_RANK() OVER(ORDER BY score) as  dense_rnk
FROM scores
--task5  (lesson7)
-- oracle: https://leetcode.com/problems/combine-two-tables/
select firstName, lastName 
from Person 
join Address 
on Person.personId = Address.personId
