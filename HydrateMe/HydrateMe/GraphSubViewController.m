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

-(void)updateGraph;
-(double)getWaterIntakeLevelFor:(NSString*)day;
-(double)getSoftDrinkIntakeLevelFor:(NSString*)day;
-(double)getCoffeeIntakeLevelFor:(NSString*)day;
-(CGRect)getUpdatedBarFrame:(CGRect)barFrame withFluid:(double)percent;
-(NSString*)getWeekDayName:(int) minusDays;


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

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    //Update graph
    [self updateGraph];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateGraph
{
    self.todayMinus1DayName.text = [self getWeekDayName:-1];
    self.todayMinus1WaterBar.frame = [self getUpdatedBarFrame:self.todayMinus1WaterBar.frame withFluid:[self getWaterIntakeLevelFor:@"todayMinus1"]];
    self.todayMinus1SoftDrinkBar.frame = [self getUpdatedBarFrame:self.todayMinus1SoftDrinkBar.frame withFluid:[self getSoftDrinkIntakeLevelFor:@"todayMinus1"]];
    self.todayMinus1CoffeeBar.frame = [self getUpdatedBarFrame:self.todayMinus1CoffeeBar.frame withFluid:[self getCoffeeIntakeLevelFor:@"todayMinus1"]];
    
    self.todayMinus2DayName.text = [self getWeekDayName:-2];
    self.todayMinus2WaterBar.frame = [self getUpdatedBarFrame:self.todayMinus2WaterBar.frame withFluid:[self getWaterIntakeLevelFor:@"todayMinus2"]];
    self.todayMinus2SoftDrinkBar.frame = [self getUpdatedBarFrame:self.todayMinus2SoftDrinkBar.frame withFluid:[self getSoftDrinkIntakeLevelFor:@"todayMinus2"]];
    self.todayMinus2CoffeeBar.frame = [self getUpdatedBarFrame:self.todayMinus2CoffeeBar.frame withFluid:[self getCoffeeIntakeLevelFor:@"todayMinus2"]];
    
    self.todayMinus3DayName.text = [self getWeekDayName:-3];
    self.todayMinus3WaterBar.frame = [self getUpdatedBarFrame:self.todayMinus3WaterBar.frame withFluid:[self getWaterIntakeLevelFor:@"todayMinus3"]];
    self.todayMinus3SoftDrinkBar.frame = [self getUpdatedBarFrame:self.todayMinus3SoftDrinkBar.frame withFluid:[self getSoftDrinkIntakeLevelFor:@"todayMinus3"]];
    self.todayMinus3CoffeeBar.frame = [self getUpdatedBarFrame:self.todayMinus3CoffeeBar.frame withFluid:[self getCoffeeIntakeLevelFor:@"todayMinus3"]];
    
    self.todayMinus4DayName.text = [self getWeekDayName:-4];
    self.todayMinus4WaterBar.frame = [self getUpdatedBarFrame:self.todayMinus4WaterBar.frame withFluid:[self getWaterIntakeLevelFor:@"todayMinus4"]];
    self.todayMinus4SoftDrinkBar.frame = [self getUpdatedBarFrame:self.todayMinus4SoftDrinkBar.frame withFluid:[self getSoftDrinkIntakeLevelFor:@"todayMinus4"]];
    self.todayMinus4CoffeeBar.frame = [self getUpdatedBarFrame:self.todayMinus4CoffeeBar.frame withFluid:[self getCoffeeIntakeLevelFor:@"todayMinus4"]];
    
    self.todayMinus5DayName.text = [self getWeekDayName:-5];
    self.todayMinus5WaterBar.frame = [self getUpdatedBarFrame:self.todayMinus5WaterBar.frame withFluid:[self getWaterIntakeLevelFor:@"todayMinus5"]];
    self.todayMinus5SoftDrinkBar.frame = [self getUpdatedBarFrame:self.todayMinus5SoftDrinkBar.frame withFluid:[self getSoftDrinkIntakeLevelFor:@"todayMinus5"]];
    self.todayMinus5CoffeeBar.frame = [self getUpdatedBarFrame:self.todayMinus5CoffeeBar.frame withFluid:[self getCoffeeIntakeLevelFor:@"todayMinus5"]];
    
    self.todayMinus6DayName.text = [self getWeekDayName:-6];
    self.todayMinus6WaterBar.frame = [self getUpdatedBarFrame:self.todayMinus6WaterBar.frame withFluid:[self getWaterIntakeLevelFor:@"todayMinus6"]];
    self.todayMinus6SoftDrinkBar.frame = [self getUpdatedBarFrame:self.todayMinus6SoftDrinkBar.frame withFluid:[self getSoftDrinkIntakeLevelFor:@"todayMinus6"]];
    self.todayMinus6CoffeeBar.frame = [self getUpdatedBarFrame:self.todayMinus6CoffeeBar.frame withFluid:[self getCoffeeIntakeLevelFor:@"todayMinus6"]];
    
    self.todayMinus7DayName.text = [self getWeekDayName:-7];
    self.todayMinus7WaterBar.frame = [self getUpdatedBarFrame:self.todayMinus7WaterBar.frame withFluid:[self getWaterIntakeLevelFor:@"todayMinus7"]];
    self.todayMinus7SoftDrinkBar.frame = [self getUpdatedBarFrame:self.todayMinus7SoftDrinkBar.frame withFluid:[self getSoftDrinkIntakeLevelFor:@"todayMinus7"]];
    self.todayMinus7CoffeeBar.frame = [self getUpdatedBarFrame:self.todayMinus7CoffeeBar.frame withFluid:[self getCoffeeIntakeLevelFor:@"todayMinus7"]];
}

-(CGRect)getUpdatedBarFrame:(CGRect)barFrame withFluid:(double)percent
{
    CGFloat height = 120 * percent;
    if (height<1) {
        height = 2;
    }else if(height > 180){
        height = 179;
    }
    CGRect newFrame = barFrame;
    newFrame.size.height = height;
    newFrame.origin.y = 180 - newFrame.size.height;
    return newFrame;
}

-(double)getWaterIntakeLevelFor:(NSString*)day
{
    NSMutableDictionary *root = [[NSMutableDictionary alloc] initWithDictionary:( [self.lastSevenDays valueForKey:day]) copyItems:YES];
    
    double waterIntake = [[root valueForKey:@"waterIntake"] doubleValue];
    
    NSInteger waterGoal = [[NSUserDefaults standardUserDefaults] integerForKey:@"waterGoal"];
    
    return (waterIntake/waterGoal);
}

-(double)getSoftDrinkIntakeLevelFor:(NSString*)day
{
    NSMutableDictionary *root = [[NSMutableDictionary alloc] initWithDictionary:( [self.lastSevenDays valueForKey:day]) copyItems:YES];
    
    double softDrinkIntake = [[root valueForKey:@"softDrinkIntake"] doubleValue];
    
    NSInteger softDrinkGoal = [[NSUserDefaults standardUserDefaults] integerForKey:@"softDrinkGoal"];
    
    return (softDrinkIntake/softDrinkGoal);
}

-(double)getCoffeeIntakeLevelFor:(NSString*)day
{
    NSMutableDictionary *root = [[NSMutableDictionary alloc] initWithDictionary:( [self.lastSevenDays valueForKey:day]) copyItems:YES];
    
    double coffeeIntake = [[root valueForKey:@"coffeeIntake"] doubleValue];
    
    NSInteger coffeeGoal = [[NSUserDefaults standardUserDefaults] integerForKey:@"coffeeGoal"];
    
    return (coffeeIntake/coffeeGoal);
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

-(NSString*)getWeekDayName:(int) minusDays
{
    NSDate *now = [NSDate date];
    [now descriptionWithLocale:[NSLocale systemLocale]];
    
    NSDateComponents* todayComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
    [todayComponents setDay: minusDays];
    NSDate *previousDay = [[NSCalendar currentCalendar] dateByAddingComponents:todayComponents toDate:now options:0];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    NSString *dayName = [dateFormatter stringFromDate:previousDay];
    
    return [dayName substringWithRange:NSMakeRange(0, 3)];

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
