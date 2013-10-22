// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'white'
});
var label = Ti.UI.createLabel({ styleCss:'background-color: blue; color: white;'});
win.add(label);
win.open();

var pixate = require('com.pixate.pxengine');
Ti.API.info("module is => " + pixate);

