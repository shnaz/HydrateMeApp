//
//  GraphSubViewController.m
//  HydrateMe
//
//  Created by Shafi on 23/04/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import "GraphSubViewController.h"
#import "AppDelegate.h"

@interface GraphSubViewController ()

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,readwrite) NSMutableDictionary *lastSevenDays;

-(void)getLastSevenDaysFluidIntakes;
-(int)getDayDate:(int) minusDays;
-(void)updateFluidIntakeFor:(NSString*)day withFluidAmmounts: (int)water : (int)softDrink :(int)coffee;

@end

@implementation GraphSubViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *appDelegate =[[UIApplication sharedApplication] delegate];
    self.managedObjectContext= [appDelegate managedObjectContext];
    
    // Initializing dict for Last seven days
    NSMutableDictionary *fluids = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                            [NSNumber numberWithInt: 0], @"waterIntake",
                            [NSNumber numberWithInt: 0], @"softDrinkIntake",
                            [NSNumber numberWithInt: 0], @"coffeeIntake",
                            nil];

    self.lastSevenDays = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                          fluids, @"todayMinus1",
                          fluids, @"todayMinus2",
                          fluids, @"todayMinus3",
                          fluids, @"todayMinus4",
                          fluids, @"todayMinus5",
                          fluids, @"todayMinus6",
                          fluids, @"todayMinus7",
     nil];
    
    // Get last week's fluid intakes
    [self getLastSevenDaysFluidIntakes];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(int)getDayDate:(int) minusDays
{
    NSDate *now = [NSDate date];
    [now descriptionWithLocale:[NSLocale systemLocale]];
    
    NSDateComponents* todayComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
    [todayComponents setDay: minusDays];
    NSDate *previousDay = [[NSCalendar currentCalendar] dateByAddingComponents:todayComponents toDate:now options:0];
    
    NSDateComponents* yesterdayComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:previousDay];
    
    return [yesterdayComponents day];
}

-(void)getLastSevenDaysFluidIntakes
{
    NSDate *now = [NSDate date];
    [now descriptionWithLocale:[NSLocale systemLocale]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now ];
    [components setHour:00];
    NSDate *today00AM = [calendar dateFromComponents:components];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:-7];
    NSDate *sevenDaysAgo = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:today00AM options:0];
    
    
    NSLog(@"\ncurrentDate: %@\nseven days ago: %@", now, sevenDaysAgo);
    
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity =
    [NSEntityDescription entityForName:@"LoggingData"
                inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    
    NSPredicate *predicate =
    [NSPredicate predicateWithFormat:@"(date_time > %@) && (date_time < %@)", sevenDaysAgo, now];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];

    if (array == nil) {
        NSLog(@"Fetch water logging data failed");
    }
    else
    {
        for (NSManagedObject *logData in array)
        {
            NSDate *logDate = [logData valueForKey:@"date_time"];
            NSDateComponents* components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:logDate];
            int dayDate = [components day]; //gives you day
            //NSLog(@"Fetch logdates: %d",dayDate);
            
            int water = 0; int softDrink = 0; int coffee = 0;
            
            NSString *fluidType = [logData valueForKey:@"fluit_type"];
            
            if ([fluidType isEqualToString:@"water"]){
                water = [[logData valueForKey:@"fluit_amount"] intValue];
            }else if ([fluidType isEqualToString:@"softdrink"]){
                softDrink = [[logData valueForKey:@"fluit_amount"] intValue];
            }else{
                coffee = [[logData valueForKey:@"fluit_amount"] intValue];
            }
            
            
            if ( dayDate == [self getDayDate:-1] ) {
                [self updateFluidIntakeFor:@"todayMinus1" withFluidAmmounts:water:softDrink:coffee];
            } else if( dayDate == [self getDayDate:-2] ) {
                [self updateFluidIntakeFor:@"todayMinus2" withFluidAmmounts:water:softDrink:coffee];
            } else if( dayDate == [self getDayDate:-3] ) {
                [self updateFluidIntakeFor:@"todayMinus3" withFluidAmmounts:water:softDrink:coffee];
            } else if( dayDate == [self getDayDate:-4] ) {
                [self updateFluidIntakeFor:@"todayMinus4" withFluidAmmounts:water:softDrink:coffee];
            } else if( dayDate == [self getDayDate:-5] ) {
                [self updateFluidIntakeFor:@"todayMinus5" withFluidAmmounts:water:softDrink:coffee];
            } else if( dayDate == [self getDayDate:-6] ) {
                [self updateFluidIntakeFor:@"todayMinus6" withFluidAmmounts:water:softDrink:coffee];
            } else if( dayDate == [self getDayDate:-7] ) {
                [self updateFluidIntakeFor:@"todayMinus7" withFluidAmmounts:water:softDrink:coffee];
            }
            
        }
        
    }
    
    NSLog(@"Fetch logdates: %@",self.lastSevenDays);
}

-(void)updateFluidIntakeFor:(NSString*)day withFluidAmmounts: (int)water : (int)softDrink :(int)coffee
{
    
    NSMutableDictionary *root = [[NSMutableDictionary alloc] initWithDictionary:( [self.lastSevenDays valueForKey:day]) copyItems:YES];
    
    NSNumber *oldWater = [root valueForKey:@"waterIntake"];
    [root setValue:[NSNumber numberWithInt:[oldWater intValue] + water]
            forKey:@"waterIntake"];
    
    NSNumber *oldSoftDrink = [root valueForKey:@"softDrinkIntake"];
    [root setValue:[NSNumber numberWithInt:[oldSoftDrink intValue] + softDrink]
            forKey:@"softDrinkIntake"];
    
    NSNumber *oldCoffee = [root valueForKey:@"coffeeIntake"];
    [root setValue:[NSNumber numberWithInt:[oldCoffee intValue] + coffee]
            forKey:@"coffeeIntake"];
    
    [self.lastSevenDays setValue:root forKey:day];
    
}





@end
