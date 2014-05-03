//
//  searchCar.h
//  infoMobile
//
//  Created by User on 4/16/14.
//  Copyright (c) 2014 Jerry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchCar : UITableViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *auctionLabel;
@property (weak, nonatomic) IBOutlet UILabel *modelLabel;
@property (strong, nonatomic) IBOutlet UITextField *modelText;
@property (strong, nonatomic) IBOutlet UITextField *yearText;
@property (strong, nonatomic) IBOutlet UITextField *lotText;



@end
