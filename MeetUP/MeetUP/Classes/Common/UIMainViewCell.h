//
//  UIMainViewCell.h
//  MeetUP
//
//  Created by Alexander Petrovichev on 5/29/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIMainViewCell : UITableViewCell
{
    IBOutlet UIImageView* photo;
    IBOutlet UILabel* name;
    IBOutlet UIView* highlightView;
    UILabel* message;
    NSArray* people;
    int type;
}

@property (nonatomic, retain) UIImageView* photo;
@property (nonatomic, retain) UILabel* name;
@property (nonatomic, retain) UILabel* message;
@property (nonatomic, retain) UIView* highlightView;
@property (nonatomic, retain) NSArray* people;
@property (nonatomic, assign) int type;

- (void)setContent:(int)index;

@end
