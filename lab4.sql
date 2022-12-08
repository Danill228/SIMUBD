#1 запрос для создания временной таблицы через переменную типа TABLE
create temporary table t
(
    id int,
    data text
);

#2 запроса с использованием условной конструкции IF
select title, if (price > 15, 'Дорого', 'Дешево') from medicines;
select first_name, last_name, if (city = 'Минск', 'Столица', 'Область') from customers;

#2 запроса с использованием цикла WHILE
delimiter //
create function createArray(quantity int)
    returns varchar(255)
    deterministic
begin
    declare counter int;
    declare array varchar(255);
    set counter = 0;
    set array = '';
    while counter < quantity do
            set array = concat(array, counter + 1, ',');
            set counter = counter + 1;
        end while;
    return array;
end //
select createArray(5);

delimiter //
create procedure createTurnArray(quantity int)
begin
    declare array varchar(255);
    declare counter int;
    set counter = quantity;
    set array = '';
    while counter > 0 do
            set array = concat(array, counter, ',');
            set counter = counter - 1;
        end while;
    select array;
end //
delimiter ;
call createTurnArray(5);

#1 запрос для создания скалярной функции
delimiter $
create function getAge(birthday date)
returns int deterministic
begin
    declare age int;
    set age = year(now()) - year(birthday);
    return age;
end $
delimiter ;
select getAge(date_of_birthday) from sellers;

#1 запрос для создания функции, которая возвращает табличное значение;
delimiter //
create procedure getResultRecipes(ind int)
begin
    select * from recipes where id = ind;
end //
delimiter ;
call getResultRecipes(1);

#2 запроса для создания процедуры без параметров
delimiter //
create procedure getResultsRecipes()
begin
    select * from recipes;
end //
delimiter ;
call getResultsRecipes();

delimiter //
create procedure getSumMed()
begin
    select sum(price) from medicines;
end //
delimiter ;
call getSumMed();

#2 запроса для создания процедуры c входным параметром
delimiter //
create procedure getByDate(date date)
begin
    select * from sale_medicines where sale_date = date;
end //
delimiter ;
call getByDate('2022-10-12');

delimiter //
create procedure getMoreAmount(amount double)
begin
    select * from sale_medicines where sale_medicines.amount > amount;
end //
delimiter ;
call getMoreAmount(1);

#2 запроса для создания процедуры c входными параметрами и RETURN
delimiter //
create function minusTwo(one double, two double)
returns double deterministic
begin
    return one - two;
end //
delimiter ;
select minusTwo(10.3, 5.7);
select count(*) from sellers s join sale_medicines sm on s.id = sm.id_seller
where s.id = 1 and sm.sale_date = '2022-10-12';

delimiter //
create function isCountSoldByDate(ind int, date date)
returns int deterministic
begin
    declare c int;
    set c = 0;
    set c = (select count(*) from sellers s join sale_medicines sm on s.id = sm.id_seller
             where s.id = ind and sm.sale_date = date);
    return c;
end //
delimiter ;
select isCountSoldByDate(1, '2022-10-12') as sold;

#2 запроса для создания процедуры обновления данных в таблице базы данных
delimiter //
create procedure updatePhone(phone bigint, ind int)
begin
    update customers set number = phone where id = ind;
end //
delimiter ;
call updatePhone(375445872341, 1);

delimiter //
create procedure updateMedPrice(cost double, name varchar(255))
begin
    update medicines set medicines.price = cost where title = name;
end //
delimiter ;
call updateMedPrice(5, 'Настойка');

#2 запроса для создания процедуры извлечения данных из таблиц базы данных
delimiter //
create procedure selectSellers()
begin
    select * from sellers;
end //
delimiter ;
call selectSellers();

delimiter //
create procedure selectRecipeByTitle(title varchar(255))
begin
    select * from recipes where diagnosis = title;
end //
delimiter ;
call selectRecipeByTitle('Рак');

