//
//  FBUser.h
//  CoolProject
//
//  Created by Igor Botov on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNUser.h"

@class Facebook;
@class FBRequest;
@protocol FBRequestDelegate;

@interface FBUser : SNUser <FBRequestDelegate>
{
    Facebook    *facebook;
    FBRequest   *_profileRequest;
    FBRequest   *_userRequest;
    FBRequest   *_userFriendsRequest;
    
    NSURLConnection*      _connection;
    NSMutableData*        _responseText;
}

@property (nonatomic, retain) Facebook  *facebook;

-(id)initWithResponse:(id)resp;

-(void)fillProfile;
-(void)getUserFriends;
-(void)getUserById:(NSString*)userId;

@end
