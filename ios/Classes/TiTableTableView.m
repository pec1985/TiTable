//
//  TiTableTableView.m
//  table
//
// Copyright (c) 2013 Pedro Enrique
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this
// software and associated documentation files (the "Software"), to deal in the Software
// without restriction, including without limitation the rights to use, copy, modify, merge,
// publish, distribute, sublicense, and/or sell copies of the Software, and to permit
// persons to whom the Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies
// or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
// INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
// PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
// FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "TiTableTableView.h"
#import "TableViewRow.h"


@implementation TiTableTableView

@synthesize type, isEditing, canEdit;

-(void)dealloc
{
	RELEASE_TO_NIL(table);
	RELEASE_TO_NIL(tableData);
	RELEASE_TO_NIL(searchBarDisplayController);
	RELEASE_TO_NIL(tableViewController);
	[super dealloc];
}
-(id)init
{
	if(self = [super init])
	{
		self.isEditing = NO;
		self.canEdit = NO;
		firstTime = NO;
		tableData = [[NSMutableArray alloc] init];
	}
	return self;
}

-(UITableViewController *)tableViewController
{
	if(!tableViewController)
	{
		tableViewController = [[UITableViewController alloc] init];
		tableViewController.tableView = [self table];
	}
	return tableViewController;
}


-(UITableView *)table
{
	if(!table)
	{
		table = [[UITableView alloc] init];
		table.delegate = self;
		table.dataSource = self;
		
		[self addSubview:[self searchBarDisplayController].searchContentsController.view];
	}
	
	return table;
}


-(UISearchBar *)searchBar
{
	if(!searchBar)
	{
		searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
		[searchBar setDelegate:self];
	}
	return searchBar;
}

-(UISearchDisplayController *)searchBarDisplayController
{
	if(!searchBarDisplayController){
		searchBarDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:[self searchBar] contentsController:[self tableViewController]];
		[searchBarDisplayController setDelegate: self];
		[searchBarDisplayController setSearchResultsDataSource: self];
		[searchBarDisplayController setSearchResultsDelegate: self];
		[[self table] setTableHeaderView: searchBarDisplayController.searchBar];
	}
	return searchBarDisplayController;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
	[tableData removeAllObjects];
	for(int i = 0, len = [searchData count]; i < len; i++){
	
		NSRange result1 = [[[searchData objectAtIndex:i] valueForKey:@"title"] rangeOfString:searchString options:NSCaseInsensitiveSearch];
		NSRange result2 = [[[searchData objectAtIndex:i] valueForKey:@"subtitle"] rangeOfString:searchString options:NSCaseInsensitiveSearch];
		if(result1.location != NSNotFound || result2.location != NSNotFound)
		{
			[tableData addObject: [searchData objectAtIndex:i]];
		}
		if([searchString isEqualToString:@""])
		{
			[tableData removeAllObjects];
			[tableData addObjectsFromArray:searchData];
		}
	
	}
	return YES;
}


-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
	[TiUtils setView:[self table] positionRect:bounds];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// See if there's an existing cell we can reuse
    TableViewRow *cell = [tableView dequeueReusableCellWithIdentifier:@"Foobar"];
    if (cell == nil) {
        // No cell to reuse => create a new one
		UITableViewCellStyle _type;
		switch (self.type){
			case 0: _type = UITableViewCellStyleDefault; break;
			case 1: _type = UITableViewCellStyleSubtitle; break;
			case 2: _type = UITableViewCellStyleValue1; break;
			case 3: _type = UITableViewCellStyleValue2; break;
			default: _type = UITableViewCellStyleDefault;
		}
		
        cell = [[[TableViewRow alloc] initWithStyle:_type reuseIdentifier:@"Foobar"] autorelease];
		cell.textLabel.textColor = [UIColor blackColor];
		cell.detailTextLabel.textColor = [UIColor darkGrayColor];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
	
	id _data = [tableData objectAtIndex:indexPath.row];

	if([_data isKindOfClass:[NSDictionary class]])
	{
		// ------- title and subtitle -------
		if([_data objectForKey:@"title"])
			[cell setTitle: [_data objectForKey:@"title"]];
		else
			[cell setTitle: @""];

		if([_data objectForKey:@"subtitle"])
			[cell setSubtile: [_data objectForKey:@"subtitle"]];
		else
			[cell setSubtile: @""];
	
		// ------- color of title and subtitle -------
		if([_data objectForKey:@"titleColor"])
	        cell.textLabel.textColor = [[TiUtils colorValue:[_data objectForKey:@"titleColor"]] _color];
		else
	        cell.textLabel.textColor = [UIColor blackColor];
				
		if([_data objectForKey:@"subtitleColor"])
	        cell.detailTextLabel.textColor = [[TiUtils colorValue:[_data objectForKey:@"subtitleColor"]] _color];
		else
	        cell.detailTextLabel.textColor = [UIColor blackColor];

		// ------- hasChild - hasDetail - hasCheck-------
		if([_data objectForKey:@"hasChild"])
			cell.accessoryType = [TiUtils boolValue:[_data objectForKey:@"hasChild"]] == YES ?
												UITableViewCellAccessoryDisclosureIndicator :
												UITableViewCellAccessoryNone;

		if([_data objectForKey:@"hasDetail"])
			cell.accessoryType = [TiUtils boolValue:[_data objectForKey:@"hasDetail"]] == YES ?
												UITableViewCellAccessoryDetailDisclosureButton :
												UITableViewCellAccessoryNone;
		if([_data objectForKey:@"hasCheck"])
			cell.accessoryType = [TiUtils boolValue:[_data objectForKey:@"hasCheck"]] == YES ?
												UITableViewCellAccessoryCheckmark :
												UITableViewCellAccessoryNone;
												
		if( ![_data objectForKey:@"hasChild"] && 
			![_data objectForKey:@"hasDetail"] && 
			![_data objectForKey:@"hasCheck"])
			cell.accessoryType = UITableViewCellAccessoryNone;
		
		// ------- images ----------
		if([_data objectForKey:@"leftImage"])
			cell.imageView.image = [UIImage imageNamed:[_data objectForKey:@"leftImage"]];
		else
			cell.imageView.image = nil;
			
		CGFloat height1 = cell.textLabel.frame.size.height;
		CGFloat height2 = cell.textLabel.frame.size.height;
		
		CGRect aFrame = cell.frame;
		aFrame.size.height = height1 + height2;
		[cell setFrame:aFrame];
	}
    return cell;
	
}

- (BOOL)tableView:(UITableView *)ourTableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(self.canEdit)
		return YES;
		
	return NO;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

	if(self.canEdit)
	{
		[tableData removeObjectAtIndex:indexPath.row];
		searchData = [tableData mutableCopy];
		[tableView beginUpdates];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
		[tableView endUpdates];
	}
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if ([self.proxy _hasListeners:@"click"])
	{
		NSMutableDictionary *event = [NSMutableDictionary dictionary];
		[event setObject:[tableData objectAtIndex:indexPath.row] forKey:@"rowData"];
		[self.proxy fireEvent:@"click" withObject:event];
	}
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{


	id _data = [tableData objectAtIndex:indexPath.row];
	NSString *title = @"";
	NSString *subtitle = @"";
	UIFont *titleFont = nil;
	UIFont *subTitleFont = nil;
	if([_data isKindOfClass:[NSDictionary class]])
	{
		// ------- title and subtitle -------
		if([_data objectForKey:@"title"])
			title = [_data objectForKey:@"title"];
		else
			title = @"";

		if([_data objectForKey:@"subtitle"])
			subtitle = [_data objectForKey:@"subtitle"];
		else
			subtitle = @"";
	}
	if(self.type == UITableViewCellStyleSubtitle)
	{
       	titleFont 		= [UIFont fontWithName:@"Helvetica-Bold" size:18];
		subTitleFont 	= [UIFont fontWithName:@"Helvetica" size:14];
 	}
   	if(self.type == UITableViewCellStyleValue1)
	{
       	titleFont 		= [UIFont fontWithName:@"Helvetica-Bold" size:17];
		subTitleFont 	= [UIFont fontWithName:@"Helvetica" size:17];
 	}
 	
   	if(self.type == UITableViewCellStyleValue2)
	{
       	titleFont 		= [UIFont fontWithName:@"Helvetica" size:15];
		subTitleFont 	= [UIFont fontWithName:@"Helvetica-Bold" size:15];
	}
   	if(self.type == UITableViewCellStyleDefault)
	{
       	titleFont 		= [UIFont fontWithName:@"Helvetica-Bold" size:20];
		subTitleFont 	= [UIFont fontWithName:@"Helvetica-Bold" size:0];
	}
   
   	if(titleFont == nil)
       	titleFont 		= [UIFont fontWithName:@"Helvetica-Bold" size:20];
   	if(subTitleFont == nil)
		subTitleFont 	= [UIFont fontWithName:@"Helvetica-Bold" size:20];
	
   CGSize constraintSize = CGSizeMake(tableView.frame.size.width - 40.0 - 50.0, CGFLOAT_MAX);
   CGSize labelSize = [title sizeWithFont: titleFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
   CGSize detailSize = [subtitle sizeWithFont: subTitleFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];

   CGFloat result = MAX(44.0, labelSize.height + detailSize.height + 12.0); 
   return result;
}



/*
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	return NO;
}
*/
/*
-(BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}
*/
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
	return YES;
}
-(BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
	YES;
}

-(void)scrollToTop:(NSInteger)top animated:(BOOL)animated
{
	[[self table] setContentOffset:CGPointMake(0,top) animated:animated];
}


-(void)removeRowAtIndex:(int)index
{
}

-(void)setData_:(id)args
{
	ENSURE_ARRAY(args);
	
	[tableData removeAllObjects];
	
	int len = [args count];
	for(int i = 0; i < len; i++)
	{
		[tableData addObject:[args objectAtIndex:i]];
	}
	searchData = [tableData mutableCopy];
	[table reloadData];
}

-(void)setRowHeight_:(id)args
{
	//[table setRowHeight:[TiUtils floatValue:args]];
}

-(void)setCanEdit_:(id)args
{
	self.canEdit = [TiUtils boolValue:args];
}
-(void)setEditable_:(id)args
{
	[table setEditing:[TiUtils boolValue:args] animated:YES];
	self.isEditing = [TiUtils boolValue:args];	
}



@end
