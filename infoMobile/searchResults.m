//
//  searchResults.m
//  infoMobile
//
//  Created by User on 4/17/14.
//  Copyright (c) 2014 Jerry. All rights reserved.
//

#import "searchCar.h"
#import "searchResults.h"
#import <Parse/Parse.h>
#import "detailsView.h"
#import "reachability.h"

static int value;
static int reSorted;

@implementation searchResults
- (IBAction)sortButtonPressed:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Price - Highest", @"Price - Lowest", @"Year - Newest", @"Year - Oldest", @"Auction Date - Newest", @"Auction Date - Oldest", @"Lot - First",@"Lot - Last",nil];
    
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
            
        case 0:
            reSorted = 0;
            [self loadObjects];
            break;
            
        case 1:
            reSorted = 1;
            [self loadObjects];
            break;
            
        case 2:
            reSorted = 2;
            [self loadObjects];
            break;
            
        case 3:
            reSorted = 3;
            [self loadObjects];
            break;
            
        case 4:
            reSorted = 4;
            [self loadObjects];
            break;
            
        case 5:
            reSorted = 5;
            [self loadObjects];
            break;
            
        case 6:
            reSorted = 6;
            [self loadObjects];
            break;
            
        case 7:
            reSorted = 7;
            [self loadObjects];
            break;
            
        default:
            break;
    }
}

//Keep portrait
- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL) connectedToNetwork
{
	Reachability *r = [Reachability reachabilityWithHostName:@"www.google.com"];
	NetworkStatus internetStatus = [r currentReachabilityStatus];
	BOOL internet;
	if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN)) {
		internet = NO;
	} else {
		internet = YES;
	}
	return internet;
}


-(BOOL) checkInternet
{
	//Make sure we have internet connectivity
	if([self connectedToNetwork] != YES)
	{
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"No Network Connectivity!"
                                                          message:@"No network connection found. An Internet connection is required for this application to work."
                                                         delegate:self
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        
		return NO;
	}
	else {
		return YES;
	}
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // The className to query on
        self.parseClassName = @"data";
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        self.pullToRefreshEnabled = NO;
        
        // The number of objects to show per page
        self.objectsPerPage = 1000;
    }
    return self;
}

//If back button is pressed, pop current view from stack
- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)menuButtonPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"detailSegue"]){
        detailsView *detailViewController = [segue destinationViewController];
        NSInteger row = [[self tableView].indexPathForSelectedRow row];
        detailViewController.detailItems = [self.objects objectAtIndex:row];
    }
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    [self.navigationController setToolbarHidden:NO];
    value = 0;
    reSorted = 11;
    [self checkInternet];
}


#pragma mark - PFQueryTableViewController

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    value++;
    // This method is called every time objects are loaded from Parse via the PFQuery
    
    /* ObjectsDidLoad is called twice because of cacheing.
     Check if the query is empty once, not twice.
     */
    
    if(value == 1){
        if( ([self checkInternet]==YES) && (self.objects.count == 0)){
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"No Results Found!"
                                                              message:@"No results found. Please try again with another query."
                                                             delegate:self
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [message show];
        }
    }
}

 // Override to customize what kind of query to perform on the class. The default is to query for
 // all objects ordered by createdAt descending.
- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:@"data"];
    
    //If first letter of make name is lowercase, change it to upper
    NSMutableString *result = [self.modelName mutableCopy];
    [result enumerateSubstringsInRange:NSMakeRange(0, [result length])
                               options:NSStringEnumerationByWords
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                [result replaceCharactersInRange:NSMakeRange(substringRange.location, 1)
                                                      withString:[[substring substringToIndex:1] uppercaseString]];
                            }];
    
    //If first letter of lotname is lowercase, change it to upper
    NSMutableString *result1 = [self.lotName mutableCopy];
    [result enumerateSubstringsInRange:NSMakeRange(0, [result length])
                               options:NSStringEnumerationByWords
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                [result replaceCharactersInRange:NSMakeRange(substringRange.location, 1)
                                                      withString:[[substring substringToIndex:1] uppercaseString]];
                            }];
    
    
    /*NSLog(@"AUCTION: %@",self.auctionName);
    NSLog(@"MAKE: %@",self.makeName);
    NSLog(@"MODEL: %@",self.modelName);
    NSLog(@"LOT: %@",self.lotName);
    NSLog(@"YEAR: %@",self.yearName);*/

    query.limit = 1000; // limit to at most 10 results
    if(![self.auctionName isEqualToString:@"All"]){
        if(self.auctionName != NULL){
            if(![self.auctionName isEqualToString:@"Auction"]){
                [query whereKey:@"AUCTION" equalTo:self.auctionName];
            }
        }
        
    }
    
    if( (self.makeName != NULL) && (![self.makeName isEqualToString:@"Make"]))
    {
        [query whereKey:@"MAKE" equalTo:self.makeName];
    }
    
    if( (self.modelName != NULL) && (![self.modelName isEqualToString:@""]))
    {
        [query whereKey:@"MODEL" containsString:result];
    }
    
    if( (self.yearName != NULL) && (![self.yearName isEqualToString:@""]))
    {
        [query whereKey:@"YEAR" equalTo:self.yearName];
    }
    
    if( (self.lotName != NULL) && (![self.lotName isEqualToString:@""]))
    {
        [query whereKey:@"LOT" equalTo:result1];
    }
    
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if (self.objects.count == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    switch (reSorted) {
            
        case 0:
            [query orderByAscending:@"SALEPRICE"];
            break;
            
        case 1:
            [query orderByDescending:@"SALEPRICE"];
            break;
            
        case 2:
            [query orderByDescending:@"YEAR"];
            break;
            
        case 3:
            [query orderByAscending:@"YEAR"];
            break;
            
        case 4:
            [query orderByDescending:@"PRIORITY"];
            break;
            
        case 5:
            [query orderByAscending:@"PRIORITY"];
            break;
            
        case 6:
            [query orderByAscending:@"LOT"];
            break;
            
        case 7:
            [query orderByDescending:@"LOT"];
            break;
            
        //Default Sort    
        case 11:
            //If more than one auction, order by most recent auction.
            //If auction specified, order by lot number
            if(([self.auctionName isEqualToString:@"Auction"]) || ([self.auctionName isEqualToString:@"All"]) || (self.auctionName == NULL)){
                [query orderByDescending:@"PRIORITY"];
            }
            else{
                [query orderByAscending:@"LOT"];
            }

            
        default:
            break;
    }

    
    return query;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    // My OK button
    if (buttonIndex == alertView.cancelButtonIndex) {
        //When pressed, return to previous page.
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the textKey in the object,
// and the imageView being the imageKey in the object.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {

    static NSString *CellIdentifier = @"resultCell";
    PFTableViewCell *cell = (PFTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
 
    NSString *make = [object objectForKey:@"MAKE"];
    NSString *model;
    NSString *year;
    NSString *auction = [object objectForKey:@"AUCTION"];
    NSString *lot = [object objectForKey:@"LOT"];
    NSString *price;
    
    if([[object objectForKey:@"YEAR"] isEqualToString:@"None"]){
        year = @"";
    }
    else{
        year = [object objectForKey:@"YEAR"];
    }
    
    if([[object objectForKey:@"MODEL"] isEqualToString:@"None"]){
        model = @"";
    }
    else{
        model = [object objectForKey:@"MODEL"];
    }

    if([[object objectForKey:@"SALEPRICE"] isEqualToString:@"None"]){
        price = @"Not Sold";
    }
    else{
        price = [NSString stringWithFormat:@"$%@",[object objectForKey:@"SALEPRICE"]];
    }
    
    
    // Configure the cell
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %@", year,make,model];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@: %@ | %@", auction,lot,price];
    
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:8];
 
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

@end
