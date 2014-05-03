//
//  modelTable.h
//  infoMobile
//
//  Created by User on 4/17/14.
//  Copyright (c) 2014 Jerry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface modelTable : UITableViewController{
    NSDictionary *models;
    NSArray *modelSectionTitles;
}

    @property (copy, nonatomic) NSString *modelName;

@end
