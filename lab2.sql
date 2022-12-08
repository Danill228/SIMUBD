select host, user, authentication_string from mysql.user;

desc mysql.user;

select user();

create user worker@localhost identified by '123';
create user director@localhost identified by '111';

show grants for worker@localhost;
show grants for director@localhost;

grant select, insert, update, delete on city_telephony.* to worker@localhost;
grant all privileges on city_telephony.* to director@localhost;


flush privileges;

drop user worker@localhost;

set password for worker@localhost = '123';

revoke select on city_telephony.* from worker@localhost;
