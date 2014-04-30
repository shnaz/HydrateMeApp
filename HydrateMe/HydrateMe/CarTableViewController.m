//
//  CarTableViewController.m
//  TableViewStory
//
//  Created by Mads Engels on 4/9/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//
/*
 http://www.techotopia.com/index.php/Using_Xcode_5_Storyboards_to_Build_Dynamic_TableViews_with_Prototype_Table_View_Cells
 */

#import "CarTableViewController.h"
#import "CarTableViewCell.h"
#import "AppDelegate.h"

@interface CarTableViewController ()
//-(NSDictionary *)getDatabaseValuesToday;
-(void)getDatabaseValuesToday;
-(void)deleteselectedLogData;


@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end

@implementation CarTableViewController

NSDate *selectedDateToBeDeleted;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    AppDelegate *appDelegate =[[UIApplication sharedApplication] delegate];
    self.managedObjectContext= [appDelegate managedObjectContext];
    [self getDatabaseValuesToday];
}

-(void)getDatabaseValuesToday
{
    
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
    [components setHour:00];
    NSDate *today00AM = [calendar dateFromComponents:components];
    
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity =
    [NSEntityDescription entityForName:@"LoggingData"
                inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    
    NSPredicate *predicate =
    [NSPredicate predicateWithFormat:@"(date_time > %@) && (date_time < %@)", today00AM, now];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
    NSMutableArray *array2 = [NSMutableArray arrayWithObjects:nil];
    NSMutableArray *array3 = [NSMutableArray arrayWithObjects:nil];
    NSMutableArray *array4 = [NSMutableArray arrayWithObjects:nil];
    NSMutableArray *array5 = [NSMutableArray arrayWithObjects:nil];
    NSMutableArray *array6 = [NSMutableArray arrayWithObjects:nil];
    if (array == nil) {
        NSLog(@"Stat log database failed");
    }
    else {
        NSDateFormatter *df = [NSDateFormatter new];
        [df setDateFormat:@"yyyy-MM-dd- HH:mm:ss"];
        df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
        df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:[NSTimeZone localTimeZone].secondsFromGMT];
        
        for (NSManagedObject *logData in array) {
            NSString *fluidType = [logData valueForKey:@"fluit_type"];

            //Create the date assuming the given string is in GMT
            NSDate *date = [logData valueForKey:@"date_time"];

            //Create a date string in the local timezone
            NSString *localDateString = [df stringFromDate:date];
            NSString *dateTimeStamp =  localDateString;
            NSDate *dateTimeStampasdate =  [logData valueForKey:@"date_time"];
            
            NSString *fluidAmount =  [NSString stringWithFormat:
                                      @"%@", [logData valueForKey:@"fluit_amount"]];
            
            //fluidTypeColor
            UIColor *fluidColor;
            UIColor *softDrinkColor=[UIColor colorWithRed:(231/255.0) green:(76/255.0) blue:(60/255.0) alpha:1.0];
            UIColor *coffeeColor=[UIColor colorWithRed:(149/255.0) green:(137/255.0) blue:(116/255.0) alpha:1.0];
            UIColor *waterColor=[UIColor colorWithRed:(49/255.0) green:(139/255.0) blue:(255/255.0) alpha:1.0];
            
            if ([fluidType  isEqual: @"softdrink"]) {
                fluidColor = softDrinkColor;
            }else if ([fluidType  isEqual: @"coffee"]) {
                fluidColor = coffeeColor;
            }else if ([fluidType  isEqual: @"water"]){
                fluidColor = waterColor;
            }
            
            [array2 addObject:fluidType];
            [array3 addObject:dateTimeStamp];
            [array4 addObject:fluidAmount];
            [array5 addObject:fluidColor];
            [array6 addObject:dateTimeStampasdate];
            
        }
        
        //reverse arraylists
        NSMutableArray * dateTimeStampArray = [NSMutableArray arrayWithCapacity:[array2 count]];
        for(int i = 0; i < [array2 count]; i++) {
            [dateTimeStampArray addObject:[array2 objectAtIndex:[array2 count] - i - 1]];
        }
        
        NSMutableArray * dateTimeStampArrayAsDate = [NSMutableArray arrayWithCapacity:[array6 count]];
        for(int i = 0; i < [array6 count]; i++) {
            [dateTimeStampArrayAsDate addObject:[array6 objectAtIndex:[array6 count] - i - 1]];
        }
        
        
        NSMutableArray * fluidTypeArray = [NSMutableArray arrayWithCapacity:[array3 count]];
        for(int i = 0; i < [array3 count]; i++) {
            [fluidTypeArray addObject:[array3 objectAtIndex:[array3 count] - i - 1]];
        }
        
        NSMutableArray * fluidAmountArray = [NSMutableArray arrayWithCapacity:[array4 count]];
        for(int i = 0; i < [array4 count]; i++) {
            [fluidAmountArray addObject:[array4 objectAtIndex:[array4 count] - i - 1]];
        }
        
        NSMutableArray * fluidAmountColorArray = [NSMutableArray arrayWithCapacity:[array5 count]];
        for(int i = 0; i < [array5 count]; i++) {
            [fluidAmountColorArray addObject:[array5 objectAtIndex:[array5 count] - i - 1]];
        }
        
        [_statLogFluidType removeAllObjects];
        [_statLogDates removeAllObjects];
        [_statLogAmount removeAllObjects];
        [_statLogFluidColor removeAllObjects];
        [_statLogDatesAsDates removeAllObjects];
        
        
        _statLogFluidType = [[NSMutableArray alloc] initWithArray:fluidTypeArray copyItems:YES];
        _statLogDates= [[NSMutableArray alloc] initWithArray:dateTimeStampArray copyItems:YES];
        _statLogAmount =  [[NSMutableArray alloc] initWithArray:fluidAmountArray copyItems:YES];
        _statLogFluidColor = [[NSMutableArray alloc] initWithArray:fluidAmountColorArray copyItems:YES];
        _statLogDatesAsDates =  [[NSMutableArray alloc] initWithArray:dateTimeStampArrayAsDate copyItems:YES];
        
    }
}


- (void)deleteselectedLogData
{
    AppDelegate *appDelegate =[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context 	= [appDelegate managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity =
    [NSEntityDescription entityForName:@"LoggingData"
                inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];

    NSPredicate *pred =
    [NSPredicate predicateWithFormat:@"(date_time = %@)",selectedDateToBeDeleted];
    [request setPredicate:pred];
    
    NSManagedObject *matches = nil;
    NSError *error;
    
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    if ([objects count] == 0) {
        NSLog(@"No matches");
    } else {
        matches = objects[0];
        [context deleteObject:matches];
        [context save:nil];
    }
    
    [self getDatabaseValuesToday];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _statLogDates.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"carTableCell";
    CarTableViewCell *cell = [tableView
                              dequeueReusableCellWithIdentifier:CellIdentifier
                              forIndexPath:indexPath];
    
    // Configure the cell...
    
    long row = [indexPath row];
    cell.modelLabel.text = _statLogDates[row];
    cell.fluidAmountLabel.text = _statLogAmount[row];
    cell.makeLabel.text = _statLogFluidType[row];
    cell.fluidTypeColorLabel.backgroundColor = _statLogFluidColor[row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    long row = [indexPath row];
    selectedDateToBeDeleted = _statLogDatesAsDates[row];
    
    UIAlertView* dialog = [[UIAlertView alloc] initWithTitle:@"Delete this log?"
                                                     message:@""
                                                    delegate:self
                                           cancelButtonTitle:@"No"
                                           otherButtonTitles:@"Delete", nil];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [dialog show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex != [alertView cancelButtonIndex])
    {
        [self deleteselectedLogData];
    }
}

@end
