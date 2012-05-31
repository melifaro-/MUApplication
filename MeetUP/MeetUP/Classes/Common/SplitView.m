//
//  SplitView.m
//  SplitView
//
//  Created by Alexander Petrovichev on 4/25/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import "SplitView.h"

@implementation SplitView
@synthesize leftView;
@synthesize middleView;
@synthesize rightView;


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {

    }
    return self;
}

- (void)toRightView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    self.frame = CGRectMake(-480, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    [UIView commitAnimations];
}

- (void)toLeftView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    self.frame = CGRectMake(0, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    [UIView commitAnimations];
}

- (void)toMiddleView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    self.frame = CGRectMake(-240, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    [UIView commitAnimations];
}

-(void)setMiddleView:(UIView *)_middleView
{
    if (_middleView != middleView)
    {
        [middleView release];
        middleView = _middleView;
        [self
         addSubview:middleView];
        [middleView setFrame:CGRectMake(240.0, self.frame.origin.y, 320.0, self.frame.size.height)];
    }
}

-(void)setLeftView:(UIView *)_leftView
{
    if (_leftView != leftView)
    {
        [leftView release];
        leftView = _leftView;
        [self addSubview:leftView];
        [leftView setFrame:CGRectMake(0.0, self.frame.origin.y, 240.0, self.frame.size.height)];
    }
}

-(void)setRightView:(UIView *)_rightView
{
    if (_rightView != rightView)
    {
        [rightView release];
        rightView = _rightView;
        [self addSubview:rightView];
        [rightView setFrame:CGRectMake(560.0, self.frame.origin.y, 240.0, self.frame.size.height)];
    }
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
