//
//  detailsView.h
//  infoMobile
//
//  Created by User on 4/27/14.
//  Copyright (c) 2014 Jerry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface detailsView : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *carText;
@property (weak, nonatomic) IBOutlet UILabel *topSalePrice;
@property (weak, nonatomic) IBOutlet UILabel *auctionText;
@property (weak, nonatomic) IBOutlet UILabel *lotText;
@property (weak, nonatomic) IBOutlet UILabel *salePriceText;
@property (weak, nonatomic) IBOutlet UILabel *highBidText;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) id detailItems;
@property (strong, nonatomic) NSURL *imageURL;
@property (weak, nonatomic) IBOutlet UILabel *highHistory;
@property (weak, nonatomic) IBOutlet UILabel *lowHistory;
@property (weak, nonatomic) IBOutlet UILabel *avgHistory;
@property (weak, nonatomic) IBOutlet UILabel *soldHistory;
@property (weak, nonatomic) IBOutlet UILabel *highAuction;
@property (weak, nonatomic) IBOutlet UILabel *lowAuction;
@property (weak, nonatomic) IBOutlet UILabel *info;
@property (weak, nonatomic) IBOutlet UILabel *info2;

@end
