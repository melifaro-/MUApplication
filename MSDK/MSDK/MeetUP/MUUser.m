//
//  MUUser.m
//  MSDK
//
//  Created by Alexander Petrovichev on 4/22/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import "MUUser.h"
#import "MeetUp.h"
#import "MUAccount.h"

@implementation MUUser

@synthesize meetup = _meetup;

-(id)init
{
    if (self = [super init])
    {
        self.meetup = [MUAccount sharedMUAccount].meetup;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder])
    {
        self.meetup = [MUAccount sharedMUAccount].meetup;
    }
    return self;
}

-(void)dealloc
{
    self.meetup = nil;
}

-(void)updateProfile
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"0,0", @"location",
                                   nil];
    _updateProfileRequest = [_meetup requestWithMethodName:@"users" andParams:params andHttpMethod:@"PUT" andDelegate:self];
}

-(void)getNearbyUsers
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"0,0", @"center",
                                   @"5000", @"radius",
                                   nil];
    _nearbayUsersRequest = [_meetup requestWithMethodName:@"users" andParams:params andHttpMethod:@"GET" andDelegate:self];
}

-(void)getUserById:(NSString *)userId
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   nil];
    _userRequest = [_meetup requestWithMethodName:[NSString stringWithFormat:@"users/%@", userId] andParams:params andHttpMethod:@"GET" andDelegate:self];
}

#pragma mark - VKRequest Delegate Methods

-(void)request:(MURequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"request did fail with errors:\n %@", error);
}

-(void)request:(MURequest *)request didLoad:(id)result
{
    NSLog(@"request result:\n %@", result);
    if (request == _userRequest)
    {

    }
    else if (request == _nearbayUsersRequest)
    {

    }
    else if (request == _updateProfileRequest)
    {
        
    }
}

@end
