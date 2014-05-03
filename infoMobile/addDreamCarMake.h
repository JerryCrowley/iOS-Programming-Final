//
//  addDreamCarMake.h
//  infoMobile
//
//  Created by User on 4/18/14.
//  Copyright (c) 2014 Jerry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addDreamCarMake : UITableViewController{
    NSDictionary *makes;
    NSArray *makeSectionTitles;
}

    @property (copy,nonatomic) NSString *makeName;

@end
