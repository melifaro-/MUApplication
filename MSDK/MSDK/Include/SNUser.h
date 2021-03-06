//
//  SNUser.h
//  MSDK
//
//  Created by Alexander Petrovichev on 4/21/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol SNUserDelegate <NSObject>

@optional

-(void)didProfileReceived;
-(void)didUserReceived;
-(void)didUserFriendsReceived;
-(void)didPhotoReceived;
-(void)didFailWithErrors:(NSError*)error;

@end

@protocol SNUserProtocol <NSObject>

@optional
-(void)fillProfile;
-(void)getUserFriends;
-(void)getUserById:(NSString*)userId;

@end

@interface SNUser : NSObject <SNUserProtocol, NSCoding>
{
    id<SNUserDelegate>  userDelegate;
    NSString            *uid;
    NSString            *name;
    NSString            *birthday;
    NSString            *sex; //male, female
    NSString            *photoUrl;
    UIImage             *photo;
    NSString            *status;
    CLLocation          *location;//+ нужен таймстэмп
    NSInteger           timezone;
    NSArray             *interests;
    NSArray             *jobs;
    NSArray             *friends;

    NSURLConnection*      _connection;
    NSMutableData*        _responseText;
}

@property (nonatomic, assign) id<SNUserDelegate>    userDelegate;
@property (nonatomic, retain) NSString              *uid;
@property (nonatomic, retain) NSString              *name;
@property (nonatomic, retain) NSString              *birthday;
@property (nonatomic, retain) NSString              *sex;
@property (nonatomic, retain) NSString              *photoUrl;
@property (nonatomic, retain) UIImage               *photo;
@property (nonatomic, retain) NSString              *status;
@property (nonatomic, retain) CLLocation            *location;
@property (nonatomic, assign) NSInteger             timezone;
@property (nonatomic, retain) NSArray               *interests;
@property (nonatomic, retain) NSArray               *jobs;
@property (nonatomic, retain) NSArray               *friends;

-(void)downloadUserPhoto;

@end
