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

- (IBAction)largeWaterButton:(id)sender {
    
    LoggingData *newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"LoggingData" inManagedObjectContext:self.managedObjectContext];
    
    newEntry.date_time = [NSDate date];
    newEntry.fluit_type = @"water";
    newEntry.fluit_amount = [NSNumber numberWithInt:330];
    newEntry.temp = [NSNumber numberWithInt:20];
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Failed to save loggingData: %@", [error localizedDescription]);
    }
    
    
    //self.testLabel.text = @"500 ml";
}

- (IBAction)mediumWaterButton:(id)sender {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity =
    [NSEntityDescription entityForName:@"LoggingData"
                inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    
    
    NSDate *current = [NSDate date];
    //NSDate *past = [[NSDate alloc] initWithTimeIntervalSinceNow:-60];
    
    
    NSPredicate *predicate =
    [NSPredicate predicateWithFormat:@"date_time < %@", current];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (array != nil) {
        NSUInteger count = [array count]; // May be 0 if the object has been deleted.
        
        NSManagedObject *matche = array[0];
        //self.testLabel.text = @"succes";
        self.testLabel.text = [[matche valueForKey:@"fluit_amount"] stringValue];
    }
    else {
        // Deal with error.
        self.testLabel.text = @"error";
    }
    

    
    //self.testLabel.text = @"330 ml";
}

- (IBAction)smallWaterButton:(id)sender {
    self.testLabel.text = @"200 ml";
}
@end
