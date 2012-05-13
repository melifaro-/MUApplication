//
//  MUAccount.h
//  MSDK
//
//  Created by Alexander Petrovichev on 4/22/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNAccount.h"
#import "SNSessionDelegate.h"
#import "RequestDelegates.h"
#import "FBAccount.h"
#import "VKAccount.h"
#import "MUUser.h"

@class MeetUp;

@interface MUAccount : SNAccount <SNSessionDelegate , MURequestDelegate>
{
    MUUser*     _muUser;
    MeetUp*     _meetup;
    FBAccount*  _fbAccount;
    VKAccount*  _vkAccount;
}

@property (nonatomic, retain) MUUser    *muUser;
@property (nonatomic, retain) FBAccount *fbAccount;
@property (nonatomic, retain) VKAccount *vkAccount;
@property (nonatomic, retain) MeetUp *meetup;

+ (MUAccount*)sharedMUAccount;

-(BOOL)handleOpenURL:(NSURL *)url;

-(void)signup:(NSString*)login withPassword:(NSString*)password;
-(void)login:(NSString*)login withPassword:(NSString*)password;
-(void)loginWithSocialNetwork:(SNAccount*)snAccount;

-(void)save;
+(MUAccount*)restore;
+(void)reset;

@end
