//
//  SoftDrinkSubViewController.m
//  HydrateMe
//
//  Created by Shafi on 03/04/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import "SoftDrinkSubViewController.h"
#import "LoggingData.h"
#import "AppDelegate.h"
#import <IBMBluemix/IBMBluemix.h>
#import <IBMData/IBMData.h>

@interface SoftDrinkSubViewController ()

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)logSoftDrinkIntakeWithAmount: (int)amount;
-(void)warnAgainstSoftDrink;

@end

@implementation SoftDrinkSubViewController

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

- (IBAction)largeSoftDrinkButton:(id)sender {
    [self logSoftDrinkIntakeWithAmount:500];
}

- (IBAction)mediumSoftDrinkButton:(id)sender {
    [self logSoftDrinkIntakeWithAmount:330];
}

- (IBAction)smallSoftDrink:(id)sender {
    [self logSoftDrinkIntakeWithAmount:200];
}

# pragma Soft Drink helper methods

- (void)logSoftDrinkIntakeWithAmount: (int)amount
{
    // Warn if too much softdrink is logged
    NSInteger softDrinkIntake = [[NSUserDefaults standardUserDefaults] integerForKey:@"softDrinkIntake"];
    NSInteger softDrinkGoal =   [[NSUserDefaults standardUserDefaults] integerForKey:@"softDrinkGoal"];
    if ( (softDrinkIntake+amount) > softDrinkGoal) {
        [self warnAgainstSoftDrink];
    }
    
    LoggingData *newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"LoggingData" inManagedObjectContext:self.managedObjectContext];
    
    //newEntry.date_time = [[NSDate alloc] initWithTimeIntervalSinceNow:-(60*60*24)]; //debugging purposes
    
    NSDate *now = [NSDate date];
    [now descriptionWithLocale:[NSLocale systemLocale]];
    newEntry.date_time = now;
    newEntry.fluit_type = @"softdrink";
    newEntry.fluit_amount = [NSNumber numberWithInt:amount];
    newEntry.temp = [NSNumber numberWithInt:20];
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Failed to save water intake: %@", [error localizedDescription]);
    }
    
}

-(void)warnAgainstSoftDrink
{
    UIAlertView* dialog = [[UIAlertView alloc] initWithTitle:@"WARNING"
                                                     message:@"Too much softdrink can cause diabetes."
                                                    delegate:self
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
    
    [dialog show];
}

@end
