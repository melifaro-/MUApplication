//
//  UIBadgeView.m
//  MeetUP
//
//  Created by Alexander Petrovichev on 5/31/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import "UIBadgeView.h"

@implementation UIBadgeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        badgeText = [[UILabel alloc] init];
        // Initialization code
    }
    return self;
}

- (void)setBadgeNumber:(NSString*)number
{
    if (number != 0)
	{
		CGSize retValue = CGSizeMake(25, 29);
		CGFloat rectWidth, rectHeight;
		CGSize stringSize = [number sizeWithFont:[UIFont systemFontOfSize:16]];
		CGFloat flexSpace;
		if ([number length] >= 2) 
		{
			flexSpace = [number length];
			rectWidth = 6 + (stringSize.width + flexSpace);
            rectHeight = 29;
			retValue = CGSizeMake(rectWidth, rectHeight);
		}
		self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, retValue.width, retValue.height);
        badgeText.frame = CGRectMake(0, 0, retValue.width, [[UIFont systemFontOfSize:16] lineHeight]);
	}
    [badgeText setText:number];
    [badgeText setFont:[UIFont systemFontOfSize:16]];
    [badgeText setTextAlignment:UITextAlignmentCenter];
    [badgeText setTextColor:[UIColor darkGrayColor]];
    [badgeText setCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)];
    [badgeText setBackgroundColor:[UIColor clearColor]];
    [self addSubview:badgeText];
    [self setBackgroundColor:[UIColor lightGrayColor]];
    [[self layer] setCornerRadius:self.frame.size.height / 2];
    [[self layer] setMasksToBounds:YES];
    [[self layer] setBorderColor:[UIColor darkGrayColor].CGColor];
    [[self layer] setBorderWidth:1.0];
}

- (void)dealloc
{
    [super dealloc];
    [badgeText release];
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
