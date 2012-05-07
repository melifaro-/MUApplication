//
//  VKUser.h
//  MSDK
//
//  Created by Alexander Petrovichev on 4/22/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNUser.h"
#import "RequestDelegates.h"

@class Vkontakte;

@interface VKUser : SNUser <VKRequestDelegate>
{
    Vkontakte*  _vkontakte;
    VKRequest*  _profileRequest;
    VKRequest*  _userRequest;
    VKRequest*  _userFriendsRequest;

    NSURLConnection*      _connection;
    NSMutableData*        _responseText;
}

@property (nonatomic, retain) Vkontakte* vkontakte;

-(id)initWithResponse:(id)resp;

-(void)fillProfile;
-(void)getUserFriends;
-(void)getUserById:(NSString*)userId;

@end
