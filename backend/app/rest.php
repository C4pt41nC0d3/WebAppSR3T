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

	//add users [aprovado]
	$app->post("/r/{rhash}", function(Request $request) use($app, $rescodes, $dbhandler){
		$uname = $request->get("uname");
		$email = $request->get("email");
		$pass = $request->get("pass");
		//get the code 
		$rescode = $dbhandler->execQueryAndGetMatrix("select addUser('".$uname."','".$email."','".$pass."') as responsehash")[0]["responsehash"];
		if($rescode === $rescodes["add-user-acepted"])
			return new JsonResponse(array("responsecode" => $rescode), 201);

	  return new JsonResponse(array("responsecode" => $rescode), 400);
	})->assert("rhash", $reqcodes["add-users"])
	->before(function(Request $request, Silex\Application $app) use($rescodes){
		if(!preg_match("/^[a-zA-Z]?[a-zA-Z0-9]+$/", $request->get("uname")) 
			or !preg_match("/^[a-zA-Z0-9-_]+@[a-zA-Z0-9-_]+\.[a-z]+$/", $request->get("email"))
			or !preg_match("/^[a-z0-9]+$/", $request->get("pass"))){
			$app["monolog"]->addWarning("APIRest: SQLi code execution.");
			return new JsonResponse(array("responsecode" => $rescodes["sys-sqli-attack"]), 403);
		}
	});

	//edit users
	$app->post("/r/{rhash}", function(Request $request) use($app, $rescodes, $dbhandler){

	})->assert("rhash", $reqcodes["edit-users"])
	->before(function(Request $request, Silex\Application $app){
		

	})
	->after(function(Request $request, Response $response, Silex\Application $app){

	});

	//login users [aprovado]
	$app->post("/r/{rhash}", function(Request $request) use($app, $rescodes, $dbhandler){
		$email = $request->get('email');	
		$pass = $request->get('pass');

		$userdata = $dbhandler->execQueryAndGetMatrix("select * from users where email='$email' and md5hash='$pass'");

		//Check if the user exists
		if(isset($userdata[0]["utype"])){
			//Convert the matrix into one array
			$userdata = $userdata[0];
			/*
			$app["session"]->set(
				"userdata",
				array(
					"id" => $userdata["id"],
					"name" => $userdata["name"],
					"email" => $userdata["email"],
					"hash" => $userdata["md5hash"]
				)
			);*/

			//store the data in session vars
			
			/*if($userdata["utype"] == 1)
			else if($userdata["utype"] == 2)
				$app["session.storage.handler"]->setName("guest");
			else $app["monolog"]->addError("APIRest: User type unknown");*/
			
			return new JsonResponse(array("responsecode" => $rescodes["login-acepted"]), 202);
		}

	  return new JsonResponse(array("responsecode" => $rescodes["login-error"]), 400);
	})->assert("rhash", $reqcodes["user-login"])
	->before(function(Request $request, Silex\Application $app) use($rescodes){
		$email = $request->get("email");
		$pass = $request->get("pass");

		//Avoid code injection
		if(!preg_match("/^[a-f0-9]+$/", $pass) or !preg_match("/^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+\.[a-z]+$/", $email)){
			$app["monolog"]->addWarning("APIRest: SQLi code execution.");
			return new JsonResponse(array("responsecode" => $rescodes["sys-sqli-attack"]), 403);
		}
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
	->before(function(Request $request, Silex\Application $app){

	})
	->after(function(Request $request, Response $response,  SSilex\Application $app){

	});

	//edit robots
	$app->post("/r/{rhash}", function(Request $request) use($app, $rescodes, $dbhandler){

	})->assert("rhash", $reqcodes["edit-robots"])
	->before(function(Request $request, Silex\Application $app){

	})
	->after(function(Request $request, Response $response,  Silex\Application $app){

	});

	//delete robots
	$app->post("/r/{rhash}", function(Request $request) use($app, $rescodes, $dbhandler){

	})->assert("rhash", $reqcodes["delete-robots"])
	->before(function(Request $request, Silex\Application $app){

	})
	->after(function(Request $request, Response $response,  Silex\Application $app){

	});

	//Functions for sensors
	//show sensors
	$app->get("/r/{rhash}", function($rhash) use($app, $rescodes, $dbhandler){
		return $app->json($dbhandler->execQueryAndGetMatrix("select * from viewSensorsByRobot"));
	})->assert("rhash", $reqcodes["show-sensors"]);

	//add sensors
	$app->post("/r/{rhash}", function(Request $request) use($app, $rescodes, $dbhandler){

	})->assert("rhash", $reqcodes["add-sensors"])
	->before(function(Request $request, Silex\Application $app){

	})
	->after(function(Request $request, Response $response,  Silex\Application $app){

	});

	//edit sensors
	$app->post("/r/{rhash}", function(Request $request) use($app, $rescodes, $dbhandler){

	})->assert("rhash", $reqcodes["edit-sensors"])
	->before(function(Request $request, Silex\Application $app){

	})
	->after(function(Request $request, Response $response,  Silex\Application $app){

	});

	//delete sensors
	$app->post("/r/{rhash}", function(Request $request) use($app, $rescodes, $dbhandler){

	})->assert("rhash", $reqcodes["delete-sensors"])
	->before(function(Request $request, Silex\Application $app){

	})
	->after(function(Request $request, Response $response,  Silex\Application $app){

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