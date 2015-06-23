var ajaxrequester = new AjaxRequester(), app = function(){
	//validate the forms
	$("#frmcontact").idealforms({
		/*onSubmit: function(invalid, event){
			event.preventDefault();
		},*/
		rules: {
			"email": "required email",
			"msg": "required"
		}
	});

	$(".lcontainer .forgot-pass").click(function(){
		$(".lcontainer .alert").remove();
		$(".lcontainer .well").remove();
		$("#frmlogin").idealforms("toggleFields", "pass");
		$("#frmlogin button").text("Enviar email");
		$(".lcontainer .forgot-pass").remove();
		$("<p><a href='login.html'>Iniciar Sesión</a></p>").appendTo(".lcontainer");
		//$("<a href='login.html'>Iniciar sesión</a>").apendTo(".lcontainer .forgot-pass");
	});

	/*formulario de usuarios*/
	$("#frmusers").idealforms({
		onSubmit: function(invalid, event){
			console.log(invalid);
			event.preventDefault();
			if(invalid){
				$("<div class='alert alert-warning' role='alert'><b>Advertencia!</b> Tu solicitud no puede ser procesada, completa todos los campos con el formato establecido.</div>").appendTo(".users");
			}
			else{
				ajaxrequester.SendHTTPRequest(
					"backend/app/rest.php/r/bad3aaa77bb78c077aefb7d9d5753253",
					"post",
					(function(object){
						object.pass = md5(object.pass);
						return object;
					})(ajaxrequester.serializeObject($("#frmusers"))),
					register.get("users.before"),
					true,
					register.get("users.complete"),
					register.get("users.error"),
					{
						//http headers
					},
					register.get("users.success")
				);
			}
		}
	})

	$("#frmlogin").idealforms({
		onSubmit: function(invalid, event){
			event.preventDefault();

			if(invalid){
				$(".lcontainer .alert").remove();
				$(".lcontainer .well").remove();
				$("<div class='alert alert-warning' role='alert'><b>Advertencia!</b> Tu solicitud no puede ser procesada, completa todos los campos con el formato establecido.</div>").appendTo(".lcontainer");
			}
			//send the query with ajax requester
			else{
				$(".lcontainer .alert").remove();
				$(".lcontainer .well").remove();

				//ajaxrequester.SendHTTPRequest(url, method, beforecallback, cachedbrowser, completecallback, errorcallback, httpheaders, successcallback)

				ajaxrequester.SendHTTPRequest(
					"backend/app/rest.php/r/af8ef549bb444534f5b61d9beec5169f",
					"post",
					(function(object){
						object.pass = md5(object.pass);
						return object;
					})(ajaxrequester.serializeObject($("#frmlogin"))),
					register.get("login.before"),
					true,
					register.get("login.complete"),
					register.get("login.error"),
					{
						//http headers
					},
					register.get("login.success")
				);
			}
		}
	});
};

$(document).ready(app);