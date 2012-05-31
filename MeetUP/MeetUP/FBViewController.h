//
//  ViewController.h
//  MSDK
//
//  Created by Alexander Petrovichev on 4/19/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUAccount.h"
#import "FBUser.h"
#import "MPUIView.h"
    
@interface FBViewController : MPUIView <SNSessionDelegate, SNUserDelegate>
{
    IBOutlet UITextView *myInfoTextView;
    IBOutlet UIImageView*   _userPicture;
    FBUser              *_fbUser;
    FBAccount           *_fba;
    MUAccount           *_muAccount;
}

-(IBAction)loginButtonTouched:(id)sender;
-(IBAction)logoutButtonTouched:(id)sender;
-(IBAction)getMyFriendsButtonTouched:(id)sender;
-(IBAction)getMeButtonTouched:(id)sender;
-(IBAction)getMyAlbumsTouched:(id)sender;

@end
