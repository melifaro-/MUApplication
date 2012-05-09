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
    NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"SplitView" owner:self options:nil];
    SplitView* sview = [array objectAtIndex:0];
    sview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    sview.frame = CGRectMake(-240.0, 0, self.view.frame.size.width, self.view.frame.size.height);
    sview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:sview];
    UIMainView *middleView = [[[UIMainView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)] autorelease];
    [sview setMiddleView:middleView];
  //  UIMenuView *leftView = [[[UIMenuView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)] autorelease];
   // [sview setLeftView:leftView];
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
