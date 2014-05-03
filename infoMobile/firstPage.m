//
//  firstPage.m
//  infoMobile
//
//  Created by User on 4/21/14.
//  Copyright (c) 2014 Jerry. All rights reserved.
//

#import "firstPage.h"
#import "Reachability.h"

@interface firstPage ()
@property (weak, nonatomic) IBOutlet UIButton *searchCarsButton;
@property (weak, nonatomic) IBOutlet UIButton *searchAuctionsButton;
@property (weak, nonatomic) IBOutlet UIButton *dreamCarButton;
@property (weak, nonatomic) IBOutlet UIButton *liveStream;

@end


@implementation firstPage

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
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        
		return NO;
	}
	else {
		return YES;
	}
}

-(void)viewDidAppear:(BOOL)animated{
    //Check internet connection
    [self checkInternet];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self.navigationController setToolbarHidden:YES];
    
    UIImageView *newOneselement = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
    UIImageView *basketTop = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coverTop.png"]];
    UIImageView *basketBottom = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coverBottom.png"]];
    
    //Resize for 4.0 inch iOS Device
    if (IS_IPHONE_5){
        newOneselement.frame = CGRectMake(27,35, 266, 218);
        basketTop.frame = CGRectMake(-3, -43, 327, 333);
        basketBottom.frame = CGRectMake(-3, 290, 327, 278);
    }
    
    //Resize for 3.5 inch iOS Device
    else if (IS_IPHONE){
        newOneselement.frame = CGRectMake(27,15, 266, 218);
        basketTop.frame = CGRectMake(-3, -43, 327, 285);
        basketBottom.frame = CGRectMake(-3, 242, 327, 326);
        self.searchCarsButton.center = CGPointMake(92,305);
        self.searchAuctionsButton.center = CGPointMake(228,306);
        self.dreamCarButton.center = CGPointMake(92,424);
        self.liveStream.center = CGPointMake(228,424);
    }
    
    [self.view addSubview:newOneselement];
    [self.view addSubview:basketTop];
    [self.view addSubview:basketBottom];
    
    //Sound
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:@"auctionSound"
                                         ofType:@"wav"]];
    NSError *error = nil;
    _audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url
                                   error:&error];    
    if (error)
    {
        NSLog(@"Error in audioPlayer: %@",[error localizedDescription]);
    }
    else
    {
        _audioPlayer.delegate = self;
        [_audioPlayer play];
    }
    
    //Animation
    CGRect basketTopFrame = basketTop.frame;
    basketTopFrame.origin.y = -basketTopFrame.size.height;
    
    CGRect basketBottomFrame = basketBottom.frame;
    basketBottomFrame.origin.y = self.view.bounds.size.height;
    
    
    [UIView animateWithDuration:2.0 delay:2.0 options:UIViewAnimationOptionTransitionCurlUp
                                            animations:^{
                                                basketTop.alpha = 0.0;
                                                basketBottom.alpha = 0.0;}
                                            completion:^(BOOL finished) {
                                                   //NSLog(@"Done");
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setToolbarHidden:YES];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}
@end
