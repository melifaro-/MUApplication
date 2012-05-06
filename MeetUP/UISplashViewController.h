//
//  UISplashViewController.h
//  MeetUP
//
//  Created by Alexander Petrovichev on 4/27/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "MPUIView.h"

@interface UISplashViewController : MPUIView

-(void)performTransition;
- (IBAction)regesterViaSocialNetworks:(id)sender;
- (IBAction)regesterViaMeetUp:(id)sender;

@end
