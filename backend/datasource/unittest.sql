show databases;
use sr3tdb;

#Unit tests for functions and views
#Invoke the functions and get the request codes
select "Printing tables" as "UnitTestMessage";
show tables;
select "Getting hashes" as "UnitTestMessage";
select * from responsecodes;

#Users
select "Adding users to database" as "UnitTestMessage";
select addUser("user0", "test@test.com", "shduifgiuawhkfuiwgfa");
select addUser("user1", "user1@test.com", "igsuiafhjsnfoahfaf");
select concat("Users in the database > ",count(0)) as "UnitTestMessage" from users;

#Robots
select "Adding robots to database" as "UnitTestMessage";
select addRobot(1, "robot0");
select addRobot(2, "robot1");
select editRobot(1, 1, "roboteax");
select concat("Robots in the database > ",count(0)) as "UnitTestMessage" from robot;
select "Selecting robots by users" as "UnitTestMessage";
select * from viewRobotsByUsers;

#Sensors
select "Adding sensors to database" as "UnitTestMessage";
select addSensor("Ultrasonic x82", "float", "image1.png", 10.0);
select addSensor("Movement x02", "int", "image21.jpg", 2.0);
select concat("Robots in the database > ",count(0)) as "UnitTestMessage" from sensors;

#Sensor to robot
select "Referencing the sensors with robots" as "UnitTestMessage";
select refSensorToRobot(1, 1);
select refSensorToRobot(2, 1);
select refSensorToRobot(1, 2);
select refSensorToRobot(2, 2);
select "Selecting sensors by robots" as "UnitTestMessage";
select * from viewSensorsByRobots;

#Add values to sensor
select "Inserting values to sensors" as "UnitTestMessage";
select addSensorVal(1, 1, "5.6");
select addSensorVal(1, 1, "2.5");
select "Selecting the sensor values by robots" as "UnitTestMessage";
select * from viewValuesBySensors;