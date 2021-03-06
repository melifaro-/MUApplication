//
//  AppDelegate.m
//  MeetUP
//
//  Created by Alexander Petrovichev on 4/9/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import "AppDelegate.h"
#import "UISplashViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabController;
@synthesize navigationController = _navigationController;

- (void)dealloc
{
    [_window release];
    [_navigationController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    UISplashViewController *viewController = [[[UISplashViewController alloc] initWithNibName:@"MPUIView" bundle:nil] autorelease];
    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:viewController] autorelease];
    self.navigationController.navigationBar.hidden = YES;
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

// Pre iOS 4.2 support
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if([[MUAccount sharedMUAccount] handleOpenURL:url])
        return YES;
    else
        return NO;
}

// For iOS 4.2+ support
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if([[MUAccount sharedMUAccount] handleOpenURL:url])
        return YES;
    else
        return NO;
}

+(AppDelegate*)getInstance
{
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

@end
