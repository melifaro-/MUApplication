//
//  VKViewController.h
//  CoolProject
//
//  Created by Igor Botov on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUAccount.h"
#import "VKUser.h"

@interface VKViewController : UIViewController <SNSessionDelegate, SNUserDelegate>
{
    IBOutlet UITextView *myTextView;
    IBOutlet UIImageView *myImage;
    VKUser              *_user;
    VKAccount           *_vka;
    MUAccount           *_muAccount;
}
-(void)setData:(MUAccount*)account;

-(IBAction)loginButtonTouched:(id)sender;
-(IBAction)getMeButtonTouched:(id)sender;
-(IBAction)getMyFriendsButtonTouched:(id)sender;

@end
