//
//  MUViewController.h
//  MSDK
//
//  Created by Alexander Petrovichev on 4/30/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUAccount.h"
#import "MPUIView.h"

@interface MUViewController : MPUIView <SNSessionDelegate>
{
    MUAccount               *_muAccount;
    MUUser                  *_muUser;

    IBOutlet UITextField*   _loginTextField;
    IBOutlet UITextField*   _pswdTextField;
    IBOutlet UITextView*    _infoTextView;
}

-(IBAction)signupButtonTouched:(id)sender;
-(IBAction)loginButtonTouched:(id)sender;
-(IBAction)logoutButtonTouched:(id)sender;
-(IBAction)saveProfileButtonTouched:(id)sender;
-(IBAction)resetProfileButtonTouched:(id)sender;

-(IBAction)loginWithFBButtonTouched:(id)sender;
-(IBAction)loginWithVKButtonTouched:(id)sender;

-(IBAction)updateProfileButtonTouched:(id)sender;
-(IBAction)userButtonTouched:(id)sender;
-(IBAction)usersButtonTouched:(id)sender;

@end
