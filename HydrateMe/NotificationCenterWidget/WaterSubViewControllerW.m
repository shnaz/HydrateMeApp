//
//  WaterSubViewController.m
//  HydrateMe
//
//  Created by Shafi on 03/04/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import "WaterSubViewControllerW.h"
#import "LoggingData.h"
#import "AppDelegate.h"
//#import <IBMBluemix/IBMBluemix.h>
//#import <IBMData/IBMData.h>

@interface WaterSubViewController ()

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)logWaterIntakeWithAmount: (int)amount;
- (void)scheduleNotification;
//-(void)warnAgainstWater;

@end

@implementation WaterSubViewController

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
    // Do any additional setup after loading the view from its nib.
    
//    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
  //  self.managedObjectContext = appDelegate.managedObjectContext;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)largeWaterButton:(id)sender
{
    [self logWaterIntakeWithAmount:500];
}

- (IBAction)mediumWaterButton:(id)sender
{
    [self logWaterIntakeWithAmount:330];
}

- (IBAction)smallWaterButton:(id)sender
{
    [self logWaterIntakeWithAmount:200];
}


# pragma Water helper methods

- (void)logWaterIntakeWithAmount: (int)amount
{
    NSInteger waterIntake = [[NSUserDefaults standardUserDefaults] integerForKey:@"waterIntake"];
    NSInteger waterGoal =   [[NSUserDefaults standardUserDefaults] integerForKey:@"waterGoal"];

    if ( (waterIntake+amount) > waterGoal) {
      //  [self warnAgainstWater];
    }
    
    LoggingData *newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"LoggingData" inManagedObjectContext:self.managedObjectContext];
    
    NSDate *now = [NSDate date];
    [now descriptionWithLocale:[NSLocale systemLocale]];
    
    newEntry.date_time = now;
    newEntry.fluit_type = @"water";
    newEntry.fluit_amount = [NSNumber numberWithInt:amount];
    newEntry.temp = [NSNumber numberWithInt:20];
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Failed to save water intake: %@", [error localizedDescription]);
    }
    
    // Schedule a notification "Remember to drink"
    [self scheduleNotification];

}




-(NSDate*)getFireDate
{
    NSDate *now =[NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
    [components setHour:21];
    [components setMinute:00];
    
    NSDate *nineoClockToday = [calendar dateFromComponents:components];
    NSDate *sixoClockTomorrow = [nineoClockToday dateByAddingTimeInterval:(60*60*9)];
    NSDate *notificationTime = [NSDate dateWithTimeIntervalSinceNow:(60*60*3)]; // 60*60*3
    
    if ( [notificationTime timeIntervalSince1970] > [nineoClockToday timeIntervalSince1970] )
        return sixoClockTomorrow;
    
    return notificationTime;
}



@end
