//
//  addDreamCarMake.m
//  infoMobile
//
//  Created by User on 4/18/14.
//  Copyright (c) 2014 Jerry. All rights reserved.
//

#import "addCar.h"
#import "addDreamCarMake.h"

static NSString* makeLabel;

@implementation addDreamCarMake
@synthesize makeName;

//Keep portrait
- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setToolbarHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Initial Dictionary
    makes = @{ @"A" : @[@"Acura",
                         @"AJS",
                         @"Alfa Romeo",
                         @"Allard",
                         @"Allis Chalmers",
                         @"AM General",
                         @"AMC",
                         @"American",
                         @"American Motors",
                         @"Amphicar",
                         @"Ancarrow",
                         @"Ariel",
                         @"Arnolt",
                         @"Arnolt Bristol",
                         @"Art Work",
                         @"Assembled",
                         @"Aston Martin",
                         @"ASVE",
                         @"ASVE",
                         @"Auburn",
                         @"Audi",
                         @"Aurora",
                         @"Austin",
                         @"Austin-Healey",
                         @"Avanti",],
                @"B" : @[@"Bay Marine",
                         @"Beck",
                         @"Bentley",
                         @"BMW",
                         @"Borum",
                         @"Boss",
                         @"Bourget",
                         @"Brainerd Robbins",
                         @"Bricklin",
                         @"BSA",
                         @"Bugatti",
                         @"Buick",],
                @"C" : @[@"C Boat",
                         @"Cadillac",
                         @"Callaway",
                         @"Caterpillar",
                         @"CAV",
                         @"Century",
                         @"Checker",
                         @"Chevrolet",
                         @"Chris-Craft",
                         @"Chris-Craft/Dewhurst",
                         @"Chrysler",
                         @"Cobra",
                         @"Concept",
                         @"Condor",
                         @"Cord",
                         @"Crosley",
                         @"Cushman",
                         @"Custom",
                         @"Custom Built",
                         @"CZ",],
                @"D" : @[@"Daewoo",
                         @"Daihatsu",
                         @"Daimler",
                         @"Dan Kidney",
                         @"Datsun",
                         @"Delorean",
                         @"DeSoto",
                         @"DeTomaso",
                         @"Diamond",
                         @"Dingle",
                         @"DKW",
                         @"Dodge",
                         @"Dodge ",
                         @"Dry Lakes",
                         @"Duck Boat",
                         @"Duesenberg",
                         @"Dunphy",
                         @"Dyno",],
                @"E" : @[@"Eagle",
                         @"Eddie Trotta",
                         @"Edmunds-Kenyon",
                         @"Edsel",
                         @"Era",
                         @"Essex",
                         @"Evinrude",
                         @"Excalibur",
                         @"Eysink",],
                @"F" : @[@"Factory Five",
                         @"Fantasy",
                         @"Farmall",
                         @"Ferrari",
                         @"Fiat",
                         @"Fleetwood",
                         @"Ford",
                         @"Forsa",
                         @"Framed Art",
                         @"Franklin",
                         @"Frazer",],
                @"G" : @[@"Gar Wood",
                         @"Gar Wood/Michaud",
                         @"Gasoline Pump",
                         @"Geo",
                         @"Glen-L",
                         @"GM",
                         @"GMC",
                         @"Goodhue & Hawkins",
                         @"Graham",
                         @"Greavette",
                         @"Griffith",],
                @"H" : @[@"Hacker",
                         @"Hackercraft",
                         @"Harley-Davidson",
                         @"Hendrick Motorsports",
                         @"Henry J",
                         @"Hickman",
                         @"Higgins ",
                         @"Hillman",
                         @"Hogzoom",
                         @"Holden",
                         @"Honda",
                         @"Horex",
                         @"Hudson",
                         @"Hummer",
                         @"Hunter",
                         @"Hupmobile",
                         @"Hutchinson",
                         @"Hyundai",],
                @"I" : @[@"IH",
                         @"IH Farmall",
                         @"Imperial",
                         @"Indian",
                         @"Indian Lakes",
                         @"Infiniti",
                         @"International",
                         @"Isotta",
                         @"Isuzu",],
                @"J" : @[@"Jaguar",
                         @"JBL",
                         @"Jeep",
                         @"Jensen",
                         @"John Deere",
                         @"Johnson",],
                @"K" : @[@"Kaiser",
                         @"Kia",
                         @"KR Proton",
                         @"Kurtis",],
                @"L" : @[@"Lagonda",
                         @"Lamborghini",
                         @"Land Rover",
                         @"Larson",
                         @"Lasalle",
                         @"Lexus",
                         @"Lighted Sign",
                         @"Lincoln",
                         @"Lola",
                         @"Lotus",
                         @"Lucky Fire",
                         @"Luyere",
                         @"Lyman",],
                @"M" : @[@"MAC Tools",
                         @"Mack",
                         @"Malibu",
                         @"Maserati",
                         @"Massey-Harris",
                         @"Matchless",
                         @"Maxton",
                         @"Mazda",
                         @"McCormick",
                         @"McLaren",
                         @"Memorabilia",
                         @"Mercedes-Benz",
                         @"Mercury",
                         @"Merkur",
                         @"Metal Sign",
                         @"MG",
                         @"Midget",
                         @"Mini",
                         @"Mitsubishi",
                         @"Model",
                         @"Moore",
                         @"Morris",
                         @"Mugen",
                         @"Murray",
                         @"MV Agusta",],
                @"N" : @[@"N.U.T.",
                         @"Nash",
                         @"Neon Sign",
                         @"Nissan",
                         @"Norton",
                         @"NSU",],
                @"O" : @[@"Oakland",
                         @"OCC",
                         @"Oldsmobile",
                         @"Oliver Hart-Parr",],
                @"P" : @[@"Pabst ",
                         @"Pace Arrow",
                         @"Packard",
                         @"Panoz",
                         @"Panther",
                         @"Parts",
                         @"Penn Yan",
                         @"Peugeot",
                         @"Pierce-Arrow",
                         @"Plastic Sign",
                         @"Plymouth",
                         @"Pontiac",
                         @"Porcelain Sign",
                         @"Porsche",
                         @"Prevost",
                         @"Pulse",],
                @"Q" : @[@"Qvale",],
                @"R" : @[@"Racing ",
                         @"Rambler",
                         @"Reading-Standard",
                         @"Renault",
                         @"Reo",
                         @"Replica",
                         @"Replicar",
                         @"Retrovette",
                         @"Revcon",
                         @"Richardson",
                         @"Riva",
                         @"Rolls-Royce",],
                @"S" : @[@"Saab",
                         @"Saleen",
                         @"Saturn",
                         @"Schwinn",
                         @"Scorpion",
                         @"Sea Lyon",
                         @"Seagrave",
                         @"Shay",
                         @"Shelby",
                         @"Shepherd",
                         @"SIMCA",
                         @"Sims",
                         @"Skiff Craft",
                         @"Speed Sport",
                         @"Star",
                         @"Staudacher",
                         @"Sterling",
                         @"Steve McQueen",
                         @"Steyr-Daimler Puch",
                         @"Stone Boatyard",
                         @"Studebaker",
                         @"Subaru",
                         @"Sudlow",
                         @"Sunbeam",
                         @"Sunflower",
                         @"Superformance",
                         @"Suzuki",],
                @"T" : @[@"Thompson",
                         @"Tidal Force",
                         @"Tiffany",
                         @"Tin Sign",
                         @"Toyota",
                         @"Trigre",
                         @"Triumph",
                         @"Truscott",
                         @"TVR",],
                @"V" : @[@"Ventnor",
                         @"Vincent",
                         @"Volkswagen",
                         @"Volvo",],
                @"W" : @[@"Wagner",
                         @"Westcott",
                         @"Whiticar",
                         @"Whizzer",
                         @"Willys",
                         @"Wise & Sons",
                         @"Wise Boat & Bus Works",],
                @"Y" : @[@"Yamaha",
                         @"Yamaha Castrol",
                         @"Yellow Jacket",],
                @"Z" : @[@"Zimmer",
                         @"Zundapp",]},
    
    makeSectionTitles = [[makes allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [makeSectionTitles count];
}

//Title at each section
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [makeSectionTitles objectAtIndex:section];
}
- (IBAction)cancelButtonPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//Number of rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSString *sectionTitle = [makeSectionTitles objectAtIndex:section];
    NSArray *sectionModels = [makes objectForKey:sectionTitle];
    return [sectionModels count];
}

//Item at each cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addDreamCarMakeCell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSString *sectionTitle = [makeSectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionmodels = [makes objectForKey:sectionTitle];
    NSString *model = [sectionmodels objectAtIndex:indexPath.row];
    cell.textLabel.text = model;
    
    return cell;
}

//Index on the left side
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return makeSectionTitles;
}

//If back button is pressed, pop current view from stack
- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


//Segue
-(void) prepareForSegue: (UIStoryboardSegue *)segue sender: (UITableViewCell *)sender {
    
    //Segue back to searchCar
    if ([segue.identifier isEqualToString:@"addMakeCompleted"]) {
        makeLabel = sender.textLabel.text;
        self.makeName = makeLabel;
    }
}
@end
