//
//  SNUser.m
//  CoolProject
//
//  Created by Igor Botov on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SNUser.h"

@implementation SNUser

@synthesize userDelegate;
@synthesize uid;
@synthesize name;
@synthesize birthday;
@synthesize sex;
@synthesize photoUrl;
@synthesize photo;
@synthesize status;
@synthesize location;
@synthesize timezone;
@synthesize interests;
@synthesize jobs;
@synthesize friends;

-(void)dealloc
{
    self.uid = nil;
    self.name = nil;
    self.birthday = nil;
    self.sex = nil;
    self.photoUrl = nil;
    self.photo = nil;
    self.status = nil;
    self.location = nil;
    self.interests = nil;
    self.jobs = nil;
    self.friends = nil;
    [super dealloc];
}

@end
