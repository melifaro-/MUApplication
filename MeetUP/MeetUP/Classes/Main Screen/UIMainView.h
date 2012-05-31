//
//  UIMainView.h
//  MeetUP
//
//  Created by Alexander Petrovichev on 5/9/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPUIView.h"

enum 
{
    DISTANCE_NEAR = 0,
    DISTANCE_METERS100,
    DISTANCE_METERS1000,
    DISTANCE_COUNT
}distance;

@interface UIMainView : UIView<UITableViewDataSource, UITableViewDelegate>
{
    UITableView* people;
    UITableView* talks;
    MPUIView *mpuiView;
}
@property (nonatomic, retain) MPUIView* mpuiView;

@end
