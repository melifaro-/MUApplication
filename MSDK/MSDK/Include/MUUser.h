//
//  MUUser.h
//  MSDK
//
//  Created by Alexander Petrovichev on 4/22/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNUser.h"
#import "RequestDelegates.h"

@class MeetUp;

@interface MUUser : SNUser <MURequestDelegate>
{
    MeetUp*     _meetup;
    CLLocation* _lastFix;
    MURequest*  _updateProfileRequest;
    MURequest*  _usersFilterRequest;
    MURequest*  _userRequest;
}

@property (nonatomic, retain) MeetUp* meetup;
@property (nonatomic, retain) CLLocation* lastFix;

-(void)updateProfile;
-(void)getNearbyUsers;
-(void)getUserById:(NSString *)userId;
//userFilter синтаксис аналогичен SQL-оператору like, например name=jo%.
-(void)getUsersWithFilter:(NSString*)userFilter aroundLocation:(CLLocation*)location withRadius:(NSString*)radius; 

@end
