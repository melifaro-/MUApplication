//
//  UIBadgeView.h
//  MeetUP
//
//  Created by Alexander Petrovichev on 5/31/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIBadgeView : UIView
{
    UILabel *badgeText;
}

- (id)initWithText:(NSString*)number;
- (void)setBadgeNumber:(NSString*)number;

@end
