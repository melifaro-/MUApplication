//
//  SNSessionDelegate.h
//  CoolProject
//
//  Created by Igor Botov on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SNSessionProtocol <NSObject>

@optional

-(void)signup:(NSString*)login withPassword:(NSString*)password;

-(void)login;

-(void)login:(NSString*)login withPassword:(NSString*)password;

-(void)logout;

@end


@protocol SNSessionDelegate <NSObject>

- (void)didLogin;

- (void)didNotLogin:(BOOL)cancelled;

- (void)didLogout;

/**
 * Called when the current session has expired. This might happen when:
 *  - the access token expired
 *  - the app has been disabled
 *  - the user revoked the app's permissions
 *  - the user changed his or her password
 */
- (void)sessionInvalidated;

@end

