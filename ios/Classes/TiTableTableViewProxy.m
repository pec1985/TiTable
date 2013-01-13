//
//  TiTableTableViewProxy.m
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

#import "TiTableTableViewProxy.h"
#import "TiTableTableView.h"

@implementation TiTableTableViewProxy

-(TiTableTableView *)table
{
	return (TiTableTableView *)[self view];
}

-(void)_initWithProperties:(NSDictionary *)properties
{
	[super _initWithProperties:properties];
	if([properties objectForKey:@"type"])
		[[self table] setType: [TiUtils intValue:[properties objectForKey:@"type"]]];


}

-(id)isEditing
{
	return NUMBOOL([self table].isEditing == YES);
}

-(void)scrollToTop:(id)args
{
	ENSURE_UI_THREAD(scrollToTop,args);
	NSInteger top = [TiUtils intValue:[args objectAtIndex:0]];
	NSDictionary *options = [args count] > 1 ? [args objectAtIndex:1] : nil;
	BOOL animated = [TiUtils boolValue:@"animated" properties:options def:YES];
	
	[[self table] scrollToTop:top animated:animated];
}


@end
