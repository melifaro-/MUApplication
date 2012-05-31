//
//  UICustomPhotoView.m
//  MeetUP
//
//  Created by Alexander Petrovichev on 5/29/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import "UICustomPhotoView.h"

@implementation UICustomPhotoView
@synthesize photo;

- (id)init
{
    self = [super init];
    if (self)
    {
        photo = [[UIImageView alloc] init];
        [[photo layer] setMasksToBounds:YES];
        [[photo layer] setBorderColor:[UIColor whiteColor].CGColor];
        UIView *border = [[UIView alloc] init];
        [self addSubview:border];
        [border addSubview:photo];
    }
    return self;
}

- (void)setImageRadius:(double)imageRad WhiteZoneRadius:(double)whiteRad andBlackZoneRadius:(double)blackRad
{
    [photo setFrame:CGRectMake(0, 0, imageRad * 2, imageRad * 2)];
    [[photo layer] setCornerRadius:imageRad];
    [[photo layer] setBorderWidth:whiteRad];
    [photo.superview setFrame:photo.frame];
    [[photo.superview layer] setCornerRadius:imageRad];
    [[photo.superview layer] setMasksToBounds:YES];
    [[photo.superview layer] setBorderColor:[UIColor blackColor].CGColor];
    [[photo.superview layer] setBorderWidth:blackRad];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
