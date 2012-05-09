//
//  SNAccount.h
//  MSDK
//
//  Created by Alexander Petrovichev on 4/21/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNUser.h"
#import "SNSessionDelegate.h"

@interface SNAccount : NSObject <NSCoding, SNSessionProtocol>
{
    id<SNSessionDelegate>    sessionDelegate;
    NSString                        *authkey;
    NSDate                          *expDate;
    NSString                        *_userId;
}

@property (nonatomic, assign) id<SNSessionDelegate>  sessionDelegate;
@property (nonatomic, retain) NSString                      *authkey;
@property (nonatomic, retain) NSDate                        *expDate;
@property (nonatomic, retain) NSString                       *userId;

//will be used in social network authorization process
-(NSString*)snType;

@end
