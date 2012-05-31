//
//  Vkontakte.h
//  MSDK
//
//  Created by Alexander Petrovichev on 4/22/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNSessionDelegate.h"
#import "VKRequest.h"

@interface Vkontakte : NSObject
{
    NSString* _accessToken;
    NSDate* _expirationDate;
    id<SNSessionDelegate> _sessionDelegate;
    NSMutableSet* _requests;
    NSString* _appId;
    NSString* _urlSchemeSuffix;
    NSArray* _permissions;
//    BOOL _isExtendingAccessToken;
//    FBRequest *_requestExtendingAccessToken;
//    NSDate* _lastAccessTokenUpdate;
}

@property(nonatomic, copy) NSString* accessToken;
@property(nonatomic, copy) NSDate* expirationDate;
@property(nonatomic, copy) NSString* urlSchemeSuffix;
@property(nonatomic, assign) id<SNSessionDelegate> sessionDelegate;
@property(nonatomic, copy) NSString* userId;

- (id)initWithAppId:(NSString *)appId
        andDelegate:(id<SNSessionDelegate>)delegate;

- (void)authorize:(NSArray *)permissions;

- (BOOL)handleOpenURL:(NSURL *)url;

- (void)logout;

- (void)logout:(id<SNSessionDelegate>)delegate;

- (VKRequest*)requestWithMethodName:(NSString *)methodName
                          andParams:(NSMutableDictionary *)params
                      andHttpMethod:(NSString *)httpMethod
                        andDelegate:(id <VKRequestDelegate>)delegate;

- (BOOL)isSessionValid;

- (void)vkbDialogLogin:(NSString *)newToken expirationDate:(NSDate *)newExpirationDate userId:(NSString*)newUserId;

@end

@protocol VKSessionDelegate <NSObject>

/**
 * Called when the user successfully logged in.
 */
- (void)vkDidLogin;

/**
 * Called when the user dismissed the dialog without logging in.
 */
- (void)vkDidNotLogin:(BOOL)cancelled;

/**
 * Called when the user logged out.
 */
- (void)vkDidLogout;

/**
 * Called when the current session has expired. This might happen when:
 *  - the access token expired
 *  - the app has been disabled
 *  - the user revoked the app's permissions
 *  - the user changed his or her password
 */
- (void)vkSessionInvalidated;

@end