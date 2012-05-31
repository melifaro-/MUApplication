//
//  FBUser.h
//  MSDK
//
//  Created by Alexander Petrovichev on 4/21/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
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
    FBRequest   *_pictureURLRequest;
    FBRequest   *_pictureRequest;
}

@property (nonatomic, retain) Facebook  *facebook;

-(id)initWithResponse:(id)resp;

-(void)fillProfile;
-(void)getUserFriends;
-(void)getUserById:(NSString*)userId;
-(void)getUserPicture;

@end
