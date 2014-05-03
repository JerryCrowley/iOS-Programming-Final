//
//  searchResults.h
//  infoMobile
//
//  Created by User on 4/17/14.
//  Copyright (c) 2014 Jerry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface searchResults : PFQueryTableViewController<UIAlertViewDelegate, UIActionSheetDelegate>
@property (nonatomic, strong) NSString *auctionName;
@property (nonatomic, strong) NSString *makeName;
@property (nonatomic, strong) NSString *modelName;
@property (nonatomic, strong) NSString *lotName;
@property (nonatomic, strong) NSString *yearName;
@property (strong, nonatomic) IBOutlet UITableView *results;
@property (nonatomic, strong) NSString *fromWhere;
@property (nonatomic, strong) NSString *value;
@end
