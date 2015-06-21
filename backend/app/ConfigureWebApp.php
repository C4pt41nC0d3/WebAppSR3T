<?php
	//Load Silex Libraries
	require __DIR__."/../modules/vendor/autoload.php";
	require __DIR__."/Drivers.php";
	use SR3TWebApp\Drivers\DriverFactory;

	class SystemCodes {
		public static $hashreqcodes, $hashrescodes;
		public static function generateCodes($dbhandler){
			self::$hashreqcodes = array();
			self::$hashrescodes = array();
			if(is_object($dbhandler)){
				foreach($dbhandler->execQueryAndGetMatrix("select name, md5hash from actions") as $requestcode)
					self::$hashreqcodes[$requestcode["name"]] =  $requestcode["md5hash"];
				foreach($dbhandler->execQueryAndGetMatrix("select name, md5hash from responsecodes") as $responsecode)
					self::$hashrescodes[$responsecode["name"]] = $responsecode["md5hash"];
			}	
		} 
	}

	//Dependence injection
	class ConfigureWebApp {
		private static $app, $databasedriver, $databasehandler, $rescodes, $reqcodes, $status = "webapp-unconfigured";
		public static function initConfiguration($logfile, $driverconfigarray){
			//Configure the app
			self::$app = new Silex\Application();

			//Enable the app debug
			self::$app["debug"] = true; 

			//Configure the service provider
			//For monolog
			self::$app->register(new Silex\Provider\MonologServiceProvider(), array(
				"monolog.logfile" => __DIR__."/$logfile"
				/*"session.storage.options" => array(
					"cookie_lifetime" => 3600,
					"cookie_domain" => "sr3t.com"
				)*/
			));

			//For sessions
			self::$app->register(new Silex\Provider\SessionServiceProvider(), array(
				"session.storage.save_path" => __DIR__."//sessions//",
				"session.storage.options" => array(
					"cookie_lifetime" => 3600,
					"cookie_path" => __DIR__."//c//",
					"cookie_domain" => "sr3t.zz.mu"
				)
			));

			//Register for configure the database driver
			self::$databasedriver = DriverFactory::buildDatabaseDriverObject(
				$driverconfigarray["u"], 
				$driverconfigarray["p"], 
				$driverconfigarray["h"], 
				$driverconfigarray["db"]
			);

			//send the current app to the database driver
			self::$databasedriver->appendLoggerByApp(self::$app);

			//configure the database handler
			self::$databasehandler = DriverFactory::buildDatabaseHandlerObject(
				//current database driver
				self::$databasedriver,
				//pdo configuration
				array(
					PDO::FETCH_ASSOC => true,
					//set the scrollable cursor when one element is called
					PDO::CURSOR_SCROLL => true,
					//configure one persistent connection never close, but is handled correctly
					PDO::ATTR_PERSISTENT => true
				)
			);
			SystemCodes::generateCodes(self::$databasehandler);
			self::$rescodes = SystemCodes::$hashrescodes;
			self::$reqcodes = SystemCodes::$hashreqcodes;
			self::$status = "webapp-configured";
		}

		public static function packConfiguration(){
			if(self::$status === "webapp-configured")
				return array(
					"app" => self::$app,
					"dbdriver" => self::$databasedriver,
					"dbhandler" => self::$databasehandler,
					"rescodes" => self::$rescodes,
					"reqcodes" => self::$reqcodes
				);
			else die();
		}
	}

	//Dependencies injection [init configuration]
	ConfigureWebApp::initConfiguration(
		"logs.log", 
		array(
			"u" => "root",
			"p" => "data.set",
			"h" => "localhost",
			"db" => "sr3tdb"
		)
	);
?> 