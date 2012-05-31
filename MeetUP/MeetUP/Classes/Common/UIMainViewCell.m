//
//  UIMainViewCell.m
//  MeetUP
//
//  Created by Alexander Petrovichev on 5/29/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import "UIMainViewCell.h"

@implementation UIMainViewCell
@synthesize name;
@synthesize photo;
@synthesize message;
@synthesize people;
@synthesize type;
@synthesize badge;
@synthesize highlightView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        photo = [[UICustomPhotoView alloc] init];
        badge = [[UIBadgeView alloc] init];
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContent:(int)index
{
    if (index == 0)
    {
        [highlightView setFrame:CGRectMake(0,
                                           -20,
                                           self.frame.size.width,
                                           self.frame.size.height)];
        [highlightView setBackgroundColor:[UIColor greenColor]];
    }
    else
    {
        [highlightView setFrame:CGRectMake(0,
                                           0,
                                           self.frame.size.width,
                                           self.frame.size.height)];
        [highlightView setBackgroundColor:[UIColor yellowColor]];
    }
    //photo
    [photo setFrame:CGRectMake(10, 14, 60, 60)];
    [photo setImageRadius:27 WhiteZoneRadius:2.5 andBlackZoneRadius:0.7];
    [photo.photo setImage:[UIImage imageNamed:@"unknownPhoto.png"]];
    [highlightView addSubview:photo];
    //badge
    [badge setBadgeNumber:@"+289"];
    [badge setFrame:CGRectMake(230.0, 44.0, badge.frame.size.width, badge.frame.size.height)];
    [highlightView addSubview:badge];
}
@end
