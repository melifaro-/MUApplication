//
//  UIMainPreferencesView.m
//  MeetUP
//
//  Created by iMac on 16.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIMainPreferencesView.h"

@implementation UIMainPreferencesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        CGRect frame = CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height);
        menu = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        menu.backgroundColor = [UIColor clearColor];
        menu.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        menu.delegate = self;
        menu.dataSource = self;
        menu.rowHeight = 90;
        menu.sectionHeaderHeight = 10.0;
        menu.sectionFooterHeight = 10.0;
        menu.exclusiveTouch = YES;
        [self addSubview:menu];
        [menu reloadData];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = @"Hello";
    
    return cell;
}

@end
