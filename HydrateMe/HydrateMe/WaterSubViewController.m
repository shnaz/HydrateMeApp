//
//  WaterSubViewController.m
//  HydrateMe
//
//  Created by Shafi on 03/04/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import "WaterSubViewController.h"
#import "LoggingData.h"
#import "AppDelegate.h"

@interface WaterSubViewController ()

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)logWaterIntakeWithAmount: (int)amount;
- (void)scheduleNotification;

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
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
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


- (void)scheduleNotification
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    localNotification.fireDate = [self getFireDate];//[NSDate dateWithTimeIntervalSinceNow:15]; // 60*60*3
    localNotification.alertBody = @"Remember to drink";
    localNotification.alertAction = @"Let's drink!";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
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
