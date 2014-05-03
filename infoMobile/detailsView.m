//
//  detailsView.m
//  infoMobile
//
//  Created by User on 4/27/14.
//  Copyright (c) 2014 Jerry. All rights reserved.
//

#import "detailsView.h"
#import <Parse/Parse.h>
#import "reachability.h"

@interface detailsView ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator1;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator2;

@end

@implementation detailsView

//Keep portrait
- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL) connectedToNetwork
{
	Reachability *r = [Reachability reachabilityWithHostName:@"www.google.com"];
	NetworkStatus internetStatus = [r currentReachabilityStatus];
	BOOL internet;
	if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN)) {
		internet = NO;
	} else {
		internet = YES;
	}
	return internet;
}


-(BOOL) checkInternet
{
	//Make sure we have internet connectivity
	if([self connectedToNetwork] != YES)
	{
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"No Network Connectivity!"
                                                          message:@"No network connection found. An Internet connection is required for this application to work."
                                                         delegate:self
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        
		return NO;
	}
	else {
		return YES;
	}
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    // My OK button
    if (buttonIndex == alertView.cancelButtonIndex) {
        //When pressed, return to previous page.
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//Set URL
-(void)setImageURL:(NSURL *)imageURL{
    _imageURL = imageURL;
    
    if(![[self.detailItems objectForKey:@"IMAGE"] isEqualToString:@"None"]){
        [self startDownloadingImage];
    }
    else{
        [self.activityIndicator1 stopAnimating];
    }
}

//Download image from URL
-(void)startDownloadingImage{
    self.image = nil;
    if(self.imageURL){
        NSURLRequest *request = [NSURLRequest requestWithURL:self.imageURL];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
                                                        completionHandler:^(NSURL *localfile, NSURLResponse *response, NSError *error) {
                                                            if(!error){
                                                                if([request.URL isEqual:self.imageURL]){
                                                                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localfile]];
                                                                    dispatch_async(dispatch_get_main_queue(), ^{self.image = image;
                                                                    [self.activityIndicator1 stopAnimating];});
                                                                }
                                                            }
                                                        }];
        [task resume];
    }
}



-(UIImageView *)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc]init];
    }
    
    return _imageView;
}

-(UIImage *)image{
    return self.imageView.image;
}

-(void)setImage:(UIImage *)image{
    self.imageView.image = image;
}

//Fetch Data to calculate stats
-(void)fetchData{
    PFQuery *query = [PFQuery queryWithClassName:@"data"];
    NSString* getModel = [NSString stringWithFormat:@"%@",[self.detailItems objectForKey:@"MODEL"]];
    NSArray* splitString = [getModel componentsSeparatedByString:@" "];
    NSString* model = [splitString objectAtIndex:0];
    
    // Retrieve the most recent ones
    [query orderByDescending:@"DATE"];
    
    query.limit = 1000;
    
    if( ([self.detailItems objectForKey:@"MAKE"] != NULL) && (![[self.detailItems objectForKey:@"MAKE"] isEqualToString:@"Make"]))
    {
        [query whereKey:@"MAKE" equalTo:[self.detailItems objectForKey:@"MAKE"]];
    }
    
    if( ([self.detailItems objectForKey:@"MODEL"] != NULL) && (![[self.detailItems objectForKey:@"MODEL"] isEqualToString:@"Model"]))
    {
        [query whereKey:@"MODEL" containsString:model];
    }
    
    if( ([self.detailItems objectForKey:@"YEAR"] != NULL) && (![[self.detailItems objectForKey:@"YEAR"] isEqualToString:@"Year"]))
    {
        [query whereKey:@"YEAR" equalTo:[self.detailItems objectForKey:@"YEAR"]];
    }
    
    //Query database for results
    
    //Fix 
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSMutableArray *results = [[NSMutableArray alloc]init];
        
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                [results addObject:object];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //Send to main thread
                [self updateData:results];
            });
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

-(void)updateData:(NSMutableArray *)objects{
    int count=0,total=0;
    int high = 0;
    int low = 1000000000;
    NSString *highAuction, *lowAuction;
    int counter = objects.count;
    
    //Loop through results to calculate high,low, and average 
    for(int i = 0; i<counter;i++){
        NSString *value = [[objects objectAtIndex:i]objectForKey:@"SALEPRICE"];
        if(![value isEqualToString:@"None"]){
            if([value intValue] > high){
                high = [value intValue];
                highAuction = [[objects objectAtIndex:i]objectForKey:@"AUCTION"];
            }
            if([value intValue] < low){
                low = [value intValue];
                lowAuction = [[objects objectAtIndex:i]objectForKey:@"AUCTION"];
            }
            total+=[value intValue];
            count++;
        }
    }
    
    //If none were ever sold
    if(count == 0){
        self.highHistory.text = @"N/A";
        self.highAuction.text = @"N/A";
        self.lowHistory.text  = @"N/A";
        self.lowAuction.text  = @"N/A";
        self.avgHistory.text  = @"N/A";
        self.soldHistory.text = [NSString stringWithFormat:@"%d / %d",count,counter];
        self.info.text = @"Since 2008";
        self.info2.text = @"N/A";
    }
    
    else{
        self.highHistory.text = [NSString stringWithFormat:@"$%d",high];
        self.highAuction.text = highAuction;
        self.lowHistory.text  = [NSString stringWithFormat:@"$%d",low];
        self.lowAuction.text  = lowAuction;
        self.avgHistory.text  = [NSString stringWithFormat:@"$%d",(total/count)];
        self.soldHistory.text = [NSString stringWithFormat:@"%d / %d",count,counter];
        self.info.text = @"Since 2008";
        self.info2.text = @"Since 2008";
    }
    
    [self.activityIndicator2 stopAnimating];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.activityIndicator1 startAnimating];
    [self.activityIndicator2 startAnimating];
    
    if([self checkInternet]==YES){
        NSString *combined = [NSString stringWithFormat:@"%@ %@ %@",[self.detailItems objectForKey:@"YEAR"],[self.detailItems objectForKey:@"MAKE"],[self.detailItems objectForKey:@"MODEL"]];
    
        self.carText.text = combined;
    
        //Set saleprice
        if([[self.detailItems objectForKey:@"SALEPRICE"] isEqualToString:@"None"]){
            self.topSalePrice.text = [NSString stringWithFormat:@"Not Sold"];
        }
        else{
            self.topSalePrice.text = [NSString stringWithFormat:@"$%@",[self.detailItems objectForKey:@"SALEPRICE"]];
        }
    
        //Set Auction, Lot, and Image
        self.auctionText.text = [self.detailItems objectForKey:@"AUCTION"];
        self.lotText.text = [self.detailItems objectForKey:@"LOT"];
        self.salePriceText.text = self.topSalePrice.text;
        self.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.detailItems objectForKey:@"IMAGE"]]];
    
        //Set Highbid
        if([[self.detailItems objectForKey:@"HIGHBID"] isEqualToString:@"None"]){
            NSLog(@"%@",self.topSalePrice.text);
            if([self.topSalePrice.text isEqualToString:@"Not Sold"]){
                self.highBidText.text = [NSString stringWithFormat:@"No Info"];
            }
            else{
                self.highBidText.text = self.topSalePrice.text;
            }
        }
        else{
            self.highBidText.text = [NSString stringWithFormat:@"$%@",[self.detailItems objectForKey:@"HIGHBID"]];
        }
    
        //If no image, set image to no_image_found.png
        if([[self.detailItems objectForKey:@"IMAGE"] isEqualToString:@"None"]){
            UIImage *newImage = [UIImage imageNamed:@"no_image_found.png"];
            self.image = newImage;
        }

        //Fetch Data for price history
        [self fetchData];
    }
    
    else{
        [self.activityIndicator1 stopAnimating];
        [self.activityIndicator2 stopAnimating];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setToolbarHidden:YES];
}

- (IBAction)menuButtonPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end