var app = function(){
	$(".page-header .glyphicon-menu-hamburger").click(function(){
		$(".side-menu").animate(
			{left: 0}, 
			500
		);
	});
	$(".title .glyphicon-remove-sign").click(function(){
		$(".side-menu").animate(
			{left: -320}, 
			500
		);
	});
};

$(document).ready(app);