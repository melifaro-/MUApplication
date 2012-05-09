//
//  VKViewController.m
//  MSDK
//
//  Created by Alexander Petrovichev on 4/19/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import "VKViewController.h"
#import "AppDelegate.h"

@interface VKViewController(private)

-(void)initMeetUpInstances;

@end

@implementation VKViewController(private)

-(void)initMeetUpInstances
{
    _muAccount = [AppDelegate getInstance].muAccount;
    _vka = _muAccount.vkAccount;
    [_vka setSessionDelegate:self];
    _user = _vka.vkUser;
    [_user setUserDelegate:self];
}

@end

@implementation VKViewController

-(id)init
{
    if (self = [super init])
    {
        [self initMeetUpInstances];
    }
    return self;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        [self initMeetUpInstances];
    }
    return self;
}

-(IBAction)loginButtonTouched:(id)sender
{
    [_vka login];
}

-(IBAction)getMeButtonTouched:(id)sender
{
    [_user setUserDelegate:self];
    [_user getUserById:_user.uid];
}

-(IBAction)getMyFriendsButtonTouched:(id)sender
{
//    VKAccount *vkAccount = [AppDelegate appDelegate].vkAccount;
//    SNUser *user = [[SNUser alloc] init];
//    [user setUserDelegate:self];
//    [user getUserById:vkAccount.userId];
}

- (void)didLogin
{
    [myTextView setText:@"Did login"];
}

- (void)didNotLogin:(BOOL)cancelled
{
    [myTextView setText:@"didNotLogin"];
}

- (void)didLogout
{
    [myTextView setText:@"didLogout"];
}

- (void)sessionInvalidated
{
    [myTextView setText:@"sessionInvalidated"];
}

-(void)didProfileReceived
{
    [myTextView setText:@"didProfileReceived"];
}

-(void)didUserReceived
{
    [myTextView setText:@"didUserReceived"];
}

-(void)didUserFriendsReceived
{
    [myTextView setText:@"didUserFriendsReceived"];
}

-(void)didPhotoReceived
{
    [myImage setImage:_user.photo];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"VKViewController" owner:self options:nil];
    UIView* sview = [array objectAtIndex:0];
    sview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    sview.frame = CGRectMake(0, 0, self.viewContent.frame.size.width, self.viewContent.frame.size.height);
    self.navBar.hidden = NO;
    self.backButton.hidden = NO;
    self.nextButton.hidden = YES;
    self.title = @"VK Test";
    [self layoutNavigationBar];
    [self.viewContent addSubview:sview];

    if (_user)
    {
        [myImage setImage:_user.photo];
    }
}


@end
