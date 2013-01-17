/**
 * 	Copyright (c) 2013 Pedro Enrique
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and  
 * associated documentation files (the "Software"), to deal in the Software without restriction, including  
 * without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell  
 * copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the  
 * following conditions:  
 * 
 * The above copyright notice and this permission notice shall be included in all copies or substantial  
 * portions of the Software.  
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT  
 * LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO  
 * EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER  
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR  
 * THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 * 
 */

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
			titleColor: "#"+((1<<24)*Math.random()|0).toString(16),
			leftImage: 'KS_nav_ui.png',
			subtitle:'H!',
			hasChild:false,
			backgroundImage: 'KS_nav_ui.png'
		});
	}

	for(var i = 0; i < 10; i++) {
		data.push({
			title: 'Hello World #'+i,
			titleColor: "#"+((1<<24)*Math.random()|0).toString(16),
			leftImage: 'KS_nav_ui.png',
			subtitle:'H!',
			subtitleColor: 'green',
			hasChild:true,
			backgroundColor: 'red'
		});
	}

	for(var i = 0; i < 10; i++) {
		data.push({
			title: 'Hello World #'+i,
			subtitle:'H!',
			hasChild:true
		});
	}

	for(var i = 0; i < 10; i++) {
		data.push({
			title:'This is a ver long title, this is a very long title, this is a very long title, blah blah blah', subtitle:'This is a ver long title, this is a very long title, this is a very long title, blah blah blah',
			subtitle:'This is a ver long subtitle, this is a very long subtitle, this is a very long subtitle, blah blah blah', subtitle:'This is a ver long title, this is a very long title, this is a very long title, blah blah blah',
			rightImage: 'KS_nav_ui.png',
			leftImage: 'KS_nav_ui.png'
		});
	}
	for(var i = 0; i < 10; i++) {
		data.push({
			title: 'Title: Hello World #'+i,
			subtitle: 'Subtitle: Hello World #'+i,
		});
	}

	var table = TiTable.createTableView({
		backgroundColor: 'white',
		type: TiTable.SUBTITLE,
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