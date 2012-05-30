//
//  Vkontakte.m
//  MSDK
//
//  Created by Alexander Petrovichev on 4/22/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import "Vkontakte.h"

static NSString* kRestserverBaseURL = @"https://api.vk.com/method/";
static NSString *requestFinishedKeyPath = @"state";
static void *finishedContext = @"finishedContext";


@interface Vkontakte ()

- (NSDictionary*)parseURLParams:(NSString *)query;


// private properties
@property(nonatomic, retain) NSArray* permissions;
@property(nonatomic, copy) NSString* appId;

@end

@implementation Vkontakte

@synthesize     accessToken = _accessToken,
                expirationDate = _expirationDate,
                sessionDelegate = _sessionDelegate,
                permissions = _permissions,
                urlSchemeSuffix = _urlSchemeSuffix,
                appId = _appId,
                userId;

- (id)initWithAppId:(NSString *)newAppId
        andDelegate:(id<SNSessionDelegate>)delegate
{
    if (self = [super init])
    {
        self.appId = newAppId;
        self.sessionDelegate = delegate;
        self.urlSchemeSuffix = @"vk";
    }
    return self;
}

- (void)dealloc {
    // this is the one case where the delegate is this object
    for (VKRequest* _request in _requests)
    {
        //?????
        [_request removeObserver:self forKeyPath:requestFinishedKeyPath];
    }
    [_accessToken release];
    [_expirationDate release];
    [_requests release];
    [_appId release];
    [_permissions release];
    [_urlSchemeSuffix release];
    [super dealloc];
}

- (void)invalidateSession
{
    assert(false);
    //to do: shall be implemented
}

/**
 * A private helper function for sending HTTP requests.
 *
 * @param url
 *            url to send http request
 * @param params
 *            parameters to append to the url
 * @param httpMethod
 *            http method @"GET" or @"POST"
 * @param delegate
 *            Callback interface for notifying the calling application when
 *            the request has received response
 */
- (VKRequest*)openUrl:(NSString *)url
               params:(NSMutableDictionary *)params
           httpMethod:(NSString *)httpMethod
             delegate:(id<VKRequestDelegate>)delegate
{
    if ([self isSessionValid])
    {
        [params setValue:self.accessToken forKey:@"access_token"];
    }
    
    VKRequest* _request = [VKRequest getRequestWithParams:params
                                               httpMethod:httpMethod
                                                 delegate:delegate
                                               requestURL:url];
    [_requests addObject:_request];
    [_request addObserver:self forKeyPath:requestFinishedKeyPath options:0 context:finishedContext];
    [_request connect];
    return _request;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == finishedContext)
    {
        VKRequest* _request = (VKRequest*)object;
        RequestState requestState = [_request state];
        if (requestState == kRequestStateComplete) {
            if ([_request sessionDidExpire]) {
                [self invalidateSession];
                if ([self.sessionDelegate respondsToSelector:@selector(sessionInvalidated)]) {
                    [self.sessionDelegate sessionInvalidated];
                }
            }
            [_request removeObserver:self forKeyPath:requestFinishedKeyPath];
            [_requests removeObject:_request];
        }
    }
}

- (void)authorize:(NSArray *)newPermissions
{
    self.permissions = newPermissions;

    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   _appId, @"client_id",
                                   @"", @"redirect_uri",
                                   @"touch", @"display",
                                   @"token", @"response_type",
                                   nil];
    if (_permissions != nil)
    {
        NSString* scope = [_permissions componentsJoinedByString:@","];
        [params setValue:scope forKey:@"scope"];
    }
     NSString *nextUrl = @"http://iebotov.narod2.ru/vk.html";
    [params setValue:nextUrl forKey:@"redirect_uri"];

    NSString *vkUrl = [VKRequest serializeURL:@"http://oauth.vk.com/authorize" params:params httpMethod:@"GET"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:vkUrl]];
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    NSLog(@"url %@", url);
    // If the URL's structure doesn't match the structure used for Facebook authorization, abort.
    if (![[url absoluteString] hasPrefix:[NSString stringWithFormat:@"vk%@://",
                                          _appId]]) {
        return NO;
    }

    NSString *query = [url fragment];

    if (!query)
    {
        query = [url query];
    }
    
    NSDictionary *params = [self parseURLParams:query];
    NSString *newAccessToken = [params objectForKey:@"access_token"];
    NSString *newUserId = [params objectForKey:@"user_id"];
    
    // If the URL doesn't contain the access token, an error has occurred.
    if (!newAccessToken)
    {
        //check errors
        return YES;
    }
    
    // We have an access token, so parse the expiration date.
    NSString *expTime = [params objectForKey:@"expires_in"];
    NSDate *newExpirationDate = [NSDate distantFuture];
    if (expTime != nil) {
        int expVal = [expTime intValue];
        if (expVal != 0) {
            newExpirationDate = [NSDate dateWithTimeIntervalSinceNow:expVal];
        }
    }
    [self vkbDialogLogin:newAccessToken expirationDate:newExpirationDate userId:newUserId];
    return YES;
}

- (void)logout
{
    [self invalidateSession];

    if ([self.sessionDelegate respondsToSelector:@selector(didLogout)])
    {
        [self.sessionDelegate didLogout];
    }
}

- (void)logout:(id<SNSessionDelegate>)delegate
{
    [self logout];

    if (delegate != self.sessionDelegate &&
        [delegate respondsToSelector:@selector(didLogout)]) {
        [delegate didLogout];
    }
}

- (VKRequest*)requestWithMethodName:(NSString *)methodName
                          andParams:(NSMutableDictionary *)params
                      andHttpMethod:(NSString *)httpMethod
                        andDelegate:(id <VKRequestDelegate>)delegate
{
    NSString * fullURL = [kRestserverBaseURL stringByAppendingString:methodName];
    return [self openUrl:fullURL
                  params:params
              httpMethod:httpMethod
                delegate:delegate];
}

- (BOOL)isSessionValid
{
    return (self.accessToken != nil && self.expirationDate != nil
            && NSOrderedDescending == [self.expirationDate compare:[NSDate date]]);
}


- (void)vkbDialogLogin:(NSString *)newToken expirationDate:(NSDate *)newExpirationDate userId:(NSString*)newUserId
{
    self.accessToken = newToken;
    self.expirationDate = newExpirationDate;
    self.userId = newUserId;
    if ([self.sessionDelegate respondsToSelector:@selector(didLogin)])
    {
        [self.sessionDelegate didLogin];
    }
}
    
///**
// * Did not login call the not login delegate
// */
//- (void)fbDialogNotLogin:(BOOL)cancelled {
//    if ([self.sessionDelegate respondsToSelector:@selector(fbDidNotLogin:)]) {
//        [self.sessionDelegate fbDidNotLogin:cancelled];
//    }
//}


/**
 * A function for parsing URL parameters.
 */
- (NSDictionary*)parseURLParams:(NSString *)query
{
	NSArray *pairs = [query componentsSeparatedByString:@"&"];
	NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
	for (NSString *pair in pairs) {
		NSArray *kv = [pair componentsSeparatedByString:@"="];
		NSString *val =
        [[kv objectAtIndex:1]
         stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
		[params setObject:val forKey:[kv objectAtIndex:0]];
	}
    return params;
}

@end
