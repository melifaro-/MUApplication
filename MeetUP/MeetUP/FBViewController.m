//
//  ViewController.m
//  CoolProject
//
//  Created by Igor Botov on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FBViewController.h"
#import "AppDelegate.h"

@implementation FBViewController

-(void)setData:(MUAccount*)account
{
    _muAccount = account;
    fba = _muAccount.fbAccount;
    [fba setSessionDelegate:self];
}


-(IBAction)loginButtonTouched:(id)sender
{
    [fba login];
}
-(IBAction)logoutButtonTouched:(id)sender
{
    [fba logout];
}

-(IBAction)getMeButtonTouched:(id)sender
{
    fbUser = [[FBUser alloc] init];
    [fbUser setUid:@"me"];
    [fbUser setFacebook:fba.facebook];
    [fbUser setUserDelegate:self];
    [fbUser fillProfile];
}

-(IBAction)getMyFriendsButtonTouched:(id)sender
{
    if (fbUser)
    {
        [fbUser getUserFriends];
    }
}

-(IBAction)getMyAlbumsTouched:(id)sender
{
//    Facebook *facebook = [AppDelegate appDelegate].facebook;
//    [facebook requestWithGraphPath:@"me/albums" andDelegate:self];
}

- (void)didLogin
{
    myInfoTextView.text = @"didLogin";
}

- (void)didNotLogin:(BOOL)cancelled
{
    myInfoTextView.text = [NSString stringWithFormat:@"didNotLogin %d", cancelled];
}

- (void)didLogout
{
    myInfoTextView.text = @"didLogout";
}

- (void)sessionInvalidated
{
    myInfoTextView.text = @"sessionInvalidated";
}

-(void)didProfileReceived
{
    [myInfoTextView setText:@"didProfileReceived"];
}

-(void)didUserReceived
{
    [myInfoTextView setText:@"didUserReceived"];
}

-(void)didUserFriendsReceived
{
    [myInfoTextView setText:@"didUserFriendsReceived"];
}

-(void)didPhotoReceived
{
    myInfoTextView.text = @"[myImage setImage:_user.photo]";
}

@end
