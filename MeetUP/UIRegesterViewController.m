//
//  UIRegesterViewController.m
//  MeetUP
//
//  Created by Alexander Petrovichev on 5/6/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#define TABLE_MARGIN 10.

#import "UIRegesterViewController.h"

@implementation UIRegesterViewController
@synthesize socialNetworks;
@synthesize description;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"UIRegesterViewController" owner:self options:nil];
    UIView* sview = [array objectAtIndex:0];
    sview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    sview.frame = CGRectMake(0, 0, self.viewContent.frame.size.width, self.viewContent.frame.size.height);
    sview.backgroundColor = [UIColor clearColor];
    self.navBar.hidden = NO;
    self.backButton.hidden = NO;
    self.nextButton.hidden = YES;
    self.title = @"Регистрация";
    [self layoutNavigationBar];
    [self.viewContent addSubview:sview];
    self.socialNetworks = [NSArray arrayWithObjects:@"Twitter", @"Facebook", @"VK", @"Foursquare", @"Одноклассники", @"МойМир@mail.ru", nil];
    socialNetworkTable = [[UITableView alloc] initWithFrame:CGRectMake(TABLE_MARGIN / 2,
                                                                       TABLE_MARGIN / 2,
                                                                       viewContent.frame.size.width,
                                                                       viewContent.frame.size.height)
                                                      style:UITableViewStyleGrouped];
    socialNetworkTable.backgroundColor = [UIColor clearColor];
    socialNetworkTable.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    socialNetworkTable.delegate = self;
    socialNetworkTable.dataSource = self;
    socialNetworkTable.rowHeight = 30;
    socialNetworkTable.sectionHeaderHeight = 10.0;
    socialNetworkTable.sectionFooterHeight = 10.0;
    socialNetworkTable.exclusiveTouch = YES;
    [self.viewContent addSubview:socialNetworkTable];
    self.description = [NSString stringWithString:@"Выберите одну из нижеперечисленных сетей, чтобы использовать информацию из неё для создания вашего профиля MeetUP."];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    [socialNetworkTable release];
    self.socialNetworks = nil;
    self.description = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat width = tableView.frame.size.width;
    CGRect frame = CGRectMake(0.0, 0.0, width, 0.0);
    
    UIView* descriptionView = [[[UIView alloc] initWithFrame:frame] autorelease];
    
    width = width - TABLE_MARGIN;
    frame.origin.x =+ TABLE_MARGIN / 2;
    frame.size.width = width;
    UILabel* descriptionLabel = [[UILabel alloc] initWithFrame:frame];
    
    descriptionLabel.backgroundColor = [UIColor clearColor];
    descriptionLabel.textAlignment = UITextAlignmentCenter;
    descriptionLabel.opaque = NO;
    descriptionLabel.font = [UIFont systemFontOfSize:14];
    descriptionLabel.numberOfLines = 0;
    descriptionLabel.text = self.description;
    descriptionLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [descriptionView addSubview:descriptionLabel];
    [descriptionLabel release];
    
    return descriptionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height;

    CGFloat width = tableView.frame.size.width - TABLE_MARGIN;
    UIFont* font = [UIFont systemFontOfSize:14];
    
    CGSize maxSize = CGSizeMake(width, CGFLOAT_MAX);
    CGSize headerSize = [self.description sizeWithFont:font constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
    height = headerSize.height + TABLE_MARGIN;

    return height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.socialNetworks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [self.socialNetworks objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
