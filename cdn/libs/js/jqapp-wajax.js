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
		$("#frmlogin").idealforms("toggleFields", "pass");
		$("#frmlogin button").text("Enviar email");
		$(".lcontainer .forgot-pass").remove();
		$("<p><a href='login.html'>Iniciar Sesión</a></p>").appendTo(".lcontainer");
		//$("<a href='login.html'>Iniciar sesión</a>").apendTo(".lcontainer .forgot-pass");
	});

	$("#frmlogin").idealforms({
		/*
			invalid: is the number of invalid fields
		*/
		onSubmit: function(invalid, event){
			event.preventDefault();
			if(invalid){
				$(".lcontainer .alert").remove();
				$("<div class='alert alert-warning' role='alert'><b>Advertencia!</b> Tu solicitud no puede ser procesada, completa todos los campos con el formato establecido.</div>").appendTo(".lcontainer");
			}
			//send the query with ajax requester
			else{
				$(".lcontainer .alert").remove();
				/*$("<div class='well'><div class='progress'><div class='progress-bar progress-bar-warning progress-bar-striped' role='progressbar' aria-valuenow='0' aria-valuemin='0' aria-valuemax='100' style='width:0%'><span class='sr-only'> 50% Complete</span></div></div><p class='ptext'></p></div>").appendTo(".lcontainer");
					$(".lcontainer .ptext").text("Verificando credenciales");
					$(".lcontainer .progress-bar").animate(
						{width: "40%"}, 
						1000,
						function(){
							$(".lcontainer .ptext").text("Enviando solicitud al servidor");
							$(".lcontainer .progress-bar").animate(
								{width: "80%"},
								1000,
								function(){
									$(".lcontainer .ptext").text("Inicio de sesión validado");
									$(".lcontainer .progress-bar").animate(
										{width: "100%"},
										1000,
										function(){
											$(".lcontainer .ptext").text("Redireccionando");
										}
									);
								}
							);
						}
				);*/

				var values = ajaxrequester.serializeObject($("#frmlogin"));
				values["pass"] = md5(values["pass"]);
				
				//SendHTTPRequest(_url, _method, _data, bcallback, _cache, ccallback, ecallback, httpheaders, scallback)

				ajaxrequester.SendHTTPRequest(
					"backend/app/rest.php/r/af8ef549bb444534f5b61d9beec5169f", 
					"post",
					values,
					//before callback
					function(jqXHR, settings){
						console.log("before callback");
						console.log(jqXHR);
						console.log(settings);
						$("<div class='well'><div class='progress'><div class='progress-bar progress-bar-warning progress-bar-striped' role='progressbar' aria-valuenow='0' aria-valuemin='0' aria-valuemax='100' style='width:0%'><span class='sr-only'> 50% Complete</span></div></div><p class='ptext'></p></div>").appendTo(".lcontainer");
						$(".lcontainer .ptext").text("Verificando credenciales");
						$(".lcontainer .progress-bar").animate(
							{width: "40%"}, 
							1000,
							function(){
								$(".lcontainer .ptext").text("Enviando solicitud al servidor");
							}
						);
					},
					true,
					//complete callback
					function(jqXHR, status){
						console.log("Complete callback")
						console.log(jqXHR);
						console.log(status);
					},
					//error callback
					function(jqXHR, textstatus, errorthrown){
						console.log("Error callback");
						console.log(jqXHR);
						console.log(textstatus);
					},
					{},
					//success callback
					function(returneddata, textstatus, jqXHR){
						console.log("Success callback");
						console.log(returneddata);
						console.log(textstatus);
						console.log(jqXHR);
					}			
				);	
			}
		}
	});
};

$(document).ready(app);