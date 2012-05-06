//
//  AppDelegate.h
//  MeetUP
//
//  Created by Igor Botov on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUAccount.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    MUAccount *muAccount;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UITabBarController *tabController;
@property (nonatomic, retain) MUAccount *muAccount;

+(AppDelegate*)appDelegate;

@end
