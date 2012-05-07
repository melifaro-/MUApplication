//
//  MUViewController.m
//  CoolProject
//
//  Created by Igor Botov on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUViewController.h"
#import "AppDelegate.h"

@implementation MUViewController

-(void)setData:(MUAccount*)account
{
    _muAccount = account;
    [_muAccount setSessionDelegate:self];
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

@end
