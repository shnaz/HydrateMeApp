//
//  CoffeeSubViewController.m
//  HydrateMe
//
//  Created by Shafi on 03/04/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import "CoffeeSubViewController.h"
#import "LoggingData.h"
#import "AppDelegate.h"

@interface CoffeeSubViewController ()

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)logCoffeeIntakeWithAmount: (int)amount;

@end

@implementation CoffeeSubViewController

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

- (IBAction)largeCoffeeButton:(id)sender {
    [self logCoffeeIntakeWithAmount:350];
}

- (IBAction)mediumCoffeeButton:(id)sender {
    [self logCoffeeIntakeWithAmount:220];
}

- (IBAction)smallCoffeeButton:(id)sender {
    [self logCoffeeIntakeWithAmount:150];
}

# pragma Coffee helper methods

- (void)logCoffeeIntakeWithAmount: (int)amount
{
    LoggingData *newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"LoggingData" inManagedObjectContext:self.managedObjectContext];
    
    newEntry.date_time = [[NSDate alloc] initWithTimeIntervalSinceNow:-(60*60*24*2)]; //debugging purposes

    
    //newEntry.date_time = [NSDate date];
    newEntry.fluit_type = @"coffee";
    newEntry.fluit_amount = [NSNumber numberWithInt:amount];
    newEntry.temp = [NSNumber numberWithInt:20];
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Failed to save water intake: %@", [error localizedDescription]);
    }
    
}


@end
