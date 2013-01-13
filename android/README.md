Appcelerator Titanium Android Module Project
===========================================

## Getting Started
### Building the module from source

1. Open `build.properies` in a text editor and make sure the paths match your environment
2. Do the same for the `.classpath` (this is a hidden file)
3. Make sure the _command line tools_ are installed, these can be found in _Xcode's preferences_
4. Make sure `ant` is installed as well. Do this by typing `ant` in the terminal, something should show up
5. Open the `android` utility and launch an emulator
6. Still in the terminal, `cd` to wherever you have this module in your hard drive and run it like so `ant run` 
4. The app will run and show the content of the `app.js` located in the `/example` folder


## Documentation
-----------------------------

This module, the Android version, exposes two types of tableview row styles and a search bar on the top

### TableView Types:
- TiTable.TITLE_ONLY
- TiTable.SUBTITLE

### Row properties
- title
- titleColor
- subtitle
- subtitleColor
- hasChild
- rightImage (must be local)
- leftImage (must be local)


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

## How to extend it
1. Create an layout in the `platform/android/res/layout` folder
2. Subclass the `MainAdapter.java` located in the `src/ti/table/adapters`
3. Take a look at the `TableView.java` file and follow the patter
4. Create a constant `TableModule.java` and change the following code in `TableView.java` to use it   

----
    if(type == TableModule.TITLE_ONLY)  {
       adapter = new AdapterTitle(data, context, tiProxy);
    } else if(type == TableModule.SUBTITLE) {
       adapter = new AdapterSubtitle(data, context, tiProxy);
    }

## What next?
#### Fork the repo, create more row styles, enjoy it and submit pull requests!