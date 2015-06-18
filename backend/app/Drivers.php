<?php
	namespace SR3TWebApp\Drivers;

	class DatabaseDriver{
		private $user, $pwd, $host, $dbname, $app;
		public $pdoobject;

		public function __construct($u, $p, $h, $db){
			$this->user = $u;
			$this->pwd = $p;
			$this->host = $h;
			$this->dbname = $db;
		} 

		public function __get($n){
			if($n === "user") return $this->user;
			else if($n === "pwd") return $this->pwd;
			else if($n === "host") return $this->host;

			if($n === "pdoobject" && $this->pdoobject != null) return $this->pdoobject;
			else $this->app["monolog"]->addError("DatabaseDriverError [The value of the current PDO Object is null]");
		} 

		public function __set($n, $v){
			if(is_string($v)){
				if($n === "user") $this->user = $v;
				else if($n === "pwd") $this->pwd = $v;
				else if($n === "host") $this->host = $v;
			}
		}

		public function destroyConnection(){
			if($this->pdoobject != null){
				//Destroy the current connection
				$this->pdoobject = null;
			}
			else $this->app["monolog"]->addError("DatabaseDriverError [There's no active connection, thus the PDO Object is null]");

		}

		public function buildPDOObject($configarray){
			try{
				if(is_array($configarray))
					$this->pdoobject = new \PDO("mysql:host=$this->host;dbname=$this->dbname", $this->user, $this->pwd, $configarray);
				else
					return false;
			}
			catch(PDOException $ex){
				$this->app["monolog"]->addError("DatabaseDriverError [The current object PDO can't be build][ExceptionTrace $ex->message]");
				die();
			}
		}

		//This function requires silex framework
		public function appendLoggerByApp($app){
			if(is_object($app) && is_object($app["monolog"])) 
				$this->app = $app;
			else
				die();
		}
	}

	class DatabaseHandler{
		private $pdofactorized;
		public function __construct($databasedriver, $pdoconfigarray){
			if(is_object($databasedriver) && $databasedriver instanceof DatabaseDriver && is_array($pdoconfigarray)){
				//Factorize the pdo object
				$databasedriver->buildPDOObject($pdoconfigarray);
				$this->pdofactorized = $databasedriver->pdoobject;
			}
		}

		public function __get($n){
			if($n === "pdofactorized")
				return $this->pdofactorized;
		}

		public function __set($n, $v){
			if($n === "pdofactorized" && $v instanceof PDO)
				$this->pdofactorized = $v;
			//exit from this script if the connection doesn't exists
			else die(); 
		}

		//Return true (0x1) if the query was executed, else return false (0x0) if was occured one error
		public function execQuery($query){
			if(is_string($query))
				return $this->pdofactorized->exec($query);
		  return 0x0;
		}

		//Return an array from the query, and return false (0x0) if was occured one error
		public function execQueryAndGetMatrix($query){
			if(is_string($query)){
				$pstatement = $this->pdofactorized->query($query);
				if($pstatement != null){
					$resultarray = array();
					foreach ($pstatement as $row)
						$resultarray[] = $row;
				   return $resultarray;
				}
			}
		  return 0x0;
		}
	} 

	class DriverFactory{
		public static function buildDatabaseDriverObject($u, $p, $h, $db){
			return new DatabaseDriver($u, $p, $h, $db);
		}

		public static function buildDatabaseHandlerObject($dbdriver, $pdoconfigarray){
			return new DatabaseHandler($dbdriver, $pdoconfigarray);
		}
	}
?> 