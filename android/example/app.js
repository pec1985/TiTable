var SimpleTableWindow = require('simple');
var SubtitleTableWindow = require('subtitle');

function createButton(_title) {
	return Ti.UI.createButton({
		title: _title,
		top: '50dp',
		left: '20dp',
		right: '20dp'
	});
}

var win = Ti.UI.createWindow({
	backgroundColor: '#CCC',
	layout: 'vertical'
});

var simpleTable = createButton('Simple TableView');
var subtitleTable = createButton('Subtitled TableView');

win.add(simpleTable);
win.add(subtitleTable);

win.open();

simpleTable.addEventListener('click', function(){
	SimpleTableWindow().open();
});

subtitleTable.addEventListener('click', function(){
	SubtitleTableWindow().open();
});