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
    
    newEntry.date_time = [NSDate date];
    newEntry.fluit_type = @"water";
    newEntry.fluit_amount = [NSNumber numberWithInt:amount];
    newEntry.temp = [NSNumber numberWithInt:20];
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Failed to save water intake: %@", [error localizedDescription]);
    }

}

@end
