//
//  VKViewController.m
//  MSDK
//
//  Created by Alexander Petrovichev on 4/19/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import "VKViewController.h"
#import "AppDelegate.h"

@implementation VKViewController

-(void)setData:(MUAccount*)account
{
    _muAccount = account;
    _vka = _muAccount.vkAccount;
    [_vka setSessionDelegate:self];
}

-(IBAction)loginButtonTouched:(id)sender
{
    [_vka login];
}

-(IBAction)getMeButtonTouched:(id)sender
{
    _user = [[VKUser alloc] init];
    [_user setUserDelegate:self];
    [_user getUserById:_vka.userId];
}

-(IBAction)getMyFriendsButtonTouched:(id)sender
{
//    VKAccount *vkAccount = [AppDelegate appDelegate].vkAccount;
//    SNUser *user = [[SNUser alloc] init];
//    [user setUserDelegate:self];
//    [user getUserById:vkAccount.userId];
}

- (void)didLogin
{
    [myTextView setText:@"Did login"];
}

- (void)didNotLogin:(BOOL)cancelled
{
    [myTextView setText:@"didNotLogin"];
}

- (void)didLogout
{
    [myTextView setText:@"didLogout"];
}

- (void)sessionInvalidated
{
    [myTextView setText:@"sessionInvalidated"];
}

-(void)didProfileReceived
{
    [myTextView setText:@"didProfileReceived"];
}

-(void)didUserReceived
{
    [myTextView setText:@"didUserReceived"];
}

-(void)didUserFriendsReceived
{
    [myTextView setText:@"didUserFriendsReceived"];
}

-(void)didPhotoReceived
{
    [myImage setImage:_user.photo];
}

@end
