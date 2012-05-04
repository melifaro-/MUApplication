//
//  VKUser.m
//  CoolProject
//
//  Created by Igor Botov on 4/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VKUser.h"
#import "VKAccount.h"
#import "Vkontakte.h"

@interface VKUser(privateMethods)

-(void)parseUserProfileResponse:(id)response;
-(void)parseUserFriendsResponse:(id)response;

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

-(id)initWithResponse:(id)resp
{
    if (self = [super init])
    {
        [self parseUserProfileResponse:resp];
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
    NSLog(@"request result:\n %@", result);
    if (request == _userRequest)
    {
        [self parseUserProfileResponse:result];
        [userDelegate didProfileReceived];
    }
    else if (request == _userFriendsRequest)
    {
//        NSArray *friends = [result objectForKey:@"response"];
//        NSMutableArray *parsedFriends = [[NSMutableArray alloc] init];
//        for (id friend in friends)
//        {
//            VKUser *user = [[VKUser alloc] initWithResponse:friend];
//            [user setVkontakte:self.vkontakte];
//            [parsedFriends addObject:user];
//            [user release];
//        }
//        self.myFriends = parsedFriends;
//        [parsedFriends release];
//        [userDelegate didMyFriendsReceived];
    }
    else if (request == _profileRequest)
    {
    
    }
}

-(void)parseUserProfileResponse:(id)response
{
    response = [response objectForKey:@"response"];
    response = [response objectAtIndex:0];
    self.uid = [response objectForKey:@"uid"];
    self.name = [NSString stringWithFormat:@"%@ %@", [response objectForKey:@"first_name"], [response objectForKey:@"last_name"]];
    
    NSString *birthDayToString = [response objectForKey:@"bdate"];
    if (birthDayToString)
    {
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        self.birthday  =  [formater dateFromString:birthDayToString];
        [formater release];
    }
    
    self.sex = [response objectForKey:@"sex"];
    self.photoUrl = [response objectForKey:@"photo_medium"];

    if (self.photoUrl)
    {
        NSMutableURLRequest* request =
        [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.photoUrl]
                                cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                            timeoutInterval:180];
        [request setHTTPMethod:@"GET"];
        _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    }

    
    //        user.photo;
    //        user.status;
    //        user.location;
    self.timezone  =  [(NSString*)[response objectForKey:@"timezone"] integerValue];
    //        user.iterests;
    self.jobs = [response objectForKey:@"work"];
}

-(void)parseUserFriendsResponse:(id)response
{

}

//////////////////////////////////////////////////////////////////////////////////////////////////
// NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _responseText = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_responseText appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse
{
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection == _connection)
    {
        self.photo = [UIImage imageWithData:_responseText];
        [userDelegate didPhotoReceived];
    }
    [_responseText release];
    [_connection release];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"errors %@", error);
}

@end
