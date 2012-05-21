//
//  MUAccount.m
//  MSDK
//
//  Created by Alexander Petrovichev on 4/22/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import "MUAccount.h"
#import "MeetUp.h"

#define MUACCOUNT_FILE @"muaccount"

static MUAccount* sharedMUAccount = nil;

@implementation MUAccount

@synthesize muUser = _muUser;
@synthesize meetup = _meetup;
@synthesize fbAccount = _fbAccount;
@synthesize vkAccount = _vkAccount;

+ (MUAccount*)sharedMUAccount
{
    if (!sharedMUAccount)
    {
        sharedMUAccount = [MUAccount restore];
        if (!sharedMUAccount)
        {
            sharedMUAccount = [[MUAccount alloc] init];
        }
    }
    return sharedMUAccount;
}

//-(void)initializeGPSTracking
//{
//    // Create the location manager if this object does not
//    // already have one.
//    if (nil == locationManager)
//        locationManager = [[CLLocationManager alloc] init];
//    
//    locationManager.delegate = self;
//    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
//    
//    // Set a movement threshold for new events.
//    locationManager.distanceFilter = 500;
//    
//    [locationManager startUpdatingLocation];
//}

-(id)init
{
    if (self = [super init])
    {
        sharedMUAccount = self;
        self.meetup = [[MeetUp alloc] initWithSessionDelegate:self];
        [_meetup release];
        self.fbAccount = [[[FBAccount alloc] init] autorelease];
        self.vkAccount = [[[VKAccount alloc] init] autorelease];
        self.muUser = [[[MUUser alloc] init] autorelease];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder])
    {
        sharedMUAccount = self;
        self.meetup = [[MeetUp alloc] initWithSessionDelegate:self];
        [_meetup release];
        if (self.authkey)
        {
            _meetup.accessToken = authkey;
        }

        self.fbAccount = [decoder decodeObjectForKey:@"fbAccount"];
        self.vkAccount = [decoder decodeObjectForKey:@"vkAccount"];
        self.muUser = [decoder decodeObjectForKey:@"muUser"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [super encodeWithCoder:coder];
    [coder encodeObject:_fbAccount forKey:@"fbAccount"];
    [coder encodeObject:_vkAccount forKey:@"vkAccount"];
    [coder encodeObject:_muUser forKey:@"muUser"];
}

-(void)dealloc
{
    self.muUser = nil;
    self.meetup = nil;
    self.userId = nil;
    self.fbAccount = nil;
    self.vkAccount = nil;
    [super dealloc];
}

-(BOOL)handleOpenURL:(NSURL *)url
{
    if([_fbAccount handleOpenURL:url])
        return YES;
    else if ([_vkAccount handleOpenURL:url])
        return YES;
    else
        return NO;
}

-(void)save
{
    NSData* muAccountSerialized = [NSKeyedArchiver archivedDataWithRootObject:self];
    NSError *error = nil;
    NSArray *docsFoundPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [[docsFoundPaths objectAtIndex:0] stringByAppendingPathComponent:MUACCOUNT_FILE];
    [muAccountSerialized writeToFile:docsPath options:NSDataWritingAtomic error:&error];
    if (error)
    {
        NSLog(@"serializing error %@", error);
    }
}

+(MUAccount*)restore
{
    MUAccount* muAccount = nil;
    NSArray *docsFoundPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [[docsFoundPaths objectAtIndex:0] stringByAppendingPathComponent:MUACCOUNT_FILE];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:docsPath];
    if (fileExists)
    {
        NSError *error = nil;
        NSData* muAccountSerialized = [NSData dataWithContentsOfFile:docsPath options:NSDataWritingAtomic error:&error];
        muAccount = [NSKeyedUnarchiver unarchiveObjectWithData:muAccountSerialized];
    }
    return muAccount;
}

+(void)reset
{
    NSArray *docsFoundPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [[docsFoundPaths objectAtIndex:0] stringByAppendingPathComponent:MUACCOUNT_FILE];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:docsPath];
    if (fileExists)
    {
        NSError* error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:docsPath error:&error];
        NSLog(@"MUAccount reset errors %@", error);
    }
}

-(void)signup:(NSString*)login withPassword:(NSString*)password
{
    if(![_meetup isSessionValid])
    {
        [_meetup signup:login withPassword:password];
    }
}

-(void)login:(NSString*)login withPassword:(NSString*)password
{
    if(![_meetup isSessionValid])
    {
        [_meetup login:login withPassword:password];
    }
}

-(void)loginWithSocialNetwork:(SNAccount*)snAccount
{
    if(![_meetup isSessionValid])
    {
        [_meetup loginWithSNAccount:snAccount];
    }
}

-(void)logout
{
    if([_meetup isSessionValid])
    {
        [_meetup logout];
    }
}

- (void)didLogin
{
    self.authkey = _meetup.accessToken;
    self.userId = _meetup.userId;
    self.muUser.uid = self.userId;
    if ([sessionDelegate respondsToSelector:@selector(didLogin)])
    {
        [sessionDelegate didLogin];
    }
}

- (void)didNotLogin:(BOOL)cancelled
{
    [sessionDelegate didNotLogin:cancelled];
}

- (void)didLogout
{
    self.authkey = _meetup.accessToken;
    [sessionDelegate didLogout];
}

- (void)sessionInvalidated
{
    [sessionDelegate sessionInvalidated];
}

- (void)didFailWithErrors:(NSError *)error
{
    if ([sessionDelegate respondsToSelector:@selector(didFailWithErrors:)])
    {
        [sessionDelegate didFailWithErrors:error];
    }
}

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"newLocation %@", newLocation);
}

@end
