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
@synthesize highlightView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
    [photo removeFromSuperview];
    [[photo layer] setCornerRadius:photo.frame.size.height/2.0];
    [[photo layer] setMasksToBounds:YES];
    [[photo layer] setBorderWidth:2.5];
    [[photo layer] setBorderColor:[UIColor whiteColor].CGColor];

}
@end
