//
//  FBAccount.m
//  MSDK
//
//  Created by Alexander Petrovichev on 4/21/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import "FBAccount.h"
#import "FBConnect.h"

@implementation FBAccount

@synthesize facebook;

-(id)init
{
    if (self = [super init])
    {
        self.facebook = [[Facebook alloc] initWithAppId:APP_ID andDelegate:self];
        [facebook release];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder])
    {
        self.facebook = [[Facebook alloc] initWithAppId:APP_ID andDelegate:self];
        [facebook release];
        //if (self.authkey && self.expDate && [self.expDate compare:[NSDate date]] == NSOrderedDescending)
        {
            facebook.accessToken = authkey;
            facebook.expirationDate = expDate;
        }
    }
    return self;
}

- (NSString*)snType
{
    return @"facebook";
}

-(void)dealloc
{
    self.facebook = nil;
    [super dealloc];
}

#pragma mark - Facebook Methods

- (BOOL)handleOpenURL:(NSURL *)url
{
    return [facebook handleOpenURL:url];
}

#pragma mark - FBRequest Delegate Methods

- (void)fbDidLogin
{
    self.authkey = facebook.accessToken;
    self.expDate = facebook.expirationDate;
    [sessionDelegate didLogin];
}

- (void)fbDidNotLogin:(BOOL)cancelled
{
    [sessionDelegate didNotLogin:cancelled];
}

/**
 * Called after the access token was extended. If your application has any
 * references to the previous access token (for example, if your application
 * stores the previous access token in persistent storage), your application
 * should overwrite the old access token with the new one in this method.
 * See extendAccessToken for more details.
 */
- (void)fbDidExtendToken:(NSString*)accessToken
               expiresAt:(NSDate*)expiresAt
{
    //to do staff work
}

- (void)fbDidLogout
{
    self.authkey = facebook.accessToken;
    self.expDate = facebook.expirationDate;
    [sessionDelegate didLogout];
}

/**
 * Called when the current session has expired. This might happen when:
 *  - the access token expired
 *  - the app has been disabled
 *  - the user revoked the app's permissions
 *  - the user changed his or her password
 */
- (void)fbSessionInvalidated
{
    [sessionDelegate sessionInvalidated];
}


#pragma mark - FBRequest Delegate Methods

-(void)request:(FBRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"request did fail with errors:\n %@", error);
}

-(void)request:(FBRequest *)request didLoad:(id)result
{

}

#pragma mark - Class Methods

-(void)login
{
    if(![facebook isSessionValid])
    {
        NSArray *permissions = [[NSArray alloc] initWithObjects:
                                @"user_likes", 
                                @"read_stream",
                                @"user_photos",
                                nil];
        [facebook authorize:permissions];
        [permissions release];
    }
}

-(void)logout
{
    [facebook logout];
}

@end
