//
//  MUViewController.h
//  MSDK
//
//  Created by Alexander Petrovichev on 4/30/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUAccount.h"

@interface MUViewController : UIViewController <SNSessionDelegate>
{
    MUAccount           *_muAccount;

    IBOutlet UITextField*   _loginTextField;
    IBOutlet UITextField*   _pswdTextField;
    IBOutlet UITextView*    _infoTextView;
}

-(void)setData:(MUAccount*)account;

-(IBAction)signupButtonTouched:(id)sender;
-(IBAction)loginButtonTouched:(id)sender;
-(IBAction)logoutButtonTouched:(id)sender;
-(IBAction)saveProfileButtonTouched:(id)sender;

@end
