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
#define SEARCH_RADIUS   @"5000"

@implementation MUUser

@synthesize meetup = _meetup;
@synthesize lastFix = _lastFix;

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
    self.lastFix = nil;
    [super dealloc];
}

-(void)updateProfile
{
    if (_lastFix)
    {
        NSLog(@"%@", [NSString stringWithFormat:@"%f,%f", _lastFix.coordinate.latitude, _lastFix.coordinate.longitude]);
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [NSString stringWithFormat:@"%f,%f", _lastFix.coordinate.latitude, _lastFix.coordinate.longitude] , @"location",
                                      nil];
        _updateProfileRequest = [_meetup requestWithMethodName:@"users" andParams:params andHttpMethod:@"PUT" andDelegate:self];        
    }
}

-(void)getNearbyUsers
{
    if (_lastFix)
    {
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       [NSString stringWithFormat:@"%f,%f", _lastFix.coordinate.latitude, _lastFix.coordinate.longitude], @"center",
                                       SEARCH_RADIUS, @"radius",
                                       nil];
        _nearbayUsersRequest = [_meetup requestWithMethodName:@"users" andParams:params andHttpMethod:@"GET" andDelegate:self];
    }
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
    if ([self.userDelegate respondsToSelector:@selector(didFailWithErrors:)])
    {
        [self.userDelegate didFailWithErrors:error];
    }
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
