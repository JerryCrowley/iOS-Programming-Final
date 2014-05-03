//
//  addCar.h
//  infoMobile
//
//  Created by User on 4/18/14.
//  Copyright (c) 2014 Jerry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addCar : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *makeText;
@property (strong, nonatomic) IBOutlet UITextField *modelText;
@property (strong, nonatomic) IBOutlet UITextField *yearText;
@property (strong) NSManagedObject *car;

@end
