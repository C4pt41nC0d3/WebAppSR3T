show databases;
use sr3tdb;

#	Funtions for database API
#	Note: the code was validated from server side.

delimiter //
#function for systemTracking
create function systemTracking(uid int, ip char(15), ua varchar(100), aid int) returns char(32)
begin
	declare r char(32) default (select md5hash from actions where name="user-tracker-error");
	if exists(select id from users where id=uid) and exists(select id from actions where id=aid) then
		begin
			insert into tracker(iduser, idaction, ipv4, httpuseragent, _date, _hour) select uid, aid, ip, ua, curdate(), curtime();
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
	if exists(select id from users where id=i and utype=2) then
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
		set r = (select md5hash from responsecodes where name="edit-robot-acepted");
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
		#insert into valrelsensor select relsensor.id, v from viewSensorsByRobots, relsensor where viewSensorsByRobots.sensorid = sid and relsensor.idrobot = rid;
		insert into valrelsensor select relsensor.id, v from relsensor where relsensor.idrobot = rid and relsensor.idsensor = sid;
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
		set r = (select md5hash from responsecodes where name="del-complement-acepted");
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
		#insert into valrelcompl select relcomplid, v from viewComplementsByRobots, relcompl where viewComplementsByRobots.complementid = cid and relcompl.id = viewComplementsByRobots.relsensorid and relcompl.idrobot = rid;
		insert into valrelcompl select relcompl.id, v from relcompl where relcompl.idcmpl = cid and relcompl.idrobot = rid;
		set r = (select md5hash from responsecodes where name="add-cmplval-acepted");
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
		insert into forgotaccount(userid, requestcode) select users.id, md5(concat(floor(rand()*10273), "$<%#$<(/K1)<=)>"));
		set r = (select md5hash from response where name="user-exists-acepted");
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
		set r = (select md5hash from responsecodes where name="user-rcode-acepted");
	end;
	end if;
	return r;
end; //

delimiter ;