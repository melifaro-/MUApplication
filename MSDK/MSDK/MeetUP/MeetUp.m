//
//  MeetUp.m
//  MSDK
//
//  Created by Alexander Petrovichev on 4/30/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import "MeetUp.h"
#import "SNAccount.h"

static NSString* kRestserverBaseURL = @"http://aipmedia.ru:3001/";

@interface MeetUp ()

- (NSDictionary*)parseURLParams:(NSString *)query;

@end

@implementation MeetUp

@synthesize     accessToken = _accessToken,
                sessionDelegate = _sessionDelegate,
                userId = _userId;

- (id)initWithSessionDelegate:(id<SNSessionDelegate>)delegate
{
    if (self = [super init])
    {
        self.sessionDelegate = delegate;
    }
    return self;
}

- (void)dealloc
{
    [_accessToken release];
    [_requests release];
    [_userId release];
    [super dealloc];
}

- (void)invalidateSession
{
    self.accessToken = nil;
}

- (MURequest*)openUrl:(NSString *)url
               params:(NSMutableDictionary *)params
           httpMethod:(NSString *)httpMethod
             delegate:(id<MURequestDelegate>)delegate
{
    if ([self isSessionValid])
    {
        [params setValue:self.accessToken forKey:@"key"];
    }

    MURequest* _request = [MURequest getRequestWithParams:params
                                               httpMethod:httpMethod
                                                 delegate:delegate
                                               requestURL:url];
    [_requests addObject:_request];
    [_request connect];
    return _request;
}

-(void)signup:(NSString*)login withPassword:(NSString*)password
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   login, @"login",
                                   password, @"password",
                                   @"true", @"signup",
                                   nil];
    _loginRequest = [self requestWithMethodName:@"authentication" andParams:params andHttpMethod:@"POST" andDelegate:self];
}

-(void)login:(NSString*)login withPassword:(NSString*)password
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   login, @"login",
                                   password, @"password",
                                   @"false", @"signup",
                                   nil];
    _loginRequest = [self requestWithMethodName:@"authentication" andParams:params andHttpMethod:@"POST" andDelegate:self];
}

-(void)loginWithSNAccount:(SNAccount*)snAccount
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   snAccount.snType, @"provider",
                                   nil];
    if (snAccount.authkey)
    {
        [params setValue:snAccount.authkey forKey:@"key"];
    }
    _snLoginRequest = [self requestWithMethodName:@"authentication" andParams:params andHttpMethod:@"POST" andDelegate:self];
}

- (void)logout
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    _logoutRequest = [self requestWithMethodName:@"authentication" andParams:params andHttpMethod:@"DELETE" andDelegate:self];
}

- (MURequest*)requestWithMethodName:(NSString *)methodName
                          andParams:(NSMutableDictionary *)params
                      andHttpMethod:(NSString *)httpMethod
                        andDelegate:(id <MURequestDelegate>)delegate
{
    NSString * fullURL = [kRestserverBaseURL stringByAppendingString:methodName];
    return [self openUrl:fullURL
                  params:params
              httpMethod:httpMethod
                delegate:delegate];
}

- (BOOL)isSessionValid
{
    return (self.accessToken != nil);
}

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

#pragma mark - MURequest Delegate Methods

-(void)request:(MURequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"request did fail with errors:\n %@", error);

    if ([self.sessionDelegate respondsToSelector:@selector(didFailWithErrors:)])
    {
        [self.sessionDelegate didFailWithErrors:error];
    }
}

-(void)request:(MURequest *)request didLoad:(id)result
{
    NSLog(@"request:\n %@", request);
    NSLog(@"result:\n %@", result);
    if (request == _loginRequest)
    {
        self.userId = [result objectForKey:@"user_id"];
        self.accessToken = [result objectForKey:@"key"];
        if ([self isSessionValid])
        {
             [_sessionDelegate didLogin];
        }
        else
        {
            [_sessionDelegate didNotLogin:NO];
        }
    }
    else if (request == _logoutRequest)
    {
        [self invalidateSession];
        
        if ([self.sessionDelegate respondsToSelector:@selector(didLogout)])
        {
            [self.sessionDelegate didLogout];
        }
    }
    else if (request == _snLoginRequest)
    {
    
    }
}

@end
