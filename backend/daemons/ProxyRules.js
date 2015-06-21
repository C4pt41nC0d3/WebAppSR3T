exports.request = function(request){
	request.headers.proxy = "*request inject new field by webproxy*";
  return request;
};

exports.response = function(request, response){
	response.headers.proxy = "*wrap define header by webproxy*";

	if(/javascript/.test(response.headers["content-type"]))
		response.responseBuffer = ";define(function(require, exports, module){"+response.responseBuffer+"});";
  return response;
};