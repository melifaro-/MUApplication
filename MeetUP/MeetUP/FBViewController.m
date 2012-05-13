//
//  ViewController.m
//  MSDK
//
//  Created by Alexander Petrovichev on 4/19/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import "FBViewController.h"
#import "MUAccount.h"

@interface FBViewController(private)

-(void)initMeetUpInstances;

@end

@implementation FBViewController(private)

-(void)initMeetUpInstances
{
    _muAccount = [MUAccount sharedMUAccount];
    _fba = _muAccount.fbAccount;
    [_fba setSessionDelegate:self];
}

@end

@implementation FBViewController

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
    [_fba login];
}
-(IBAction)logoutButtonTouched:(id)sender
{
    [_fba logout];
}

-(IBAction)getMeButtonTouched:(id)sender
{
    _fbUser = [[FBUser alloc] init];
    [_fbUser setUid:@"me"];
    [_fbUser setFacebook:_fba.facebook];
    [_fbUser setUserDelegate:self];
    [_fbUser fillProfile];
}

-(IBAction)getMyFriendsButtonTouched:(id)sender
{
    if (_fbUser)
    {
        [_fbUser getUserFriends];
    }
}

-(IBAction)getMyAlbumsTouched:(id)sender
{
//    Facebook *facebook = [AppDelegate appDelegate].facebook;
//    [facebook requestWithGraphPath:@"me/albums" andDelegate:self];
}

- (void)didLogin
{
    myInfoTextView.text = @"didLogin";
}

- (void)didNotLogin:(BOOL)cancelled
{
    myInfoTextView.text = [NSString stringWithFormat:@"didNotLogin %d", cancelled];
}

- (void)didLogout
{
    myInfoTextView.text = @"didLogout";
}

- (void)sessionInvalidated
{
    myInfoTextView.text = @"sessionInvalidated";
}

-(void)didProfileReceived
{
    [myInfoTextView setText:@"didProfileReceived"];
}

-(void)didUserReceived
{
    [myInfoTextView setText:@"didUserReceived"];
}

-(void)didUserFriendsReceived
{
    [myInfoTextView setText:@"didUserFriendsReceived"];
}

-(void)didPhotoReceived
{
    myInfoTextView.text = @"[myImage setImage:_user.photo]";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"FBViewController" owner:self options:nil];
    UIView* sview = [array objectAtIndex:0];
    sview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    sview.frame = CGRectMake(0, 0, self.viewContent.frame.size.width, self.viewContent.frame.size.height);
    self.navBar.hidden = NO;
    self.backButton.hidden = NO;
    self.nextButton.hidden = YES;
    self.title = @"FB Test";
    [self layoutNavigationBar];
    [self.viewContent addSubview:sview];
}


@end
