create table addresses
(
    id       int auto_increment,
    ind      int          not null,
    district varchar(255) not null,
    street   varchar(255) not null,
    house    int          not null,
    flat     int          null,
    constraint id
        unique (id)
);

alter table addresses
    add primary key (id);

create table ATS
(
    id         int auto_increment,
    title      varchar(255)                                   not null,
    kind       enum ('city', 'departmental', 'institutional') not null,
    city       varchar(255)                                   not null,
    amount_sub int                                            not null,
    id_address int                                            not null,
    constraint id
        unique (id),
    constraint ATS_addresses_id_fk
        foreign key (id_address) references addresses (id)
            on update cascade on delete cascade
);

alter table ATS
    add primary key (id);

create table ATS_prices
(
    id_ATS          int    not null,
    price_city      double not null,
    price_intercity double not null,
    constraint id_ATS
        unique (id_ATS),
    constraint ATS_prices_ATS_id_fk
        foreign key (id_ATS) references ATS (id)
            on update cascade on delete cascade
);

alter table ATS_prices
    add primary key (id_ATS);

create table subs
(
    id               int auto_increment,
    last_name        varchar(255)                         not null,
    first_name       varchar(255)                         not null,
    patronymic       varchar(255)                         null,
    telephone_kind   enum ('main', 'parallel', 'coupled') not null,
    telephone_number bigint                               not null,
    intercity        tinyint(1) default 0                 not null,
    benefit          tinyint(1) default 0                 not null,
    id_address       int                                  not null,
    constraint id
        unique (id),
    constraint fk_id_adress
        foreign key (id_address) references addresses (id)
            on update cascade on delete cascade
);

alter table subs
    add primary key (id);

create table call_logs
(
    id         int auto_increment,
    id_sub     int                  not null,
    date_call  date                 not null,
    time_start time                 not null,
    time_end   time                 not null,
    intercity  tinyint(1) default 0 not null,
    constraint id
        unique (id),
    constraint call_logs_subs_id_fk
        foreign key (id_sub) references subs (id)
            on update cascade on delete cascade
);

alter table call_logs
    add primary key (id);

create table sub_logs
(
    id                int auto_increment,
    id_sub            int              not null,
    month             varchar(255)     not null,
    year              year             not null,
    minutes_city      int    default 0 not null,
    minutes_intercity int    default 0 not null,
    price             double           not null,
    price_benefit     double default 0 not null,
    total_price       double           not null,
    constraint id
        unique (id),
    constraint sub_logs_subs_id_fk
        foreign key (id_sub) references subs (id)
            on update cascade on delete cascade
);

alter table sub_logs
    add primary key (id);

