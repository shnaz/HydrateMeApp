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


@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end

@implementation CarTableViewController

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
    
    
    
//    _statLogDates = @[@"Chevy",
//                  @"BMW",
//                  @"Toyota",
//                  @"Volvo",
//                  @"Smart"];
//
    
    
      [self getDatabaseValuesToday];
 
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    NSArray *array2 = [NSArray arrayWithObjects:nil];
    NSArray *array3 = [NSArray arrayWithObjects:nil];
    NSArray *array4 = [NSArray arrayWithObjects:nil];
    NSArray *array5 = [NSArray arrayWithObjects:nil];
    if (array == nil) {
        NSLog(@"Stat log database failed");
    }
    else {
       
        for (NSManagedObject *logData in array) {
            NSString *fluidType = [logData valueForKey:@"fluit_type"];
           
            
            NSString *dateTimeStamp =  [NSString stringWithFormat:
                                        @"%@", [logData valueForKey:@"date_time"]];
            
            
            NSString *fluidAmount =  [NSString stringWithFormat:
                                        @"%@", [logData valueForKey:@"fluit_amount"]];
            //if ([fluidType isEqualToString:@"water"]) {
               // int fluidAmount = [[logData valueForKey:@"fluit_amount"] intValue];
               // waterIntakeUntilNow += fluidAmount;
           // }else if ([fluidType isEqualToString:@"softdrink"]) {
                //int fluidAmount = [[logData valueForKey:@"fluit_amount"] intValue];
                //softDrinkIntakeUntilNow += fluidAmount;
           // }else{
               // int fluidAmount = [[logData valueForKey:@"fluit_amount"] intValue];
                //coffeeIntakeUntilNow += fluidAmount;
            //}
            
            
          
            
            array2 = [array2 arrayByAddingObject:fluidType];
            array3 = [array3 arrayByAddingObject:[dateTimeStamp substringToIndex:[dateTimeStamp length]-5]];
            array4 = [array4 arrayByAddingObject:fluidAmount];
            
            //fluidTypeColor
            UIColor *fluidColor;
            UIColor *softDrinkColor=[UIColor colorWithRed:(231/255.0) green:(76/255.0) blue:(60/255.0) alpha:1.0];
            UIColor *coffeeColor=[UIColor colorWithRed:(149/255.0) green:(137/255.0) blue:(116/255.0) alpha:1.0];
            UIColor *waterColor=[UIColor colorWithRed:(49/255.0) green:(139/255.0) blue:(255/255.0) alpha:1.0];
            
            if ([fluidType  isEqual: @"softdrink"]) {
                fluidColor = softDrinkColor;
            
            array5 = [array5 arrayByAddingObject:fluidColor];
            }else if ([fluidType  isEqual: @"coffee"]) {
                 fluidColor = coffeeColor;
            }else {
            fluidColor = waterColor;
            }
            
            array5 = [array5 arrayByAddingObject:fluidColor];
        }
        
        //reverse arraylists
        NSMutableArray * dateTimeStampArray = [NSMutableArray arrayWithCapacity:[array2 count]];
        for(int i = 0; i < [array count]; i++) {
            [dateTimeStampArray addObject:[array2 objectAtIndex:[array2 count] - i - 1]];
        }
        NSMutableArray * fluidTypeArray = [NSMutableArray arrayWithCapacity:[array3 count]];
        for(int i = 0; i < [array count]; i++) {
            [fluidTypeArray addObject:[array3 objectAtIndex:[array3 count] - i - 1]];
        }
        
        NSMutableArray * fluidAmountArray = [NSMutableArray arrayWithCapacity:[array4 count]];
        for(int i = 0; i < [array count]; i++) {
            [fluidAmountArray addObject:[array4 objectAtIndex:[array4 count] - i - 1]];
        }
        
        NSMutableArray * fluidAmountColorArray = [NSMutableArray arrayWithCapacity:[array5 count]];
        for(int i = 0; i < [array count]; i++) {
            [fluidAmountColorArray addObject:[array5 objectAtIndex:[array5 count] - i - 1]];
        }
        
        
        //found arraylist to the labelArraylists
        _statLogFluidType = fluidTypeArray;
        _statLogDates= dateTimeStampArray;
        _statLogAmount = fluidAmountArray;
        _statLogFluidColor =fluidAmountColorArray;

    }
    
 
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
    
    //colorlabel
   
cell.fluidTypeColorLabel.backgroundColor = _statLogFluidColor[row];
    


    
    return cell;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
