//
//  addCar.m
//  infoMobile
//
//  Created by User on 4/18/14.
//  Copyright (c) 2014 Jerry. All rights reserved.
//

#import "addCar.h"
#import "addDreamCarMake.h"

@implementation addCar
@synthesize makeText,modelText,yearText,car;

//Keep portrait
- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

//Retreive managed object context and later save the data
-(NSManagedObjectContext *)managedObjectContext{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if([delegate performSelector:@selector(managedObjectContext)]){
        context = [delegate managedObjectContext];
    }
    return context;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setToolbarHidden:YES];
    
    // Unselect the selected row if any
    NSIndexPath*    selection = [self.tableView indexPathForSelectedRow];
    if (selection) {
        [self.tableView deselectRowAtIndexPath:selection animated:YES];
    }
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    modelText.delegate = self;
    yearText.delegate = self;
    
    [self.modelText setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.yearText setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    if(car){
        [makeText setText:[car valueForKey:@"make"]];
        [modelText setText:[car valueForKey:@"model"]];
        [yearText setText:[car valueForKey:@"year"]];
    }
}

//If cancel button is pressed, pop current view from stack
- (IBAction)cancelButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//If done button is pressed
- (IBAction)doneButtonPressed:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    //If car already exists
    if(car){ 
        //Update Car
        [car setValue:makeText.text forKey:@"make"];
        [car setValue:modelText.text forKey:@"model"];
        [car setValue:yearText.text forKey:@"year"];
    }
    
    //Else add car
    else{
        //Create new Car
        NSManagedObject *newCar = [NSEntityDescription insertNewObjectForEntityForName:@"Cars" inManagedObjectContext:context];
        [newCar setValue:makeText.text forKey:@"make"];
        [newCar setValue:modelText.text forKey:@"model"];
        [newCar setValue:yearText.text forKey:@"year"];
        
    }
    
    NSError *error = nil;
    //Save the context
    if(![context save:&error]){
        NSLog(@"Save Failed! %@ %@", error, [error localizedDescription]);
    }
    
    //Pop current view from stack
    [self.navigationController popViewControllerAnimated:YES];
}

//Unwind segue from addDreamCarMake
- (IBAction)unwindToListFromAddMake:(UIStoryboardSegue *)segue{
    addDreamCarMake *segue1 = segue.sourceViewController;
    self.makeText.text = segue1.makeName;
}

//Dismiss Keyboard
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.modelText resignFirstResponder];
    [self.yearText resignFirstResponder];
}

//Dismiss Keyboard
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField){
        [textField resignFirstResponder];
    }
    return NO;
}
@end
