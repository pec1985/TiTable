Appcelerator Titanium iPhone Module Project
===========================================

## Getting Started
### Building the module from source

1. Open `titanium.xcconfig` in a text editor and make sure the paths are correct, as well as the Titanium SDK version  
2. Make sure Titanium is in your path, run this in the command line:  
` open ./bash_profile`.  
You should have something like this:  
`alias ti214='~/Library/Application\ Support/Titanium/mobilesdk/osx/2.1.4.GA/titanium.py'`  
If the `bash_profile` does not exist, create it and repeat this step.
3. Still in the terminal, `cd` to wherever you have this module in your hard drive and run it like so  
`ti214 run`
4. The app will run and show the content of the `app.js` located in the `/example` folder


## Documentation
-----------------------------

This module, the iOS version, exposes four standard UITableViewCell styles and a search bar on the top

### TableView Types:
- TiTable.TITLE_ONLY
- TiTable.SUBTITLE
- TiTable.VALUE_2
- TiTable.VALUE_2

### Row properties
#### The following properties apply to the TITLE_ONLY, SUBTITLE, VALUE_1, and VALUE_2 types of rows 
- title
- titleColor
- hasChild
- hasDetail
- hasCheck
- rightImage (must be local)

#### For the SUBTITLE, VALUE_1, and VALUE_2 there's also these two
- subtitle
- subtitleColor

## Layout gotcha
All the rows in the tableview must have the same layout, it cannot be changed. If you'd like to have different layouts, then this module is not for you.

## Search functionality
This TableView comes with a search bar built it, and right now there is no way through the JS to remove it. Sorry. It will search the content of the title and subtitle properties of the rows.

## How to use it
1. Create a variable to hold the module  
`var TiTable = require('ti.table');`
2. Create an array of rows  
`var data = [{title: 'meh', subtitle: 'meh meh'}, {title: 'meh', subtitle: 'meh meh'}];`
3. Create table view and set the data, make sure you **specify the table type**  
`var table = TiTable.createTableView({ type: TiTable.SUBTITLE, data: data });`
4. That's it!

## What next?
#### Fork the repo, create more row styles and enjoy it and submit pull requests!