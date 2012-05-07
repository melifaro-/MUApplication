//
//  MUAccount.h
//  CoolProject
//
//  Created by Igor Botov on 4/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNAccount.h"
#import "SNSessionDelegate.h"
#import "RequestDelegates.h"
#import "FBAccount.h"
#import "VKAccount.h"

@class MeetUp;

@interface MUAccount : SNAccount <SNSessionDelegate , MURequestDelegate>
{
    MeetUp*     _meetup;
    FBAccount*  _fbAccount;
    VKAccount*  _vkAccount;
}

@property (nonatomic, retain) FBAccount *fbAccount;
@property (nonatomic, retain) VKAccount *vkAccount;
@property (nonatomic, retain) MeetUp *meetup;

-(BOOL)handleOpenURL:(NSURL *)url;

-(void)signup:(NSString*)login withPassword:(NSString*)password;
-(void)login:(NSString*)login withPassword:(NSString*)password;
-(void)loginWithSocialNetwork:(SNAccount*)snAccount;

-(void)save;
+(MUAccount*)restore;
+(void)reset;

@end
