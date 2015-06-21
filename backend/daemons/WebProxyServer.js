var webproxy = require("webproxy");

webproxy.start({
	port: 8888,
	staticPort: 9001,
	websocketPort: 9002,
	useWwbUI: true,
	useConsoleInfo: true,
	ruleModule: require("./ProxyRules.js")
});