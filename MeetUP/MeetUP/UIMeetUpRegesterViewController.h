//
//  UIMeetUpRegesterViewController.h
//  MeetUP
//
//  Created by Alexander Petrovichev on 5/7/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import "MPUIView.h"
#import "MUAccount.h"

@interface UIMeetUpRegesterViewController : MPUIView <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, SNSessionDelegate>
{
    UIImageView * photo;
    IBOutlet UITextField*    _loginTextField;
    IBOutlet UITextField*    _pswdTextField;
    MUAccount*  _muAccount;
}
@property (nonatomic, retain) IBOutlet UIImageView * photo;

-(IBAction) getPhoto:(id) sender;

@end
