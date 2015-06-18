var app = function(){
	$(".menu-icon .glyphicon-menu-hamburger").click(function(){
		$(".side-menu").animate(
			{left: 0}, 
			1000,
			function(){
				$(".menu-icon span").removeClass("glyphicon-menu-hamburger");
				$(".menu-icon span").addClass("glyphicon-remove-sign");
			}
		);
	});
	$(".menu-icon .glyphicon-remove-sign").click(function(){
		$(".side-menu").animate(
			{left: 300}, 
			1000,
			function(){
				$(".menu-icon span").removeClass("glyphicon-remove-sign");
				$(".menu-icon span").addClass("glyphicon-menu-hamburger");
			}
		);
	});
};

$(document).ready(app);