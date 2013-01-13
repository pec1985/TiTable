var TiTable = require('ti.table');
module.exports = function(){
	var win = Ti.UI.createWindow({
		fullscreen: false
	});

	if(Ti.Platform.osname == 'iphone') {
		win.modal = true;
		var close = Ti.UI.createButton({
			title: 'close'
		});
		win.rightNavButton = close;
		close.addEventListener('click', function(){
			win.close();
		});
	}

	var data = [];

	for(var i = 0; i < 10; i++) {
		data.push({
			title: 'Hello World #'+i,
			color: "#"+((1<<24)*Math.random()|0).toString(16),
			leftImage: 'KS_nav_ui.png',
			hasChild:false
		});
	}

	for(var i = 0; i < 10; i++) {
		data.push({
			title: 'Hello World #'+i,
			titleColor: "#"+((1<<24)*Math.random()|0).toString(16),
			leftImage: 'KS_nav_ui.png',
			hasChild:true
		});
	}

	for(var i = 0; i < 10; i++) {
		data.push({
			title: 'Hello World #'+i,
			hasChild:true
		});
	}

	for(var i = 0; i < 10; i++) {
		data.push({
			title:'This is a ver long title, this is a very long title, this is a very long title, blah blah blah', subtitle:'This is a ver long title, this is a very long title, this is a very long title, blah blah blah',
			rightImage: 'KS_nav_ui.png',
			leftImage: 'KS_nav_ui.png'
		});
	}
	for(var i = 0; i < 10; i++) {
		data.push({
			title: 'Title: Hello World #'+i,
		});
	}

	var table = TiTable.createTableView({
		backgroundColor: 'white',
		type: TiTable.TITLE_ONLY,
		data: data
	});

	win.add(table);

	table.addEventListener('click', function(e){
		Ti.API.info(e);
		Ti.API.info(JSON.stringify(e.rowData));
		alert('index: ' + e.index);
	});

	return win;
}