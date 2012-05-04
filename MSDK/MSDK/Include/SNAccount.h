//
//  SNAccount.h
//  CoolProject
//
//  Created by Igor Botov on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
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

@end
