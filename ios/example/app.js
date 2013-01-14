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