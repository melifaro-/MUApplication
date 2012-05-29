//
//  UIMainView.m
//  MeetUP
//
//  Created by Alexander Petrovichev on 5/9/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import "UIMainView.h"
#import "SplitView.h"
#import "UIMainViewCell.h"

@implementation UIMainView
@synthesize mpuiView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        MPUIView* viewController = [[MPUIView alloc] initWithNibName:@"MPUIView" bundle:nil];
        self.mpuiView = viewController;
        [viewController release];
        UIView* navbarView = [mpuiView.view.subviews objectAtIndex:0];
        [self addSubview:navbarView];
        [self bringSubviewToFront:navbarView];
        for (id nextObject in navbarView.subviews)
        {
            if (nextObject == mpuiView.title)
            {
                // Title
                [(UILabel*)nextObject setText:@"meetUp"];
            } else if (nextObject == mpuiView.backButton)
            {
                [nextObject setHidden:NO];
                // Back Button
                [(UIButton*)nextObject removeTarget:mpuiView action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [(UIButton*)nextObject addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            } else if (nextObject == mpuiView.nextButton)
            {
                [nextObject setHidden:NO];
                // Next Button
                [(UIButton*)nextObject removeTarget:mpuiView action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [(UIButton*)nextObject addTarget:self action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        [mpuiView layoutNavigationBar];
        CGRect frame = CGRectMake(0.0, navbarView.self.frame.origin.y + navbarView.frame.size.height, self.frame.size.width, self.frame.size.height - navbarView.frame.size.height - navbarView.self.frame.origin.y);
        people = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        people.backgroundColor = [UIColor clearColor];
        people.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        people.delegate = self;
        people.rowHeight = 83;
        [people setContentInset:UIEdgeInsetsMake(10, 0, 0, 0)];
        people.dataSource = self;
        people.exclusiveTouch = YES;
        [self addSubview:people];
        [people reloadData];
    }
    return self;
}

- (void) nextButtonPressed:(id)sender
{
    [(SplitView*)self.superview toRightView];
}

- (void) backButtonPressed:(id)sender
{
    [(SplitView*)self.superview toLeftView];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [(SplitView*)self.superview toMiddleView];
}

#pragma mark - Table View Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return DISTANCE_COUNT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UIMainViewCell *cell = (UIMainViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"MainViewCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
        //cell = [[[UIMainViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    [cell setBackgroundColor:[UIColor greenColor]];
    [cell setContent:indexPath.row];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.textLabel.text = @"Hello";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //show account
   // [tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 63;
    }
    else
    {
        return 83;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    [headerView setFrame:CGRectMake(0, -10, 200, 20)];
    UILabel *headerLabel = [[UILabel alloc] init];
    [headerLabel setFrame:CGRectMake(0, -10, 150, 20)];
    [headerLabel setBackgroundColor:[UIColor redColor]];
    [headerLabel setTextColor:[UIColor blackColor]];
    if (section == DISTANCE_NEAR)
    {
        headerLabel.text = @"NEAR";
    }
    if (section == DISTANCE_METERS100)
    {
        headerLabel.text = @"100";
    }
    if (section == DISTANCE_METERS1000)
    {
        headerLabel.text = @"1000";
    }
    [headerView addSubview:headerLabel];
    return headerView;
}

    
@end
