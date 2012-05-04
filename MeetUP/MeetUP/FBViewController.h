//
//  ViewController.h
//  CoolProject
//
//  Created by Igor Botov on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUAccount.h"
#import "FBUser.h"
    
@interface FBViewController : UIViewController <SNSessionDelegate, SNUserDelegate>
{
    IBOutlet UITextView *myInfoTextView;
    FBUser              *fbUser;
    FBAccount           *fba;
    MUAccount           *_muAccount;
}

-(void)setData:(MUAccount*)account;

-(IBAction)loginButtonTouched:(id)sender;
-(IBAction)logoutButtonTouched:(id)sender;
-(IBAction)getMyFriendsButtonTouched:(id)sender;
-(IBAction)getMeButtonTouched:(id)sender;
-(IBAction)getMyAlbumsTouched:(id)sender;

@end
