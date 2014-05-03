//
//  dreamCar.m
//  infoMobile
//
//  Created by User on 4/18/14.
//  Copyright (c) 2014 Jerry. All rights reserved.
//

#import "addCar.h"
#import "dreamCar.h"
#import "searchResults.h"

@implementation dreamCar
@synthesize dreamCarArray;

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

-(void)viewDidLoad{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setToolbarHidden:YES];
    
    // Unselect the selected row if any
    NSIndexPath*    selection = [self.tableView indexPathForSelectedRow];
    if (selection) {
        [self.tableView deselectRowAtIndexPath:selection animated:YES];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.navigationController setToolbarHidden:YES];
    
    //Get cars from database
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Cars"];
    dreamCarArray = [[moc executeFetchRequest:fetchRequest error:nil]mutableCopy];
    
    [self.tableView reloadData];
}

- (IBAction)menuButtonPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dreamCarArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"dreamCarCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    //Configure the cell
    NSManagedObject *car = [dreamCarArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@ %@", [car valueForKey:@"year"],[car valueForKey:@"make"],[car valueForKey:@"model"]]];
     
     return cell;
}

//Override to support conditional editing of the table view
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//Override to support editing the table view
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    //If deletion is in progress
    if(editingStyle == UITableViewCellEditingStyleDelete){
        //Delete the object from the database
        [context deleteObject:[dreamCarArray objectAtIndex:indexPath.row]];
        
        //Invoke the save method to commit the change
        NSError *error = nil;
        if(![context save:&error]){
            NSLog(@"Can't Delete %@ %@",error,[error localizedDescription]);
            return;
        }
        
        //Remove car from table view
        [dreamCarArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                              withRowAnimation:UITableViewRowAnimationFade];
    }
}

//Segue
-(void) prepareForSegue: (UIStoryboardSegue *)segue sender: (UITableViewCell *)sender {
    
    //Segue from searchCar to searchResults
    if ([segue.identifier isEqualToString:@"dreamCarToSearchResults"]) {
        NSManagedObject *selectedCar = [dreamCarArray objectAtIndex:[[self.tableView indexPathForSelectedRow]row]];
        searchResults *destViewController = segue.destinationViewController;
        destViewController.modelName = [selectedCar valueForKey:@"model"];
        destViewController.makeName = [selectedCar valueForKey:@"make"];
        destViewController.yearName = [selectedCar valueForKey:@"year"];
    }
}



@end
