#3 простейших запроса с использованием операторов сравнения
select * from medicines where type = 'finished';
select * from recipes where diagnosis = 'ВИЧ';
select * from sale_medicines where  sale_date < now();

#3 запроса с использованием логических операторов AND, OR и NOT
select * from sellers where third_name is not null;
select * from medicines where price > 5 and price < 30;
select * from sellers where education = 'Высшее' or education = 'Среднее';

#2 запроса на использование комбинации логических операторов
select * from medicines where type = 'finished' and kind != 'tincture' or 'tablet';
select * from medicines where price > 15 and kind = 'tablet' or 'tincture';

#2 запроса на использование выражений над столбцами
select min(price) as total_price from medicines;
select sum(price) as total from medicines;

#2 запроса с проверкой на принадлежность множеству
select * from medicines where type in('finished', 'manufactured');
select * from medicines where kind in('tincture', 'tablet');

#2 запроса с проверкой на принадлежность диапазону значений
select * from medicines where price between 5 and 26;
select * from sale_medicines where amount between 2 and 15;

#2 запроса с проверкой на соответствие шаблону
select * from customers where lower(last_name) like 'и%';
select * from medicines where title like '%-%';

#2 запроса с проверкой на неопределенное значение
select * from customers where third_name is null;
select * from sellers where third_name is null;



#2 запроса с использованием декартового произведения двух таблиц
select * from customers cross join sale_medicines;
select * from recipes cross join sale_medicines;

#3 запроса с использованием соединения двух таблиц по равенству
select * from sellers c join sale_medicines s on c.id = s.id_seller;
select * from medicines m join sale_medicines s on m.id = s.id_medicine;
select * from recipes r join sale_medicines s on r.id = s.id_recipe;

#2 запроса с использованием соединения двух таблиц по равенству и условием отбора
select * from sellers c join sale_medicines s on c.id = s.id_seller where amount = 1;
select * from medicines m join sale_medicines s on m.id = s.id_medicine where price > 3;

#2 запроса с использованием соединения по трем таблицам
select * from sellers s join customers_sellers cs on s.id = cs.id_seller join customers c on cs.id_customer = c.id;
select * from customers c join customers_sellers cs on c.id = cs.id_customer join sellers s on cs.id_seller = s.id;

#2 запроса с использованием левого внешнего соединения
select * from sellers c left join sale_medicines s on c.id = s.id_seller;
select * from medicines m left join sale_medicines s on m.id = s.id_medicine;

#2 запроса на использование правого внешнего соединения
select * from sellers c right join sale_medicines s on c.id = s.id_seller;
select * from medicines m right join sale_medicines s on m.id = s.id_medicine;

#2 запроса с использованием симметричного соединения и удаление избыточности
select m1.price, m2.price from medicines m1, medicines m2 where m1.type = m2.type and m1.price > m2.price;
select s1.last_name, s2.last_name from sellers s1, sellers s2 where s1.last_name = s2.last_name;



#2 запроса с использованием функции COUNT
select count(*) from customers;
select count(*) from sellers;

#2 запроса с использованием функции SUM
select sum(price) as total from medicines;
select sum(amount) as total from sale_medicines;

#2 запроса с использованием функций UPPER, LOWER
select UPPER(last_name), first_name from sellers;
select LOWER(title) from medicines;

#2 запроса с использованием временных функций
select now() as now_date;
select curtime() as time;

#2 запроса с использованием группировки по одному столбцу
select kind, count(*) from medicines group by kind;
select type, count(*) from medicines group by type;

#2 запроса на использование группировки по нескольким столбцам
select kind, type, count(*) from medicines group by kind, type;
select id_customer, id_seller, count(*) from customers_sellers group by id_customer, id_seller;

#2 запроса с использованием условия отбора групп HAVING
select kind, count(*), min(price) from medicines group by kind having min(price) > 5;
select sale_date, count(*) from sale_medicines group by sale_date having count(*) > 1;

#2 запроса с использованием фразы HAVING без фразы GROUP BY
select count(*) from sale_medicines having count(*) > 1;
select min(price) from medicines having min(price) > 5;

#2 запроса с использованием сортировки по столбцу
select * from sellers order by last_name;
select * from medicines order by price desc;

#2 запроса на добавление новых данных в таблицу
insert into customers (last_name, first_name, third_name, address, city, number) values
('Петров', 'Александр', 'Федорович', 'Лениградская 14 - 2', 'Могилев', '375338975429');
insert into customers_sellers (id_customer, id_seller) VALUES (4 ,1);

#2 запроса на добавление новых данных по результатам запроса в качестве вставляемого значения
insert into customers_sellers (id_customer, id_seller)
values ((select id from customers where city = 'Гомель'), (select id from sellers where last_name = 'Сергеев'));
insert into sale_medicines (sale_date, amount, id_medicine, id_recipe, id_seller) values
(now(), 5, (select id from medicines where title = 'Настойка'), (select id from recipes where diagnosis = 'ВИЧ'),
 (select id from sellers where last_name = 'Лисовский'));

#2 запроса на обновление существующих данных в таблице
update customers set city = 'Могилев' where id = 2;
update sellers set education = 'Среднее' where last_name = 'Лисовский';

#2 запроса на обновление существующих данных по результатам подзапроса во фразе WHERE
update sale_medicines set amount = 5 where id_medicine = (select id from medicines where title = 'Фольмазин-бета');
update sale_medicines set id_medicine = 2 where id_seller = (select id from sellers where last_name = 'Сергеев');

#2 запроса на удаление существующих данных
delete from medicines where id = 4;
delete from sale_medicines where sale_date < now();