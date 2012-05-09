//
//  UIMenuView.h
//  MeetUP
//
//  Created by Alexander Petrovichev on 5/9/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIMenuView : UIView <UITableViewDataSource, UITableViewDelegate>
{
    UITableView* menu;
}

@end
