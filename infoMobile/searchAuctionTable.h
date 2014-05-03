//
//  searchAuctionTable.h
//  infoMobile
//
//  Created by User on 4/18/14.
//  Copyright (c) 2014 Jerry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchAuctionTable : UITableViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray *defaultItemsArray;
@property (strong, nonatomic) NSArray *firstItemsArray;
@property (strong, nonatomic) NSArray *secondItemsArray;
@property (strong, nonatomic) NSArray *thirdItemsArray;
@property (strong, nonatomic) NSArray *fourthItemsArray;
@property (strong, nonatomic) NSArray *fifthItemsArray;
@property (strong, nonatomic) NSArray *sixthItemsArray;
@property (strong, nonatomic) NSArray *seventhItemsArray;
@property (copy, nonatomic) NSString *auctionName;

@end
