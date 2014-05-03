//
//  auctionTable.m
//  infoMobile
//
//  Created by User on 4/15/14.
//  Copyright (c) 2014 Jerry. All rights reserved.
//

#import "searchCar.h"
#import "searchResults.h"
#import "auctionTable.h"

static NSString *label;

@implementation auctionTable
@synthesize auctionName;

//Keep portrait
- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setToolbarHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.navigationController setNavigationBarHidden:NO];
    
    //Default section data
    self.defaultItemsArray=@[@"All"];
    
    //First section data
    self.firstItemsArray = @[@"Houston Motorcycle Auction 2014",
                             @"Houston 2014",
                             @"Gone Farmin' Tractor Spring Classic 2014",
                             @"Kissimmee 2014",
                             @"Las Vegas Motorcycle Auction 2014"];
    
    //Second section data
    self.secondItemsArray = @[@"Kansas City 2013",
                                 @"Anaheim 2013",
                                 @"Gone Farmin 2013",
                                 @"Chicago 2013",
                                 @"Dallas 2013",
                                 @"Monterey 2013",
                                 @"Bloomington Gold Corvette Auction 2013",
                                 @"Dana Mecum's 26th Original Spring Classic 2013",
                                 @"Kansas City Spring 2013",
                                 @"Houston 2013",
                                 @"Gone Farmin Iowa Spring 2013",
                                 @"Fran and Ron Green's Verde Classics Museum Collection 2013",
                                 @"Kissimmee 2013"];

    //Third section data
    self.thirdItemsArray = @[@"Kansas City, MO 2012",
                                @"Anaheim 2012",
                                @"Gone Farmin Iowa 2012",
                                @"St. Charles 2012",
                                @"Dallas 2012",
                                @"Monterey 2012",
                                @"Gone Farmin Fall 2012",
                                @"Des Moines 2012",
                                @"Bloomington Gold Corvette Auction 2012",
                                @"St. Paul 2012",
                                @"Dana Mecum's 25th Original Spring Classic Auction 2012",
                                @"Houston 2012",
                                @"Gone Farmin 2012",
                                @"Kansas City, MO Spring 2012",
                                @"Kissimmee 2012"];
    
    //Fourth section data
    self.fourthItemsArray = @[@"Kansas City, MO 2011",
                                 @"Dallas 2011",
                                 @"Geneva Lake 2011",
                                 @"St. Charles 2011",
                                 @"Monterey 2011",
                                 @"Gone Farmin' 2011",
                                 @"Des Moines 2011",
                                 @"Bloomington Gold Corvette Auction 2011",
                                 @"St. Paul 2011",
                                 @"Dana Mecum's Original Spring Classic Auction 2011",
                                 @"Gone Farmin' 2011",
                                 @"Kansas City, MO Spring 2011",
                                 @"Kissimmee 2011"];
    
    //Fifth section data
    self.fifthItemsArray = @[@"Kansas City MO 2010",
                                @"The Bob McDorman Collection 2010",
                                @"St. Charles 2010",
                                @"Monterey 2010",
                                @"Gone Farmin' 2010",
                                @"Des Moines 2010",
                                @"Bloomington Gold Corvette Auction 2010",
                                @"St. Paul 2010",
                                @"Dana Mecum's Original Spring Classic Auction 2010",
                                @"Kansas City MO 2010",
                                @"Kissimmee 2010"];
    
    //Sixth section data
    self.sixthItemsArray = @[@"Kansas City, MO 2009",
                                @"57 Heaven Museum Auction 2009",
                                @"St. Charles 2009",
                                @"Mecum at Monterey 2009",
                                @"Des Moines 2009",
                                @"Bloomington Gold Corvette Auction 2009",
                                @"St.Paul 2009",
                                @"Dana Mecum's Original Spring Classic Auction 2009",
                                @"Kansas City 2009",
                                @"Kissimmee 2009"];
    
    //Seventh section data
    self.seventhItemsArray = @[@"Kansas City, MO 2008",
                                  @"St. Charles 2008",
                                  @"Bob McDorman Auction 2008",
                                  @"Des Moines 2008",
                                  @"St. Charles 2008",
                                  @"St. Paul 2008",
                                  @"Muscle Cars & More 2008",
                                  @"Kissimmee 2008"];
}

//Number of sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 8;
}

//Name each section
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if(section == 0)
        return @"Default";
    else if(section == 1)
        return @"2014";
    else if(section == 2)
        return @"2013";
    else if(section == 3)
        return @"2012";
    else if(section == 4)
        return @"2011";
    else if(section == 5)
        return @"2010";
    else if(section == 6)
        return @"2009";
    else if(section == 7)
        return @"2008";
    else
        return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:  (NSInteger)section
{
    if(section == 0)
        return [self.defaultItemsArray count];
    else if(section == 1)
        return [self.firstItemsArray count];
    else if(section == 2)
        return [self.secondItemsArray count];
    else if(section == 3)
        return [self.thirdItemsArray count];
    else if(section == 4)
        return [self.fourthItemsArray count];
    else if(section == 5)
        return [self.fifthItemsArray count];
    else if(section == 6)
        return [self.sixthItemsArray count];
    else if(section == 7)
        return [self.seventhItemsArray count];
    else
        return 0;
}

//Item at each cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:  (NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"auctionCell"];
    
    if(indexPath.section == 0)
    {
        cell.textLabel.text = [self.defaultItemsArray    objectAtIndex:indexPath.row];
    }
    else if(indexPath.section == 1)
    {
        cell.textLabel.text = [self.firstItemsArray    objectAtIndex:indexPath.row];
    }
    else if(indexPath.section == 2)
    {
        cell.textLabel.text = [self.secondItemsArray    objectAtIndex:indexPath.row];
    }
    else if(indexPath.section == 3)
    {
        cell.textLabel.text = [self.thirdItemsArray    objectAtIndex:indexPath.row];
    }
    else if(indexPath.section == 4)
    {
        cell.textLabel.text = [self.fourthItemsArray    objectAtIndex:indexPath.row];
    }
    else if(indexPath.section == 5)
    {
        cell.textLabel.text = [self.fifthItemsArray    objectAtIndex:indexPath.row];
    }
    else if(indexPath.section == 6)
    {
        cell.textLabel.text = [self.sixthItemsArray    objectAtIndex:indexPath.row];
    }
    else if(indexPath.section == 7)
    {
        cell.textLabel.text = [self.seventhItemsArray    objectAtIndex:indexPath.row];
    }
    else{
        cell.textLabel.text = @"Not Found";
    }
    
    return cell;
}

//If menu button is pressed, pop to root
- (IBAction)menuButtonPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//If back button is pressed, pop current view from stack
- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


//Segue back
-(void) prepareForSegue: (UIStoryboardSegue *)segue sender: (UITableViewCell *)sender {
    
    //Segue from auctionTable to Search Car
    if ([segue.identifier isEqualToString:@"completeEntry"]) {
        label = sender.textLabel.text;
        self.auctionName = label;
    }
    
    //Segue from searchAuctionTable to searchCarResultsTable
    else if([segue.identifier isEqualToString:@"auctionTableSegue"]){
        label = sender.textLabel.text;
        self.auctionName = label;
        
        searchResults *destViewController = segue.destinationViewController;
        destViewController.auctionName = self.auctionName;
        destViewController.fromWhere = @"searchAuction"; 
    }
}

@end
