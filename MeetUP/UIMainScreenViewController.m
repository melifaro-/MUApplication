//
//  UIMainScreenViewController.m
//  MeetUP
//
//  Created by Alexander Petrovichev on 5/9/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import "UIMainScreenViewController.h"
#import "SplitView.h"
#import "UIMainView.h"
#import "UIMenuView.h"

@implementation UIMainScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    SplitView *splitView = [[SplitView alloc] initWithFrame:CGRectMake(-240, 0, 800, 460)];
    [self.view addSubview:splitView];
    UIMainView *middleView = [[[UIMainView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)] autorelease];
    [splitView setMiddleView:middleView];;
    UIMenuView *leftView = [[[UIMenuView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)] autorelease];
    [splitView setLeftView:leftView];
    [splitView release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
