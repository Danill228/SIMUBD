create table kafedra
(
    kafedra_id int unique auto_increment primary key not null ,
    title varchar(255) not null
);

create table student
(
    student_id int unique auto_increment primary key not null ,
    sutname varchar(255) not null ,
    sutfname varchar(255) not null ,
    stipend double check ( stipend >= 0 and stipend < 500),
    kurs int check ( kurs > 0 and kurs <= 4),
    city varchar(255),
    `group` varchar(250),
    birthday timestamp,
    kod_kafedru int,
    foreign key (kod_kafedru) references kafedra (kafedra_id)
    on DELETE cascade on UPDATE cascade
);


