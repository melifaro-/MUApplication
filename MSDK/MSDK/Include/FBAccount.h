//
//  FBAccount.h
//  MSDK
//
//  Created by Alexander Petrovichev on 4/21/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNAccount.h"
#import "FBUser.h"

@class Facebook;
@protocol FBSessionDelegate;
@protocol FBRequestDelegate;

#define APP_ID @"296207290455558" //todo переместить в plist

@interface FBAccount : SNAccount <NSCoding, FBSessionDelegate, FBRequestDelegate>
{
    Facebook    *facebook;
}

@property (nonatomic, retain) Facebook *facebook;

-(BOOL)handleOpenURL:(NSURL *)url;

@end
