//
//  UIMainView.m
//  MeetUP
//
//  Created by Alexander Petrovichev on 5/9/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import "UIMainView.h"
#import "SplitView.h"

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
        people = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        people.backgroundColor = [UIColor clearColor];
        people.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        people.delegate = self;
        people.dataSource = self;
        people.sectionHeaderHeight = 10.0;
        people.sectionFooterHeight = 10.0;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //show account
}
    
@end
