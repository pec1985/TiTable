# Ti.Table Native Module

## Versions:
- iPhone: 1.0
- Android: 1.0

## Description:
This module has been created for performance and speed. It is simply a TableView module that exposes some different types of TableViewRows

## Table Styles
### So far two styles are cross platform:
- TITLE_ONLY
- SUBTITLE

### For iOS there are two more:
- VALUE_1
- VALUE_2

## How to use
Create a simple Javascript array with objects, and add parameters according to the TableView style


    var TiTable = require('ti.table');

    var data = [
        {title: 'hello', subtitle : 'world'},
        {title: 'hello', subtitle : 'world'}
    ];

    var tableView = TiTable.createTableView({
        backgroundColor: 'white',
        data: data
    });


## What next!?
### Contribute!
Please, play around with the code and extend it!   
The idea is to expose the most commonly used types of tableviews and make the table load fast, as well as scroll fast!

## How to contribute
### Just like any other open source project,
1. Fork
2. Clone
3. Make changes, additions, etc..
4. Test it, create a sample test the follows the patter of what's already there
5. Submit pull request

### What this is for
I'd like to see a lot more table view row types for both platforms, iOS and Android. The API needs to be as simple as possible: TableView type and array of JS objects to create the data.  
What ever contribution is made, it _does not_ need to be cross platform, although it would be nice.

## License:

    Copyright (c) 2013 Pedro Enrique

    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and  
    associated documentation files (the "Software"), to deal in the Software without restriction, including  
    without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell  
    copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the  
    following conditions:  
    
    The above copyright notice and this permission notice shall be included in all copies or substantial  
    portions of the Software.  
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT  
    LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO  
    EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER  
    IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR  
    THE USE OR OTHER DEALINGS IN THE SOFTWARE.


## Follow me on twitter
### [@pecdev](http://twitter.com/pecdev)
### [@pec1985](http://twitter.com/pec1985)