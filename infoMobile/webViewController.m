//
//  webViewController.m
//  infoMobile
//
//  Created by User on 4/29/14.
//  Copyright (c) 2014 Jerry. All rights reserved.
//

#import "webViewController.h"
#import "reachability.h"

@interface webViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation webViewController

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

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setToolbarHidden:YES];
    [self.activityIndicator startAnimating];
    [self.webView loadRequest: [NSURLRequest requestWithURL: [NSURL URLWithString:@"http://m.ustream.tv/channel/Mecum-Muscle-cars-and-More-Live-Auction"]]];
    
}

-(void)viewDidAppear:(BOOL)animated{
    //Check internet connection
    if([self checkInternet] == NO){
        [self.activityIndicator stopAnimating];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.webView.backgroundColor = [UIColor clearColor];
    [self.webView setOpaque:NO];
    
    self.webView.delegate = self;
}

- (void) webViewDidFinishLoad:(UIWebView *)webView {
    
    //Remove Header
    NSString *js = @"var styleTag = document.createElement('style'); styleTag.innerText = 'header{display: none;}'; document.body.appendChild(styleTag);";
    [webView stringByEvaluatingJavaScriptFromString: js];
    
    //Remove footer
    NSString *js1 = @"var styleTag1 = document.createElement('style'); styleTag1.innerText = '.footer, .textile-bg{display: none;}'; document.body.appendChild(styleTag1);";
    [webView stringByEvaluatingJavaScriptFromString: js1];
    
    [self.activityIndicator stopAnimating];
    
    //Hide webview until it's finished for better experience
    [UIView animateWithDuration:.25 delay:1 options:0 animations:^(){ self.webView.alpha = 1; }completion:NULL];
}


- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
