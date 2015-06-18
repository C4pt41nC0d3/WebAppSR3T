create database if not exists sr3tdb;
use sr3tdb;

/*
	SR3T API
	Key: 04359788e7b56d7cdc548b4f6d13f451
*/

create table users (
	id int not null primary key auto_increment,
	name varchar(40) not null,
	email varchar(30) not null,
	md5hash char(32) not null
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
insert into actions(name, md5hash) select concat(actiontype.name,"-",tablenames.name), md5(concat(actiontype.name, "-", tablenames.name)) from actiontype, tablenames;

/* generate particulary options*/
insert into actions(name, md5hash) select "user-login", md5("user-login");
insert into actions(name, md5hash) select "user-forgot-password", md5("user-forgot-password");

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
insert into responsecodes select "login-accepted", md5("login-accepted");
insert into responsecodes select "login-error", md5("login-error");
insert into responsecodes select "add-user-acepted", md5("add-user-acepted");
insert into responsecodes select "add-user-error", md5("add-user-error");
insert into responsecodes select "edit-user-acepted", md5("edit-user-acepted");
insert into responsecodes select "edit-user-error", md5("edit-user-error");
insert into responsecodes select "del-user-acepted", md5("del-user-acepted");
insert into responsecodes select "del-user-error", md5("del-user-error");

#response codes for robots
insert into responsecodes select "add-robot-acepted", md5("add-robot-acepted");
insert into responsecodes select "add-robot-error", md5("add-robot-error");
insert into responsecodes select "edit-robot-acepted", md5("edit-robot-acepted");
insert into responsecodes select "edit-robot-error", md5("edit-robot-error");
insert into responsecodes select "del-robot-acepted", md5("del-robot-acepted");
insert into responsecodes select "del-robot-error", md5("del-robot-error");


#response codes for sensors
insert into responsecodes select "add-sensor-acepted", md5("add-sensor-acepted");
insert into responsecodes select "add-sensor-error", md5("add-sensor-error");
insert into responsecodes select "edit-sensor-acepted", md5("edit-sensor-acepted");
insert into responsecodes select "edit-sensor-error", md5("edit-sensor-error");
insert into responsecodes select "del-sensor-acepted", md5("del-sensor-acepted");
insert into responsecodes select "del-sensor-error", md5("del-sensor-error");
insert into responsecodes select "add-sensorval-acepted", md5("add-sensorval-acepted");
insert into responsecodes select "add-sensorval-error", md5("add-sensorval-error");
insert into responsecodes select "rsr-acepted", md5("rsr-acepted");
insert into responsecodes select "rsr-error", md5("rsr-error");

#response codes for complements
insert into responsecodes select "add-complement-acepted", md5("add-complement-acepted");
insert into responsecodes select "add-complement-error", md5("add-complement-error");
insert into responsecodes select "edit-complement-acepted", md5("edit-complement-acepted");
insert into responsecodes select "edit-complement-error", md5("edit-complement-error");
insert into responsecodes select "del-complement-acepted", md5("del-complement-acepted");
insert into responsecodes select "del-complement-error", md5("del-complement-error");
insert into responsecodes select "add-cmplval-acepted", md5("add-cmplval-acepted");
insert into responsecodes select "add-cmplval-error", md5("add-cmplval-error");
insert into responsecodes select "rcr-acepted", md5("rcr-acepted");
insert into responsecodes select "rcr-error", md5("rcr-error");
#response codes for system tracker
insert into responsecodes select "user-tracker-acepted", md5("user-tracker-acepted");
insert into responsecodes select "user-tracker-error", md5("user-tracker-error");

#response codes for forgot account
insert into responsecodes select "user-exists-acepted", md5("user-exists-acepted"); 
insert into responsecodes select "user-exists-error", md5("user-exists-error");
insert into responsecodes select "user-rcode-error", md5("user-rcode-error");
insert into responsecodes select "user-rcode-acepted", md5("user-rcode-acepted");

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


#	Procedures
#
#	create function <functionName:CammelCase>(param0 datatype, param1 datatype) return datatype
#	begin
#		declare r char(32) default (select md5hash from responsecodes where name=\"responsecode\");
#		code
#		change r if is required
#		return r;		
#	end;//
#
#	Note: the code was validated from server side.

delimiter //
#function for systemTracking
create function systemTracking(uid int, aid int) returns char(32)
begin
	declare r char(32) default (select md5hash from actions where name="user-tracker-error"); 
	if exists(select id from users where id=uid) and exists(select id from actions where id=aid) then
		begin
			insert into tracker(iduser, idaction, _date, _hour) select uid, aid, curdate(), curtime();
			set r = (select md5hash from actions where name="user-tracker-acepted");
		end;
		return r;
	end if; 
end;// 

#functions for users
create function addUser(n varchar(40), e varchar(30), m5h char(32)) returns char(32) 
begin
	declare r char(32) default (select md5hash from responsecodes where name="add-user-error");
	if not exists(select id from users where email=e) then
	begin
		insert into users(name, email, md5hash) values(n, e, m5h);
		set r = (select md5hash from responsecodes where name="add-user-acepted");
	end; end if;
  return r;
end;//

create function editUser(i int, n varchar(40), e varchar(30), m5h char(32)) returns char(32)
begin
	declare r char(32) default (select md5hash from responsecodes where name="edit-user-error");
	if exists(select id from users where id=i) then 
	begin
		update users set name=n, email=e, md5hash=m5h where id=i;
		set r = (select md5hash from responsecodes where name="edit-user-acepted");
	end;
	end if;
	return r;
 end;//

create function delUser(i int) returns char(32)
begin
	declare r char(32) default (select md5hash from responsecodes where name="del-user-error");
	if exists(select id from users where id=i) then 
	begin
		delete from users where id=i;
		set r = (select md5hash from responsecodes where name="del-user-acepted");
	end;
	end if;
	return r;
 end;//

 create function userLogin(e varchar(30), m5h char(32)) returns char(32)
 begin
 	declare r char(32) default (select md5hash from responsecodes where name="login-error");
	if exists(select id from users where email=e and md5hash=m5h) then
		set r = (select md5hash from responsecodes where name="login-accepted");
	end if;
	return r;
 end;//

#functions for robots

create function addRobot(uid int, n varchar(45)) returns char(32)
begin
	declare r char(32) default (select md5hash from responsecodes where name="add-robot-error");
	if not exists(select id from robot where iduser=uid and name=n) then
		insert into robot(iduser, name) values(uid, n);
		set r = (select md5hash from responsecodes where name="add-robot-acepted");
	end if;
	return r;
end; //

create function editRobot(rid int, uid int, n varchar(45)) returns char(32)
begin
	declare r char(32) default (select md5hash from responsecodes where name="edit-robot-error");
	if exists(select id from robot where id=rid and iduser=uid) then
	begin
		update robot set name=n where id=rid;
		set r = (select md5hash from responsecodes where name="add-robot-acepted");
	end;
	end if;
	return r;
end; //

create function delRobot(rid int) returns char(32)
begin
	declare r char(32) default (select md5hash from responsecodes where name="del-robot-error");
	if exists(select id from robot where id=rid) then
	begin
		delete from robot where id=rid;
		set r = (select md5hash from responsecodes where name="del-robot-acepted"); 
	end;
	end if;
	return r;
end; //

#functions for sensors
create function addSensor(n varchar(50), dt enum("int","bigint","float","double","string","char","text"), img varchar(100), t float) returns char(32)
begin
	declare r char(32) default (select md5hash from responsecodes where name="add-sensor-error");
	if not exists(select id from sensors where name=n) then
	begin
		insert into sensors(name, datatype, imgurl, time) values(n, dt, img, t);
		set r = (select md5hash from responsecodes where name="add-sensor-acepted");
	end;
	end if;
	return r;
end; //

create function editSensor(sid int, n varchar(50), dt enum("int","bigint","float","double","string","char","text"), img varchar(100), t float) returns char(32)
begin
	declare r char(32) default (select md5hash from responsecodes where name="edit-sensor-error");
	if exists(select id from sensors where id=sid) then
	begin
		update sensors set name=n, datatype = dt, imgurl = img, time = t where id=sid;
		set r = (select md5hash from responsecodes where name="edit-sensor-acepted");
	end;
	end if;
	return r;
end; //

create function delSensor(sid int) returns char(32)
begin
	declare r char(32) default (select md5hash from responsecodes where name="del-sensor-error");
	if exists(select id from sensors where id=sid) then
	begin
		update sensors set name=n, datatype = dt, imgurl = img, time = t where id=sid;
		set r = (select md5hash from responsecodes where name="del-sensor-acepted");
	end;
	end if;
	return r;
end;//

create function refSensorToRobot(sid int, rid int) returns char(32)
begin
	declare r char(32) default (select md5hash from responsecodes where name="rsr-error");
	if exists(select id from sensors where id=sid) and exists(select id from robot where id=rid) then
	begin
		insert into relsensor(idrobot, idsensor) values(sid, rid);
		set r = (select md5hash from responsecodes where name="rsr-acepted");
	end;
	end if;
	return r;
end;//

create function addSensorVal(rid int, sid int, v text) returns char(32)
begin
	declare r char(32) default (select md5hash from responsecodes where name="add-sensorval-error");

	if exists(select idrobot from relsensor where idrobot=rid and idsensor=sid) then
	begin
		#Mutex for insert the value to sensor
		insert into valrelsensor select relsensor.id, v from viewSensorsByRobots, relsensor where viewSensorsByRobots.sensorid = sid and relsensor.idrobot = rid;
		set r = (select md5hash from responsecodes where name="add-sensorval-acepted");
	end;
	end if;
	return r;
end;//

#functions for complements
create function addCmpl(n varchar(50), dt enum("int","bigint","float","double","string","char","text"), img varchar(100)) returns char(32)
begin
	declare r char(32) default (select md5hash from responsecodes where name="add-complement-error");
	if not exists(select id from complements where name = n) then
	begin
		insert into complements(name, datatype, imgurl) values(n, dt, img);
		set r = (select md5hash from responsecodes where name="add-complement-acepted");
	end;
	end if;
	return r;
end; //

create function editCmpl(cid int, n varchar(50), dt enum("int","bigint","float","double","string","char","text"), img varchar(100)) returns char(32)
begin
	declare r char(32) default (select md5hash from responsecodes where name="edit-complement-error");
	if exists(select id from complements where id=cid) then
	begin
		update complements set name=n, datatype=dt, imgurl=img where id=cid;
		set r = (select md5hash from responsecodes where name="edit-complement-acepted");
	end;
	end if;
	return r;
end; //

create function delCmpl(cid int) returns char(32)
begin
	declare r char(32) default (select md5hash from responsecodes where name="del-complement-error");
	if exists(select id from complements where id=cid) then
	begin
		delete from complements where id=cid;
		set r = (select md5hash from responsecodes where name="edit-complement-acepted");
	end;
	end if;	
	return r;
end;//

create function refCmplToRobot(cid int, rid int) returns char(32)
begin
	declare r char(32) default (select md5hash from responsecodes where name="rcr-error");
	if exists(select id from complements where id=cid) and exists(select id from robot where id=rid) then
	begin
		insert into relcompl(idrobot, idcmpl) values(rid, cid);
		set r = (select md5hash from responsecodes where name="rcr-acepted"); 
	end;
	end if;
	return r;
end; //

create function addCmplVal(cid int, rid int, v text) returns char(32)
begin
	declare r char(32) default (select md5hash from responsecodes where name="add-cmplval-error");
	if exists(select idrobot from relcompl where idrobot=rid and idcmpl=cid) then
	begin
		#Mutex for add value to the complement
		insert into valrelcompl select relcomplid, v from viewComplementsByRobots, relcompl where viewComplementsByRobots.complementid = cid and relcompl.id = viewComplementsByRobots.relsensorid and relcompl.idrobot = rid;
	end;
	end if;
	return r;
end; // 

#function for the forgot acount status
create function regForgotAccount(e varchar(30)) returns char(32)
begin
	declare r char(32) default (select md5hash from responsecodes where name="user-exists-error");
	if exists(select id from users where email=e) then
	begin
		set r = (select md5hash from response where name="user-exists-acepted");
		insert into forgotaccount(userid, requestcode) select users.id, md5(concat(floor(rand()*10273), "$%/K1=)"));
	end;
	end if;
	return  r;
end;//

create function chUsrPass(rcode char(32), pm5h char(32)) returns char(32)
begin
	declare r char(32) default (select md5hash from responsecodes where name="user-rcode-error");
	if exists(select feedback from forgotaccount where requestcode = rcode) then
	begin
		declare uid int default (
			#Mutex
			select userid from forgotaccount where requestcode=rcode
		);
		#update the password
		update users set md5hash=pm5h where id = uid;
		#unable the request code
		update forgotaccount set feedback=1 where responsecode=rcode;
	end;
	end if;
	return r;
end; //

delimiter ;

#Unit tests for functions and views
#Invoke the functions and get the request codes
#Users
select addUser("user0", "test@test.com", "shduifgiuawhkfuiwgfa");
select addUser("user1", "user1@test.com", "igsuiafhjsnfoahfaf");
#Robots
select addRobot(1, "robot0");
select addRobot(2, "robot1");
select editRobot(1, 1, "roboteax");

#Sensors
select addSensor("Ultrasonic x82", "float", "image1.png", 10.0);
select addSensor("Movement x02", "int", "image21.jpg", 2.0);

#Sensor to robot
select refSensorToRobot(1, 1);
select refSensorToRobot(2, 1);
select refSensorToRobot(1, 2);
select refSensorToRobot(2, 2);

#Add values to sensor
select addSensorVal(1, 1, "5.6");
select addSensorVal(1, 1, "2.5");