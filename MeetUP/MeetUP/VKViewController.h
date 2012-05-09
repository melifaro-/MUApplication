//
//  VKViewController.h
//  MSDK
//
//  Created by Alexander Petrovichev on 4/19/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUAccount.h"
#import "VKUser.h"
#import "MPUIView.h"

@interface VKViewController : MPUIView <SNSessionDelegate, SNUserDelegate>
{
    IBOutlet UITextView *myTextView;
    IBOutlet UIImageView *myImage;
    VKUser              *_user;
    VKAccount           *_vka;
    MUAccount           *_muAccount;
}

-(IBAction)loginButtonTouched:(id)sender;
-(IBAction)getMeButtonTouched:(id)sender;
-(IBAction)getMyFriendsButtonTouched:(id)sender;

@end
