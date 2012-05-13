//
//  UIMeetUpRegesterViewController.m
//  MeetUP
//
//  Created by Alexander Petrovichev on 5/7/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import "UIMeetUpRegesterViewController.h"
#import "MUAccount.h"
#import "UIMainScreenViewController.h"

@implementation UIMeetUpRegesterViewController
@synthesize photo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _muAccount = [MUAccount sharedMUAccount];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"UIMeetUpRegesterViewController" owner:self options:nil];
    UIView* sview = [array objectAtIndex:0];
    sview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    sview.frame = CGRectMake(0, 0, self.viewContent.frame.size.width, self.viewContent.frame.size.height);
    sview.backgroundColor = [UIColor clearColor];
    self.navBar.hidden = NO;
    self.backButton.hidden = NO;
    self.nextButton.hidden = NO;
    self.title = @"Регистрация";
    [self layoutNavigationBar];
    [self.viewContent addSubview:sview];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction) getPhoto:(id) sender
{
    UIActionSheet *actSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                          delegate:self
                                                 cancelButtonTitle:@"Отмена"
                                            destructiveButtonTitle:nil
                                                 otherButtonTitles:@"Сделать фото", @"Выбрать фото", nil];
    actSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actSheet showInView:self.view];
    [actSheet release];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    if(buttonIndex == 1)
    {
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    else
    {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    [self presentModalViewController:picker animated:YES];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissModalViewControllerAnimated:YES];
    photo.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
}

-(IBAction)nextButtonPressed:(id)sender
{
    //[_muAccount signup:_loginTextField.text withPassword:_pswdTextField.text];
    UIMainScreenViewController *viewController = [[[UIMainScreenViewController alloc] initWithNibName:@"UIMainScreenViewController" bundle:nil] autorelease];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didLogin
{
    NSLog(@"did login");
}

- (void)didNotLogin:(BOOL)cancelled
{
    NSLog(@"did not login");
}


@end
