//
//  SNUser.m
//  MSDK
//
//  Created by Alexander Petrovichev on 4/21/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
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

-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.birthday = [decoder decodeObjectForKey:@"birthday"];
        self.sex = [decoder decodeObjectForKey:@"sex"];
        self.photoUrl = [decoder decodeObjectForKey:@"photoUrl"];
        self.photo = [decoder decodeObjectForKey:@"photo"];
        self.status = [decoder decodeObjectForKey:@"status"];
        self.location = [decoder decodeObjectForKey:@"location"];
//        self.timezone = [decoder decodeObjectForKey:@"timezone"];
        self.interests = [decoder decodeObjectForKey:@"interests"];
        self.jobs = [decoder decodeObjectForKey:@"jobs"];
        self.friends = [decoder decodeObjectForKey:@"friends"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:uid forKey:@"uid"];
    [coder encodeObject:name forKey:@"name"];
    [coder encodeObject:birthday forKey:@"birthday"];
    [coder encodeObject:sex forKey:@"sex"];
    [coder encodeObject:photoUrl forKey:@"photoUrl"];
    [coder encodeObject:photo forKey:@"photo"];
    [coder encodeObject:status forKey:@"status"];
    [coder encodeObject:location forKey:@"location"];
//    [coder encodeObject:timezone forKey:@"timezone"];
    [coder encodeObject:interests forKey:@"interests"];
    [coder encodeObject:jobs forKey:@"jobs"];
    [coder encodeObject:friends forKey:@"friends"];
}

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

-(NSString*)description
{
    NSString* description = [NSString stringWithFormat:@"uid %@,\n name %@,\n birthday %@,\n sex %@,\n photoUrl %@,\n photo %@,\n status %@,\n location %@,\n interests %@,\n jobs %@,\n friends",
                      self.uid,
                      self.name,
                      self.birthday,
                      self.sex,
                      self.photoUrl,
                      self.photo,
                      self.status,
                      self.location,
                      self.interests,
                      self.jobs,
                      self.friends];
    return description;
}

@end
