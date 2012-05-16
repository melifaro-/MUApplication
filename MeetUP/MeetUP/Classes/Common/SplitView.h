//
//  SplitView.h
//  SplitView
//
//  Created by Alexander Petrovichev on 4/25/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SplitView : UIView
{
    UIView* leftView;
    UIView* middleView;
    UIView* rightView;
}
@property(nonatomic, retain) UIView* leftView;
@property(nonatomic, retain) UIView* middleView;
@property(nonatomic, retain) UIView* rightView;

- (void)toLeftView;
- (void)toRightView;
- (void)toMiddleView;

@end
