//
//  UIRegesterViewController.h
//  MeetUP
//
//  Created by Alexander Petrovichev on 5/6/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPUIView.h"

@interface UIRegesterViewController : MPUIView <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *socialNetworks;
    UITableView *socialNetworkTable;
    NSString *description;
}

@property (nonatomic, retain) NSArray *socialNetworks;
@property (nonatomic, retain) NSString *description;

@end
