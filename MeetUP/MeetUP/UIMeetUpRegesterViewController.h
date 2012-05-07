//
//  UIMeetUpRegesterViewController.h
//  MeetUP
//
//  Created by Alexander Petrovichev on 5/7/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import "MPUIView.h"

@interface UIMeetUpRegesterViewController : MPUIView <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>
{
    UIImageView * photo;
}
@property (nonatomic, retain) IBOutlet UIImageView * photo;


-(IBAction) getPhoto:(id) sender;

@end
