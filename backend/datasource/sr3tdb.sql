create database if not exists sr3tdb;
use sr3tdb;

/*
	SR3T API
	Key: 04359788e7b56d7cdc548b4f6d13f451
	
	Root account
	user:boss@root.net
	password: root$3#01
*/

create table usertype (
	id tinyint(1) not null primary key auto_increment,
	typename varchar(20) not null,
	description text not null
);

insert into usertype(typename, description) values("root", "Root User: This is the unique user that cannot be deleted, but can track and delete the another users."),
("guest", "Guest User: Is a normal user and has not permissions for delete other users and track them.");

create table users (
	id int not null primary key auto_increment,
	utype tinyint(1) not null default 2,
	name varchar(40) not null,
	email varchar(30) not null,
	md5hash char(32) not null
);
insert into users(utype, name, email, md5hash) values(1, "superrootboss","boss@root.net", "66d6e4f737c901ef4076852867b69404");

alter table users add constraint fk_utype0 foreign key users (utype) references usertype (id) on update cascade on delete cascade;

create table robot (
	id int not null primary key auto_increment,
	iduser int not null,
	name varchar(45) not null
);

alter table robot add constraint fk_users foreign key robot (iduser) references users (id) on update cascade on delete cascade;

create table sensors (
	id int not null primary key auto_increment,
	name varchar(50) not null,
	datatype enum("int","bigint","float","double","string","char","text") not null,
	imgurl varchar(1000) not null,
	time float not null
);

create table complements (
	id int not null primary key auto_increment,
	name varchar(50) not null,
	datatype enum("int","bigint","float","double","string","char","text") not null,
	imgurl varchar(1000) not null
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
alter table relcompl add constraint fk_compl0 foreign key relcompl (idcmpl) references complements (id) on update cascade on delete cascade;

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

create table actiontype (
	id int not null primary key auto_increment,
	name varchar(30) not null
);

insert into actiontype(name) values
	("add"),
	("edit"),
	("show"),
	("delete");

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
	id tinyint(2) not null primary key auto_increment, #since 1 to 99 actions
	name varchar(20) not null,
	md5hash char(32) not null
);

/* generate common actions*/
#generate a code more hard to break
insert into actions(name, md5hash) select concat(actiontype.name,"-",tablenames.name), md5(concat(actiontype.name, "-", tablenames.name, "{&}{}[%&&ñ]{}")) from actiontype, tablenames;

/* generate particulary options*/
insert into actions(name, md5hash) select "user-login", md5("user-login{&}{}[%&&ñ]{}");
insert into actions(name, md5hash) select "user-forgot-password", md5("user-forgot-password{&}{}[%&&ñ]{}");
insert into actions(name, md5hash) select "add-sensor-value", md5("add-sensor-value{&}{}[%&&ñ]{}");
insert into actions(name, md5hash) select "add-cmpl-value", md5("add-cmpl-value{&}{}[%&&ñ]{}");
insert into actions(name, md5hash) select "user-contact", md5("user-contact{&}{}[%&&ñ]{}");

#Note: the systracker is from server side
create table tracker (
	id bigint not null primary key auto_increment,
	iduser int not null,
	idaction tinyint(2) not null,
	_date date not null,
	_hour time not null
);

alter table tracker add constraint fk_users0 foreign key tracker (iduser) references users (id) on update cascade on delete cascade;
alter table tracker add constraint fk_action0 foreign key tracker (idaction) references actions (id) on update cascade on delete cascade;

#Response codes
create table responsecodes (
	name varchar(45) not null primary key,
	md5hash char(32) not null
);

#response codes for users
insert into responsecodes select "login-accepted", md5("login-accepted{&}{}[%&&ñ]{}");
insert into responsecodes select "login-error", md5("login-error{&}{}[%&&ñ]{}");
insert into responsecodes select "add-user-acepted", md5("add-user-acepted{&}{}[%&&ñ]{}");
insert into responsecodes select "add-user-error", md5("add-user-error{&}{}[%&&ñ]{}");
insert into responsecodes select "edit-user-acepted", md5("edit-user-acepted{&}{}[%&&ñ]{}");
insert into responsecodes select "edit-user-error", md5("edit-user-error{&}{}[%&&ñ]{}");
insert into responsecodes select "del-user-acepted", md5("del-user-acepted{&}{}[%&&ñ]{}");
insert into responsecodes select "del-user-error", md5("del-user-error{&}{}[%&&ñ]{}");

#response codes for robots
insert into responsecodes select "add-robot-acepted", md5("add-robot-acepted{&}{}[%&&ñ]{}");
insert into responsecodes select "add-robot-error", md5("add-robot-error{&}{}[%&&ñ]{}");
insert into responsecodes select "edit-robot-acepted", md5("edit-robot-acepted{&}{}[%&&ñ]{}");
insert into responsecodes select "edit-robot-error", md5("edit-robot-error{&}{}[%&&ñ]{}");
insert into responsecodes select "del-robot-acepted", md5("del-robot-acepted{&}{}[%&&ñ]{}");
insert into responsecodes select "del-robot-error", md5("del-robot-error{&}{}[%&&ñ]{}");

#response codes for sensors
insert into responsecodes select "add-sensor-acepted", md5("add-sensor-acepted{&}{}[%&&ñ]{}");
insert into responsecodes select "add-sensor-error", md5("add-sensor-error{&}{}[%&&ñ]{}");
insert into responsecodes select "edit-sensor-acepted", md5("edit-sensor-acepted{&}{}[%&&ñ]{}");
insert into responsecodes select "edit-sensor-error", md5("edit-sensor-error{&}{}[%&&ñ]{}");
insert into responsecodes select "del-sensor-acepted", md5("del-sensor-acepted{&}{}[%&&ñ]{}");
insert into responsecodes select "del-sensor-error", md5("del-sensor-error{&}{}[%&&ñ]{}");
insert into responsecodes select "add-sensorval-acepted", md5("add-sensorval-acepted{&}{}[%&&ñ]{}");
insert into responsecodes select "add-sensorval-error", md5("add-sensorval-error{&}{}[%&&ñ]{}");
insert into responsecodes select "rsr-acepted", md5("rsr-acepted{&}{}[%&&ñ]{}");
insert into responsecodes select "rsr-error", md5("rsr-error{&}{}[%&&ñ]{}");

#response codes for complements
insert into responsecodes select "add-complement-acepted", md5("add-complement-acepted{&}{}[%&&ñ]{}");
insert into responsecodes select "add-complement-error", md5("add-complement-error{&}{}[%&&ñ]{}");
insert into responsecodes select "edit-complement-acepted", md5("edit-complement-acepted{&}{}[%&&ñ]{}");
insert into responsecodes select "edit-complement-error", md5("edit-complement-error{&}{}[%&&ñ]{}");
insert into responsecodes select "del-complement-acepted", md5("del-complement-acepted{&}{}[%&&ñ]{}");
insert into responsecodes select "del-complement-error", md5("del-complement-error{&}{}[%&&ñ]{}");
insert into responsecodes select "add-cmplval-acepted", md5("add-cmplval-acepted{&}{}[%&&ñ]{}");
insert into responsecodes select "add-cmplval-error", md5("add-cmplval-error{&}{}[%&&ñ]{}");
insert into responsecodes select "rcr-acepted", md5("rcr-acepted{&}{}[%&&ñ]{}");
insert into responsecodes select "rcr-error", md5("rcr-error{&}{}[%&&ñ]{}");
#response codes for system tracker
insert into responsecodes select "user-tracker-acepted", md5("user-tracker-acepted{&}{}[%&&ñ]{}");
insert into responsecodes select "user-tracker-error", md5("user-tracker-error{&}{}[%&&ñ]{}");

#response codes for forgot account
insert into responsecodes select "user-exists-acepted", md5("user-exists-acepted{&}{}[%&&ñ]{}");
insert into responsecodes select "user-exists-error", md5("user-exists-error{&}{}[%&&ñ]{}");
insert into responsecodes select "user-rcode-error", md5("user-rcode-error{&}{}[%&&ñ]{}");
insert into responsecodes select "user-rcode-acepted", md5("user-rcode-acepted{&}{}[%&&ñ]{}");

#response codes for system attacks
insert into responsecodes select "sys-sqli-attack", md5("sys-sqli-attack");

create table forgotaccount (
	userid int not null,
	requestcode char(32) not null,
	feedback tinyint(1) not null default 0
);

alter table forgotaccount add constraint fk_users1 foreign key forgotaccount (userid) references users (id) on update cascade on delete cascade;

#	Views - for filters
#	create view <name> as (
#		query
#	);

create view viewRobotsByUsers as (
	select users.id as userid, robot.id as robotid, robot.name as robotname from users, robot where users.id = robot.iduser
);

create view viewSensorsByRobots as (
	select robot.id as robotid, sensors.id as sensorid, sensors.name as sensorname, sensors.datatype, sensors.imgurl, sensors.time from sensors, robot, relsensor where relsensor.idrobot = robot.id and relsensor.idsensor = sensors.id
);

create view viewComplementsByRobots as (
	select robot.id as robotid, complements.id as complementid, complements.name as complementname, complements.datatype, complements.imgurl from complements, robot, relcompl where relcompl.idrobot = robot.id and relcompl.idcmpl = complements.id
);

create view viewValuesBySensors as (
	select relsensor.id as relsensorid, viewSensorsByRobots.sensorid, valrelsensor.value from valrelsensor, viewSensorsByRobots, relsensor where relsensor.idrobot = viewSensorsByRobots.robotid and relsensor.idsensor = viewSensorsByRobots.sensorid and relsensor.id = valrelsensor.idrelsensor
);

create view viewValuesByComplements as (
	select relcompl.id as relcomplid, viewComplementsByRobots.complementid, valrelcompl.value from valrelcompl, viewComplementsByRobots, relcompl where relcompl.idrobot = viewComplementsByRobots.robotid and relcompl.idcmpl = viewComplementsByRobots.complementid and relcompl.id = valrelcompl.idrelcompl
);