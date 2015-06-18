<?php
	require "ConfigureWebApp.php";
	use Symfony\Component\HttpFoundation\JsonResponse;
	use Symfony\Component\HttpFoundation\Request;
	use Symfony\Component\HttpFoundation\Response;

	//Package pattern
	$packagevars = ConfigureWebApp::packConfiguration();
	//Get the factorized app
	$app = $packagevars["app"];
	//Database handler
	$dbhandler = $packagevars["dbhandler"];
	//Request codes
	$reqcodes = $packagevars["reqcodes"];
	//Response codes
	$rescodes = $packagevars["rescodes"];
	
	/*
		Sintaxis de Monolog
		Monolog: Monolog es un logger de eventos en el sistema
		$app["monolog"]
			->addError("error message");
			->addDebug("debug message");
			->addWarning("warning message");
	*/
	 
	//Functions for users
	//show users
	$app->get("/r/{rhash}", function($rhash) use($app, $rescodes, $dbhandler){
		return $app->json($dbhandler->execQueryAndGetMatrix("select * from users"));
	})->assert("rhash", $reqcodes["show-users"]);

	//add users
	$app->post("/r/{rhash}", function(Request $request) use($app, $rescodes, $dbhandler){
		//get the code 
		$rescode = $dbhandler->execQueryAndGetMatrix("select addUser(\"{$request->get("name")}\",\"{$request->get("email")}\",\"{$request->get("pass")}\") as responsehash");
	  return $app->json(array("responsecode" => $rescode[0]["responsehash"]));
	})->assert("rhash", $reqcodes["add-users"])
	->before(function(Request $request, Application $app){
		//validate the email, name and md5hash with regexp
		if(!preg_match("/[a-zA-Z0-9_-]+@[a-zA-z0-9_-]+\.[a-z]+/", $request->get("email")) 
			|| !preg_match("/[a-zA-Z]+/", $request->get("name"))
			|| !preg_match("/[a-f0-9]+/", $request->get("pass")))
			return new Response($app->json(array(
				"responsecode" => $rescodes["add-user-error"]
			)), 403);
	})
	->after(function(Request $request, Response $response, Application $app){
		//Tracking the system
	});

	//edit users
	$app->post("/r/{rhash}", function(Request $request) use($app, $rescodes, $dbhandler){

	})->assert("rhash", $reqcodes["edit-users"])
	->before(function(Request $request, Application $app){
		

	})
	->after(function(Request $request, Response $response, Application $app){

	});

	//login users
	$app->post("/r/{rhash}", function(Request $request) use($app, $rescodes, $dbhandler){
		
	})->assert("rhash", $reqcodes["edit-users"])
	->before(function(Request $request, Application $app){
		if(!preg_match("/[a-zA-Z0-9_]+@[a-zA-z0-9_-]+\.[a-z]+/", $request->get("email"))
			|| !preg_match("/[a-f0-9]+/", $request->get("pass")))
			return new Response($app->json(array(
				"responsecode" => $rescodes["login-error"]
			)), 403);
	})
	->after(function(Request $request, Response $response,  Application $app){

	});

	//delete users
	$app->get("/r/{rhash}/{uid}", function($uid) use ($app, $dbhandler, $rescodes){
		$result = $dbhandler->execQueryAndGetMatrix("select delUser($uid) as responsehash");
		if($rescodes["del-user-acepted"] == $result[0]["responsehash"])
			return $app->json(array("responsecode" => $rescodes["del-user-acepted"]));
		else
			return $app->json(array("responsecode" => $rescodes["del-user-error"]));
	})->assert("rhash", $reqcodes["delete-users"])
	  ->assert("uid", "\d+");

	//Functions for robots
	//show robots
	$app->get("/r/{rhash}", function($rhash) use($app, $rescodes, $dbhandler){
		return $app->json($dbhandler->execQueryAndGetMatrix("select * from viewUsersByRobots"));
	})->assert("rhash", $reqcodes["show-robots"]);

	//add robots
	$app->post("/r/{rhash}", function(Request $request) use($app, $rescodes, $dbhandler){

	})->assert("rhash", $reqcodes["add-robots"])
	->before(function(Request $request, Application $app){

	})
	->after(function(Request $request, Response $response,  Application $app){

	});

	//edit robots
	$app->post("/r/{rhash}", function(Request $request) use($app, $rescodes, $dbhandler){

	})->assert("rhash", $reqcodes["edit-robots"])
	->before(function(Request $request, Application $app){

	})
	->after(function(Request $request, Response $response,  Application $app){

	});

	//delete robots
	$app->post("/r/{rhash}", function(Request $request) use($app, $rescodes, $dbhandler){

	})->assert("rhash", $reqcodes["delete-robots"])
	->before(function(Request $request, Application $app){

	})
	->after(function(Request $request, Response $response,  Application $app){

	});

	//Functions for sensors
	//show sensors
	$app->get("/r/{rhash}", function($rhash) use($app, $rescodes, $dbhandler){
		return $app->json($dbhandler->execQueryAndGetMatrix("select * from viewSensorsByRobot"));
	})->assert("rhash", $reqcodes["show-sensors"]);

	//add sensors
	$app->post("/r/{rhash}", function(Request $request) use($app, $rescodes, $dbhandler){

	})->assert("rhash", $reqcodes["add-sensors"])
	->before(function(Request $request, Application $app){

	})
	->after(function(Request $request, Response $response,  Application $app){

	});

	//edit sensors
	$app->post("/r/{rhash}", function(Request $request) use($app, $rescodes, $dbhandler){

	})->assert("rhash", $reqcodes["edit-sensors"])
	->before(function(Request $request, Application $app){

	})
	->after(function(Request $request, Response $response,  Application $app){

	});

	//delete sensors
	$app->post("/r/{rhash}", function(Request $request) use($app, $rescodes, $dbhandler){

	})->assert("rhash", $reqcodes["delete-sensors"])
	->before(function(Request $request, Application $app){

	})
	->after(function(Request $request, Response $response,  Application $app){

	});

	//Handler the errors
	$app->error(function(\Exception $ex, $code){
		switch ($code) {
			case 404:
				$message = "<h1>HTTP Error Code 404</h1><p>The requested page could not be found.</p><p>Please contact to the web admin webadmin@sr3twebapp.com</p>";
			break;
			default:
				$message = "<h1>HTTP Error</h1><p>There is something wrong in the system.</p><p>Please contact to the web admin webadmin@sr3twebapp.com</p>";
			break;
		}
	   return new Response($message);
	});
	$app->run();
?>