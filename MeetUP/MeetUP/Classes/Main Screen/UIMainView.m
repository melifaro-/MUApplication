//
//  UIMainView.m
//  MeetUP
//
//  Created by Alexander Petrovichev on 5/9/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import "UIMainView.h"

@implementation UIMainView
@synthesize mpuiView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        MPUIView* viewController = [[MPUIView alloc] initWithNibName:@"MPUIView" bundle:nil];
        self.mpuiView = viewController;
        [viewController release];
        UIView* navbarView = [mpuiView.view.subviews objectAtIndex:0];
        [self addSubview:navbarView];
       // id nextObject;
        NSEnumerator* enumerator = [navbarView.subviews objectEnumerator];
        
        for (id nextObject in navbarView.subviews)
        {
            if (nextObject == mpuiView.title)
            {
                // Title
                [(UILabel*)nextObject setText:@"meetUp"];
            } else if (nextObject == mpuiView.backButton)
            {
                [nextObject setHidden:NO];
                // Back Button
                [(UIButton*)nextObject removeTarget:mpuiView action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [(UIButton*)nextObject addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            } else if (nextObject == mpuiView.nextButton)
            {
                [nextObject setHidden:NO];
                // Next Button
                [(UIButton*)nextObject removeTarget:mpuiView action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [(UIButton*)nextObject addTarget:self action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        [mpuiView layoutNavigationBar];
    }
    return self;
}

- (void) nextButtonPressed:(id)sender
{
    [self.superview toRightView];
}

- (void) backButtonPressed:(id)sender
{
    [self.superview toLeftView];
}

@end
