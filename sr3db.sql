create database if not exists sr3tdb;
use sr3tdb;

create table users (
	id int not null primary key auto_increment,
	name varchar(40) not null,
	email varchar(30) not null,
	md5hash char(20) not null
);

create table robot (
	id int not null primary key auto_increment,
	iduser int not null,
	name varchar(45) not null
);

alter table robot add constraint fk_users foreign key robot (iduser) references users (id) on update cascade on delete cascade;

create table sensors (
	id int not null primary key auto_increment,
	name varchar(50) not null,
	datatype varchar(20) not null
);

create table complements (
	id int not null primary key auto_increment,
	name varchar(50) not null,
	datatype varchar(20) not null
);

create table relsensor (
	id bigint not null primary key auto_increment,
	idrobot int not null,
	idsensor int not null
);

alter table relsensor add constraint fk_robot0 foreign key relsensor (idrobot) references robot (id) on update cascade on delete cascade;
alter table relsensor add constraint fk_sensor0 foreign key relsensor (idsensor) references sensors (id) on update cascade on delete cascade;

create table relcompl (
	id bigint not null primary key auto_increment,
	idrobot int not null,
	idcmpl int not null
);

alter table relcompl add constraint fk_robot1 foreign key relcompl (idrobot) references robot (id) on update cascade on delete cascade;
alter table relcompl add constraint fk_compl0 foreign key relsensor (idcmpl) references complements (id) on update cascade on delete cascade;

create table valrelsensor (
	idrelsensor bigint not null,
	value text not null
);

alter table valrelsensor add constraint fk_relsensor0 foreign key valrelsensor (idrelsensor) references relsensor (id) on update cascade on delete cascade;

create table valrelcompl (
	idrelcompl bigint not null,
	value text not null
);

alter table valrelcompl add constraint fk_relcompl0 foreign key valrelcompl (idrelcompl) references relcompl (id) on update cascade on delete cascade;

/* 
	Hashes
		action     hash
		add-user   
*/

create table actiontype (
	id int not null primary key auto_increment,
	name varchar(30) not null
);

insert into actiontype(name) values
	("add"),
	("edit"),
	("show"),
	("delete");

/*
	Advertencia: generar los metadatos con el motor.
*/
create table tablenames (
	id tinyint(2) not null primary key auto_increment,
	name varchar(20) not null
);

insert into tablenames(name) values
	("users"),
	("robots"),
	("sensors"),
	("complements");

create table actions (
	id tinyint(2) not null primary key auto_increment,
	name varchar(20) not null,
	md5hash varchar(20) not null
);

/*insert into actions(name, md5hash) values(select name from tablenames, "8b49e69534eb45c448f6f227c3f7cb09");*/

create table tracker (
	id bigint not null primary key auto_increment,
	iduser int not null,
	idaction tinyint(2) not null,
	_date date not null,
	_hour time not null
);

alter table tracker add constraint fk_users0 foreign key tracker (iduser) references users (id) on update cascade on delete cascade;
alter table tracker add constraint fk_action0 foreign key tracker (idaction) references actions (id) on update cascade on delete cascade;

/*
	Views
	name <vw: view><table_name1>_<table_name2>
*/
create view vwusers_robots as (
	select users.id as userid, robots.id as robotid, robots.name as robotname from users, robots where users.id = robots.userid order by users.id
);
