//
//  MUUser.h
//  MSDK
//
//  Created by Alexander Petrovichev on 4/22/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNUser.h"

@interface MUUser : SNUser
{
    CLLocation* lastFix;
}

-(void)updateProfile;
-(void)getNearbyUsers;
+(void)getUserById:(NSString *)userId;

@end
