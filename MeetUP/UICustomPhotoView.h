//
//  UICustomPhotoView.h
//  MeetUP
//
//  Created by Alexander Petrovichev on 5/29/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UICustomPhotoView : UIView
{
    UIImageView *photo;
}
@property (nonatomic, retain) UIImageView *photo;;

- (id)initWithImage:(UIImage*)image;
- (void)setImageRadius:(double)imageRad WhiteZoneRadius:(double)whiteRad andBlackZoneRadius:(double)blackRad;

@end
