//
//  searchAuctionTable.m
//  infoMobile
//
//  Created by User on 4/18/14.
//  Copyright (c) 2014 Jerry. All rights reserved.
//

#import "searchAuctionTable.h"
#import "auctionTable.h"

static NSString *label;

@implementation searchAuctionTable
@synthesize auctionName;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Default section data
    self.defaultItemsArray=@[@"All"];
    
    //First section data
    self.firstItemsArray = @[@"Houston, TX 4/2014",@"Davenport, IA 4/2014",@"Kissimmee, FL 1/2014",@"Las Vegas, NV 1/2014"];
    
    //Second section data
    self.secondItemsArray = @[@"Kansas City, MO 12/2013",
                              @"Anaheim, CA 11/2013",
                              @"Davenport, IA 11/2013",
                              @"Schaumburg, IL 10/2013",
                              @"Dallas, TX 9/2013",
                              @"Monterey, CA 8/2013",
                              @"Walworth, WI 8/2013",
                              @"Santa Monica, CA 7/2013",
                              @"Des Moines, IA 7/2013",
                              @"West Allis, WI 7/2013",
                              @"Champaign , IL 6/2013",
                              @"Indianapolis, IN 5/2013",
                              @"Kansas City, MO 4/2013",
                              @"Houston, TX 4/2013",
                              @"Davenport, IA 4/2013",
                              @"Boynton Beach, FL 2/2013",
                              @"Kissimmee, FL 1/2013"];
    
    //Third section data
    self.thirdItemsArray = @[@"Kansas City, MO 12/2012",
                             @"Anaheim, CA 11/2012",
                             @"Davenport, IA 11/2012",
                             @"St Charles, IL 10/2012",
                             @"Dallas, TX 9/2012",
                             @"Monterey, CA 8/2012",
                             @"Walworth, WI 8/2012",
                             @"Des Moines, IA 7/2012",
                             @"West Allis, WI 7/2012",
                             @"St. Charles, IL 6/2012",
                             @"St. Paul, MN 6/2012",
                             @"North Little Rock, AR 6/2012",
                             @"Indianapolis, IN 5/2012",
                             @"Houston, TX 4/2012",
                             @"Walworth, WI 4/2012",
                             @"Kansas City, MO 3/2012",
                             @"Kissimmee, FL 1/2012"];
    
    //Fourth section data
    self.fourthItemsArray = @[@"Kansas City, MO 12/2011",
                              @"Dallas, TX 10/2011",
                              @"Fontana, WI 9/2011",
                              @"St. Charles, IL 9/2011",
                              @"Monterey, CA 8/2011",
                              @"Walworth, WI 8/2011",
                              @"Des Moines, IA 7/2011",
                              @"West Allis, WI 7/2011",
                              @"St. Charles, IL 6/2011",
                              @"St. Paul, MN 6/2011",
                              @"Indianapolis, IN 5/2011",
                              @"Walworth, WI 3/2011",
                              @"Kansas City, MO 3/2011",
                              @"Kissimmee, FL 1/2011"];
    
    //Fifth section data
    self.fifthItemsArray = @[@"Kansas City, MO 12/2010",
                             @"Canal Winchester, OH 11/2010",
                             @"Ft. Lauderdale, FL 10/2010",
                             @"Winsted, MN 10/2010",
                             @"St. Charles, IL 9/2010",
                             @"Monterey, CA 8/2010",
                             @"Walworth, WI 8/2010",
                             @"Des Moines, IA 7/2010",
                             @"St. Charles, IL 6/2010",
                             @"St. Paul, MN 6/2010",
                             @"Indianapolis, IN 5/2010",
                             @"Kansas City, MO 4/2010",
                             @"Kissimmee, FL 1/2010"];
    
    //Sixth section data
    self.sixthItemsArray = @[@"Kansas City, MO 12/2009",
                             @"Branson, MO 10/2009",
                             @"St. Charles, IL 10/2009",
                             @"Canal Winchester, OH 9/2009",
                             @"Monterey, CA 8/2009",
                             @"Des Moines, IA 7/2009",
                             @"St. Charles, IL 6/2009",
                             @"St. Paul, MN 6/2009",
                             @"Indianapolis, IN 5/2009",
                             @"Kansas City, MO 3/2009",
                             @"Kissimmee, FL 1/2009"];
    
    //Seventh section data
    self.seventhItemsArray = @[@"Kansas City, MO 12/2008",
                               @"St. Charles, IL 10/2008",
                               @"Canal Winchester, OH 9/2008",
                               @"Des Moines, IA 7/2008",
                               @"St. Charles, IL 6/2008",
                               @"St. Paul, MN 6/2008",
                               @"Indianapolis, IN 5/2008",
                               @"Kissimmee, FL 1/2008"];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor yellowColor]];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}


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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:  (NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchAuctionCell"];
    
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


-(void) prepareForSegue: (UIStoryboardSegue *)segue sender: (UITableViewCell *)sender {
    NSLog(@"SEGUE");
    if ([segue.identifier isEqualToString:@"searchAuctionSegue"]) {
        NSLog(@"HERE");
        label = sender.textLabel.text;
        NSLog(@"%@",label);
        self.auctionName = label;
    }
}

@end