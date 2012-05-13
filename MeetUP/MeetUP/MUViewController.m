//
//  MUViewController.m
//  MSDK
//
//  Created by Alexander Petrovichev on 4/30/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import "MUViewController.h"
#import "AppDelegate.h"

@interface MUViewController(private)

-(void)initMeetUpInstances;

@end

@implementation MUViewController(private)

-(void)initMeetUpInstances
{
    _muAccount = [AppDelegate getInstance].muAccount;
    [_muAccount setSessionDelegate:self];
    _muUser = _muAccount.muUser;
}

@end

@implementation MUViewController

-(id)init
{
    if (self = [super init])
    {
        [self initMeetUpInstances];
    }
    return self;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        [self initMeetUpInstances];
    }
    return self;
}

-(IBAction)loginButtonTouched:(id)sender
{
    [_muAccount login:_loginTextField.text withPassword:_pswdTextField.text];
}

-(IBAction)loginWithFBButtonTouched:(id)sender
{
    [_muAccount loginWithSocialNetwork:_muAccount.fbAccount];
}

-(IBAction)loginWithVKButtonTouched:(id)sender
{
    [_muAccount loginWithSocialNetwork:_muAccount.vkAccount];
}

-(IBAction)signupButtonTouched:(id)sender
{
    [_muAccount signup:_loginTextField.text withPassword:_pswdTextField.text];
}

-(IBAction)logoutButtonTouched:(id)sender
{
    [_muAccount logout];
}

-(IBAction)saveProfileButtonTouched:(id)sender
{
    [_muAccount save];
}

-(IBAction)resetProfileButtonTouched:(id)sender
{
    [MUAccount reset];
}

-(IBAction)updateProfileButtonTouched:(id)sender
{
    [_muUser updateProfile];
}

-(IBAction)userButtonTouched:(id)sender
{
    [_muUser getUserById:_muUser.uid];
}

-(IBAction)usersButtonTouched:(id)sender
{
    [_muUser getNearbyUsers];
}

- (void)didLogin
{
    [_infoTextView setText:@"Did login"];
}

- (void)didNotLogin:(BOOL)cancelled
{
    [_infoTextView setText:@"didNotLogin"];
}

- (void)didLogout
{
    [_infoTextView setText:@"didLogout"];
}

- (void)sessionInvalidated
{
    [_infoTextView setText:@"sessionInvalidated"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"MUViewController" owner:self options:nil];
    UIView* sview = [array objectAtIndex:0];
    sview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    sview.frame = CGRectMake(0, 0, self.viewContent.frame.size.width, self.viewContent.frame.size.height);
    self.navBar.hidden = NO;
    self.backButton.hidden = NO;
    self.nextButton.hidden = YES;
    self.title = @"MU Test";
    [self layoutNavigationBar];
    [self.viewContent addSubview:sview];
}

@end
