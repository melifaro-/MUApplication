//
//  MPUIView.m
//  MeetUP
//
//  Created by Alexander Petrovichev on 4/27/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import "MPUIView.h"

@implementation MPUIView
@synthesize viewContent;
@synthesize navBar;
@synthesize backButton;
@synthesize nextButton;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    viewContent = nil;
    navBar = nil;
    backButton = nil;
    nextButton = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - IBActions

- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextButtonPressed:(id)sender
{

}

- (void)layoutNavigationBar
{
    if (navBar.hidden == YES)
    {
        viewContent.frame = self.view.frame;
    }
}

@end
