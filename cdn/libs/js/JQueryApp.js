var app = function(){
	$(".page-header .glyphicon-menu-hamburger").click(function(){
		$(".side-menu").animate(
			{left: 0}, 
			1000
		);
	});
	$(".title .glyphicon-remove-sign").click(function(){
		$(".side-menu").animate(
			{left: -320}, 
			1000
		);
	});

	//validate the forms
	$("#frmcontact").idealforms({
		/*onSubmit: function(invalid, event){
			e.preventDefault();
		},*/
		rules: {
			"email": "required email",
			"msg": "required"
		}
	});

	$("#frmlogin").idealforms({
		/*onSubmit: function(invalid, event){
			e.preventDefault();
		},*/
		rules: {
			"email": "required email",
			"pass": "required pass"
		}
	});
};

$(document).ready(app);