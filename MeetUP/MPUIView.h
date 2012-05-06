//
//  MPUIView.h
//  MeetUP
//
//  Created by Alexander Petrovichev on 4/27/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPUIView : UIViewController
{
    IBOutlet UIView*   viewContent;
    IBOutlet UIView*   navBar;
    IBOutlet UIButton* backButton;
    IBOutlet UIButton* nextButton;
}

@property (nonatomic, retain) UIView* viewContent;
@property (nonatomic, retain) UIView* navBar;
@property (nonatomic, retain) UIButton* backButton;
@property (nonatomic, retain) UIButton* nextButton;

- (IBAction)backButtonPressed:(id)sender;
- (IBAction)nextNuttonPressed:(id)sender;
- (void)layoutNavigationBar;

@end
