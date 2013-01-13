//
//  TableViewRow.m
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

#import "TableViewRow.h"

@implementation TableViewRow

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	aStyle = style;
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	[self.textLabel setNumberOfLines:0];
	[self.detailTextLabel setNumberOfLines:0];
	return self;
}

-(void)setNeedsLayout
{
	[super setNeedsLayout];

	CGRect titleFrame 		= self.textLabel.frame;
	CGRect subTitleFrame 	= self.detailTextLabel.frame;
   
	titleFrame.origin.y 		= 4.0;
	subTitleFrame.origin.y 	= 8.0 + titleFrame.size.height;
   
	[self.textLabel 		setFrame:titleFrame];
	[self.detailTextLabel 	setFrame:subTitleFrame];

}

-(void)setTitle:(NSString *)aTtile
{
	[self.textLabel setText:aTtile];
	[self setNeedsLayout];
}

-(void)setSubtile:(NSString *)aSubtile
{
	[self.detailTextLabel setText:aSubtile];
	[self setNeedsLayout];
}

@end
