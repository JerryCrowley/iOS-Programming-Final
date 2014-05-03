//
//  searchCar.m
//  infoMobile
//
//  Created by User on 4/16/14.
//  Copyright (c) 2014 Jerry. All rights reserved.
//

#import "searchCar.h"
#import "auctionTable.h"
#import "modelTable.h"
#import "searchResults.h"

@implementation searchCar
@synthesize auctionLabel,modelLabel;

//Keep portrait
- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

-(void)viewDidLoad{
    [super viewDidLoad];
        
    self.modelText.delegate = self;
    self.lotText.delegate = self;
    self.yearText.delegate = self;
    
    [self.modelText setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.lotText setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.yearText setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    UIColor *customColor = [UIColor colorWithRed:176.0/255.0 green:78.0/255.0 blue: 61.0/255.0 alpha:1];
    
    [self.navigationController.navigationBar setBarTintColor:customColor];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [self.navigationController setToolbarHidden:YES];
    
    UIColor *customColor = [UIColor colorWithRed:176.0/255.0 green:78.0/255.0 blue: 61.0/255.0 alpha:1];
    
    [self.navigationController.navigationBar setBarTintColor:customColor];
}


-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setToolbarHidden:YES];
    
    // Unselect the selected row if any
    NSIndexPath* selection = [self.tableView indexPathForSelectedRow];
    if (selection) {
        [self.tableView deselectRowAtIndexPath:selection animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Do some stuff when the row is selected
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//Unwind segue from auctionTable
- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
    auctionTable *unwoundSegue = segue.sourceViewController;
    self.auctionLabel.text = unwoundSegue.auctionName;
}

//Unwind segue from modelTable
- (IBAction)unwindToListFromModel:(UIStoryboardSegue *)segue{
    modelTable *segue1 = segue.sourceViewController;
    self.modelLabel.text = segue1.modelName;
}

//Dismiss Keyboard
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.modelText resignFirstResponder];
    [self.lotText resignFirstResponder];
    [self.yearText resignFirstResponder];
}

//Dismiss Keyboard
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField){
        [textField resignFirstResponder];
    }
    return NO;
}
- (IBAction)menuButtonPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//Segue
-(void) prepareForSegue: (UIStoryboardSegue *)segue sender: (UITableViewCell *)sender {
    
    //Segue from searchCar to searchResults
    if ([segue.identifier isEqualToString:@"searchToResultSegue"]) {
        searchResults *destViewController = segue.destinationViewController;
        destViewController.auctionName = auctionLabel.text;
        destViewController.makeName = modelLabel.text;
        destViewController.modelName = self.modelText.text;
        destViewController.lotName = self.lotText.text;
        destViewController.yearName = self.yearText.text;
    }
}


@end
