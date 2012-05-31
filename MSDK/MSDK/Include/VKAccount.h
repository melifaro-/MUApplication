//
//  VKAccount.h
//  MSDK
//
//  Created by Alexander Petrovichev on 4/22/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNAccount.h"
#import "VKUser.h"
#import "RequestDelegates.h"
#import "SNSessionDelegate.h"

#define VK_APP_ID @"2918722"
#define SECRET_KEY @"gtuPiPdq0d56eL5oWBn9" //todo move from code

@class Vkontakte;

@interface VKAccount : SNAccount <SNSessionDelegate, VKRequestDelegate, NSCoding>
{
    Vkontakte   *vkontakte;
    VKUser      *_vkUser;
}

@property (nonatomic, retain) Vkontakte *vkontakte;
@property (nonatomic, retain) VKUser    *vkUser;

+ (VKAccount*)getInstance;

- (BOOL)handleOpenURL:(NSURL *)url;

@end
