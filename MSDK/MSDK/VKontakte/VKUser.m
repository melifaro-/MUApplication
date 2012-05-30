//
//  VKUser.m
//  MSDK
//
//  Created by Alexander Petrovichev on 4/22/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import "VKUser.h"
#import "VKAccount.h"
#import "Vkontakte.h"

@interface VKUser(privateMethods)

-(void)parseUserProfileFromResponse:(id)response;

@end

@implementation VKUser

@synthesize vkontakte = _vkontakte;

-(id)init
{
    if (self = [super init])
    {
        self.vkontakte = [VKAccount getInstance].vkontakte;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.vkontakte = [VKAccount getInstance].vkontakte;
    }
    return self;
}

-(id)initWithResponse:(id)resp
{
    if (self = [super init])
    {
        [self parseUserProfileFromResponse:resp];
        self.vkontakte = [VKAccount getInstance].vkontakte;
    }
    return self;
}

-(void)dealloc
{
    [_profileRequest release];
    [_userRequest release];
    [_userFriendsRequest release];
    
    [_connection release];
    [_responseText release];
    self.vkontakte = nil;
    [super dealloc];
}

-(void)fillProfile
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   self.uid, @"uid",
                                   @"uid,first_name,last_name,nickname,sex,bdate,city,country,timezone,photo,photo_medium,photo_big,domain,has_mobile,rate,contacts,education", @"fields",
                                   nil];
    _userRequest = [_vkontakte requestWithMethodName:@"getProfiles" andParams:params andHttpMethod:@"GET" andDelegate:self];
}

-(void)getUserFriends
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   self.uid, @"uid",
                                   @"uid,first_name,last_name,nickname,sex,bdate,city,country,timezone,photo,photo_medium,photo_big,domain,has_mobile,rate,contacts,education", @"fields",
                                   nil];
    _userFriendsRequest = [_vkontakte requestWithMethodName:@"friends.get" andParams:params andHttpMethod:@"GET" andDelegate:self];
}

-(void)getUserById:(NSString*)userId
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   userId, @"uid",
                                   @"uid,first_name,last_name,nickname,sex,bdate,city,country,timezone,photo,photo_medium,photo_big,domain,has_mobile,rate,contacts,education", @"fields",
                                   nil];
    _userRequest = [_vkontakte requestWithMethodName:@"getProfiles" andParams:params andHttpMethod:@"GET" andDelegate:self];
}

#pragma mark - VKRequest Delegate Methods

-(void)request:(VKRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"request did fail with errors:\n %@", error);
}

-(void)request:(VKRequest *)request didLoad:(id)result
{
//    NSLog(@"request result:\n %@", result);
    result = [result objectForKey:@"response"];
    if (request == _userRequest)
    {
        result = [result objectAtIndex:0];
        [self parseUserProfileFromResponse:result];
        [userDelegate didProfileReceived];
    }
    else if (request == _userFriendsRequest)
    {
        NSMutableArray *parsedFriends = [[NSMutableArray alloc] init];
        for (id friend in result)
        {
            VKUser *user = [[VKUser alloc] initWithResponse:friend];
            [user setVkontakte:self.vkontakte];
            [parsedFriends addObject:user];
            [user release];
        }
        self.friends = parsedFriends;
        [parsedFriends release];
        [userDelegate didUserFriendsReceived];
    }
    else if (request == _profileRequest)
    {
    
    }
}

-(void)parseUserProfileFromResponse:(id)response
{
    id parsedUId = [response objectForKey:@"uid"];
    self.uid = [parsedUId isKindOfClass:[NSDecimalNumber class]] ? [parsedUId stringValue] : [NSString stringWithFormat:@"%@", parsedUId];
    self.name = [NSString stringWithFormat:@"%@ %@", [response objectForKey:@"first_name"], [response objectForKey:@"last_name"]];
    self.birthday = [response objectForKey:@"bdate"];
    self.sex = [response objectForKey:@"sex"];
    self.photoUrl = [response objectForKey:@"photo_medium"];
    [self downloadUserPhoto];

    //        user.status;
    //        user.location;
    self.timezone  =  [(NSString*)[response objectForKey:@"timezone"] integerValue];
    //        user.iterests;
    self.jobs = [response objectForKey:@"work"];
}

@end
