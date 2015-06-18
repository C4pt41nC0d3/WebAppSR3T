/*var ResponseCallbacks = {

}*/

/*var AjaxRequester = {
	shortRequest
}*/


var Register = function(){}
Register.prototype.modules = {};

Register.prototype.addModule = function(modulename, controller){
	if(typeof modulename === "string" && typeof controller === "function"){
		this.modules[modulename] = controller;
	}
}

var Iterator = function(){}

Iterator.prototype.init = function(object, handler){
	if(typeof object === "object" && typeof handler === "function"){
		this.object = object;
		this.handler = handler;
		this.prev = this.handler(0x0);
		this.next = this.handler(0x1);
	}
}

Iterator.prototype.position = 0;
Iterator.prototype.isInBounds = function(pos){
	return 0x1?(pos >= 0 && pos < this.object.length):0x0;
}

var register = new Register();
register.addModule(
	"sum", 
	function(a, b){
		return a+b;
});

console.log(register.modules);

var RegisterIterator = new Iterator();
RegisterIterator.init(
	register.modules,
	function(side){
		if(typeof side === "number"){
			if(side === 0x0)
				return function(){
					if(this.isInBounds(this.position))
						return this.object[this.position--];
					else
						return "EOI";
				}
			else if(side == 0x1){
				return function(){
					if(this.isInBounds(this.position))
						return this.object[this.position++];
					else
						return "EOI";
				}
			}
		}
	}
);