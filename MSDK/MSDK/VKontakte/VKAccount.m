//
//  VKAccount.m
//  CoolProject
//
//  Created by Igor Botov on 4/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VKAccount.h"
#import "VKUser.h"
#import "Vkontakte.h"

static VKAccount* _vkAccount = nil;

@implementation VKAccount

@synthesize vkontakte;

+ (VKAccount*)getInstance
{
    return _vkAccount;
}

-(id)init
{
    if (self = [super init])
    {
        self.vkontakte = [[Vkontakte alloc] initWithAppId:VK_APP_ID andDelegate:self];
        [vkontakte release];
        _vkAccount = self;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder])
    {
        self.vkontakte = [[Vkontakte alloc] initWithAppId:VK_APP_ID andDelegate:self];
        [vkontakte release];
        //if (self.authkey && self.expDate && [self.expDate compare:[NSDate date]] == NSOrderedDescending)
        {
            vkontakte.accessToken = authkey;
            vkontakte.expirationDate = expDate;
        }
        _vkAccount = self;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [super encodeWithCoder:coder];
}

-(void)dealloc
{
    self.vkontakte = nil;
    self.userId = nil;
    [super dealloc];
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    return [vkontakte handleOpenURL:url];
}


-(void)login
{
    if(![vkontakte isSessionValid])
    {
        NSArray *permissions = [[NSArray alloc] initWithObjects:
                                @"friends", 
                                @"photos",
                                nil];
        [vkontakte authorize:permissions];
        [permissions release];
    }
}

-(void)logout
{
    
}

/**
 * Called when the user successfully logged in.
 */
- (void)didLogin
{
    self.authkey = vkontakte.accessToken;
    self.expDate = vkontakte.expirationDate;
    self.userId = vkontakte.userId;
    if ([sessionDelegate respondsToSelector:@selector(didLogin)])
    {
        [sessionDelegate didLogin];
    }
}

/**
 * Called when the user dismissed the dialog without logging in.
 */
- (void)didNotLogin:(BOOL)cancelled
{
    [sessionDelegate didNotLogin:cancelled];
}

/**
 * Called when the user logged out.
 */
- (void)didLogout
{
    self.authkey = vkontakte.accessToken;
    self.expDate = vkontakte.expirationDate;
    [sessionDelegate didLogout];
}

/**
 * Called when the current session has expired. This might happen when:
 *  - the access token expired
 *  - the app has been disabled
 *  - the user revoked the app's permissions
 *  - the user changed his or her password
 */
- (void)sessionInvalidated
{
    [sessionDelegate sessionInvalidated];
}


@end
