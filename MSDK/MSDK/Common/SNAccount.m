//
//  SNAccount.m
//  MSDK
//
//  Created by Alexander Petrovichev on 4/21/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import "SNAccount.h"

@implementation SNAccount

@synthesize sessionDelegate;
@synthesize authkey;
@synthesize expDate;
@synthesize userId = _userId;

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        self.userId = [decoder decodeObjectForKey:@"userId"];
        self.authkey = [decoder decodeObjectForKey:@"authkey"];
        self.expDate = [decoder decodeObjectForKey:@"expDate"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_userId forKey:@"userId"];
    [coder encodeObject:authkey forKey:@"authkey"];
    [coder encodeObject:expDate forKey:@"expDate"];
}

-(void)dealloc
{
    self.userId = nil;
    self.authkey = nil;
    self.expDate = nil;
    [super dealloc];
}

@end
