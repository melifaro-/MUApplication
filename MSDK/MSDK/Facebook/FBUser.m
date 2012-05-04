//
//  FBUser.m
//  CoolProject
//
//  Created by Igor Botov on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FBUser.h"
#import "FBConnect.h"

@interface FBUser()

-(void)parseUserProfileResponse:(id)response;
-(void)parseUserFriendsResponse:(id)response;

@end

@implementation FBUser

@synthesize facebook;

-(id)initWithResponse:(id)resp
{
    if (self = [super init])
    {
        [self parseUserProfileResponse:resp];
    }
    return self;
}

-(void)fillProfile
{
    _profileRequest = [facebook requestWithGraphPath:self.uid andDelegate:self];
}

-(void)getUserById:(NSString *)userId
{
    _userRequest = [facebook requestWithGraphPath:userId andDelegate:self];
}

-(void)getUserFriends
{
    _userFriendsRequest = [facebook requestWithGraphPath:[NSString stringWithFormat:@"%@/friends", self.uid] andDelegate:self];
}

#pragma mark - FBRequest Delegate Methods

-(void)request:(FBRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"request did fail with errors:\n %@", error);
}

-(void)request:(FBRequest *)request didLoad:(id)result
{
    NSLog(@"request %@", request);
    NSLog(@"request result:\n %@", result);
    if (request == _userRequest || request == _profileRequest)
    {
        [self parseUserProfileResponse:result];
        [userDelegate didUserReceived];
    }
    else if (request == _userFriendsRequest)
    {
        NSArray *friendsToParse = [result objectForKey:@"data"];
        NSMutableArray *parsedFriends = [[NSMutableArray alloc] init];
        for (id friend in friendsToParse)
        {
            FBUser *user = [[FBUser alloc] initWithResponse:friend];
            [user setFacebook:self.facebook];
            [parsedFriends addObject:user];
            [user release];
        }
        self.friends = parsedFriends;
        [parsedFriends release];
        [userDelegate didUserFriendsReceived];
    }
}

-(void)dealloc
{
    self.facebook = nil;
    [super dealloc];
}

-(void)parseUserProfileResponse:(id)response
{
    self.uid = [response objectForKey:@"id"];
    self.name = [response objectForKey:@"name"];
    //        user.birthday  = [result objectForKey:@"name"];
    self.sex = [response objectForKey:@"gender"];
    //        user.photoUrl;
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

@end
