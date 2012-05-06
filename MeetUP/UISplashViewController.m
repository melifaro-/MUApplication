//
//  UISplashViewController.m
//  MeetUP
//
//  Created by Alexander Petrovichev on 4/27/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import "UISplashViewController.h"
#import "UIRegesterViewController.h"

@implementation UISplashViewController

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
    NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"UISplashViewController" owner:self options:nil];
    UIView* sview = [array objectAtIndex:0];
    sview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    sview.frame = CGRectMake(0, 0, self.viewContent.frame.size.width, self.viewContent.frame.size.height);
    sview.backgroundColor = [UIColor clearColor];
    self.navBar.hidden = YES;
    self.backButton.hidden = YES;
    self.nextButton.hidden = YES;
    self.title = @"Регистрация";
    [self layoutNavigationBar];
    [self.viewContent addSubview:sview];
    // Do any additional setup after loading the view from its nib.
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

#pragma mark - IBActions

-(void)performTransition
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.75f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
}

- (IBAction)regesterViaSocialNetworks:(id)sender
{
    UIRegesterViewController *viewController = [[[UIRegesterViewController alloc] initWithNibName:@"MPUIView" bundle:nil] autorelease];
    [self performTransition];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)regesterViaMeetUp:(id)sender
{
    
}

@end
