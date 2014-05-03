//
//  dreamCar.h
//  infoMobile
//
//  Created by User on 4/18/14.
//  Copyright (c) 2014 Jerry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dreamCar : UITableViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSString *makeName;
@property (nonatomic, strong) NSString *modelName;
@property (nonatomic, strong) NSString *yearName;
@property (strong,nonatomic) NSMutableArray *dreamCarArray;

@end
