//
//  AppDelegate.h
//  MeetUP
//
//  Created by Alexander Petrovichev on 5/2/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUAccount.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UITabBarController *tabController;

+(AppDelegate*)getInstance;

@end
