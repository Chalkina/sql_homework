create table PDCL12
("Date_" date,
"Customer" int,
"Deal" int,
"Currency" varchar(5),
"Sum_" int);

insert into PDCL12 values (to_date('12.12.2009', 'dd.mm.yyyy'), 111110, 111111, 'RUR', 12000);
insert into PDCL12 values (to_date('25.12.2009', 'dd.mm.yyyy'), 111110, 111111, 'RUR', 5000);
insert into PDCL12 values (to_date('12.12.2009', 'dd.mm.yyyy'), 111110, 122222, 'RUR', 10000);
insert into PDCL12 values (to_date('12.01.2010', 'dd.mm.yyyy'), 111110, 111111, 'RUR', -10100);
insert into PDCL12 values (to_date('20.11.2009', 'dd.mm.yyyy'), 220000, 222221, 'RUR', 25000);
insert into PDCL12 values (to_date('20.12.2009', 'dd.mm.yyyy'), 220000, 222221, 'RUR', 20000);
insert into PDCL12 values (to_date('31.12.2009', 'dd.mm.yyyy'), 220001, 222221, 'RUR', -10000);
insert into PDCL12 values (to_date('29.12.2009', 'dd.mm.yyyy'), 111110, 122222, 'RUR', -10000);
insert into PDCL12 values (to_date('27.11.2009', 'dd.mm.yyyy'), 220001, 222221, 'RUR', -30000);
 
select total_customer, #номер клиента
       total_Deal, #номер кредита
       total_debt, #долг
       total_Date, #дата текущей просрочки
       (trunc(sysdate) - total_Date) as delay #количество дней просрочки
  from (select Date_, Customer, Deal, Sum_, #необходимые столбцы из таблицы PDCL12
               coalesce(sum(Sum_) #возвращаем первое не null_ значение сумм задолженности
                        over(partition by Customer, Deal #оконная функция, группируем строки по значению столбцов "Номер клиента", "Номер кредита"
                             order by Date_ #сортируем по дате 
                             rows between unbounded preceding and current row)) as total_debt, #возвращаем значения предыдущей и текущей строки
               rank() over(partition by Customer, Deal order by Date_ desc) as R, #ранжирование сгруппированных данных столбцов "Номер клиента", "Номер кредита", отсортированных по убыванию по дате
               min(Date_) keep (dense_rank first order by Date_) #получаем минимальную первую дату по столбцу "Дата"
               over(partition by Customer, Deal) as total_Date #группируем строки по значению столбцов "Номер клиента", "Номер кредита"
         from PDCL12
        where Date_ <= trunc(sysdate)) #условие - где Дата <= текущей даты
    and total_debt > 0; #долг >0




