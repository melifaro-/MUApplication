//
//  MeetUp.h
//  MSDK
//
//  Created by Alexander Petrovichev on 4/30/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MURequest.h"
#import "SNSessionDelegate.h"


@interface MeetUp : NSObject <MURequestDelegate>
{
    NSString* _accessToken;
    id<SNSessionDelegate> _sessionDelegate;
    NSMutableSet* _requests;
    NSString* _userId;

    MURequest*  _loginRequest;
    MURequest*  _logoutRequest;
}

@property(nonatomic, copy) NSString* accessToken;
@property(nonatomic, assign) id<SNSessionDelegate> sessionDelegate;
@property(nonatomic, copy) NSString* userId;

- (id)initWithSessionDelegate:(id<SNSessionDelegate>)delegate;

-(void)signup:(NSString*)login withPassword:(NSString*)password;
-(void)login:(NSString*)login withPassword:(NSString*)password;
- (void)logout;

- (MURequest*)requestWithMethodName:(NSString *)methodName
                          andParams:(NSMutableDictionary *)params
                      andHttpMethod:(NSString *)httpMethod
                        andDelegate:(id <MURequestDelegate>)delegate;

- (BOOL)isSessionValid;

@end