//
//  TodayViewController.m
//  HydrateMeQuickInput
//
//  Created by Simon Benfeldt Jørgensen on 26/10/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "LoggingDataNC.h"
//#import "AppDelegate.h"



@interface TodayViewController () <NCWidgetProviding>
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

//- (void)logWaterIntakeWithAmount: (int)amount;
- (void)updateNumberLabelText;

@end

@implementation TodayViewController



- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(userDefaultsDidChange:)
                                                     name:NSUserDefaultsDidChangeNotification
                                                   object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.preferredContentSize = CGSizeMake(320, 55);
    [self updateNumberLabelText];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

- (void)userDefaultsDidChange:(NSNotification *)notification {
    [self updateNumberLabelText];
}

- (void)updateNumberLabelText {
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.uniguld.hydrateme"];
    NSInteger number = [defaults integerForKey:@"MyNumberKey"];
    self.goalLevelLabel.text = [NSString stringWithFormat:@"%d %@", number, @"%"];
}

- (IBAction)glassThreeButtonAction:(id)sender {
     //  [self logWaterIntakeWithAmount:500];
    //[self updateNumberLabelText];
    self.currentFluidAmountLabel.text = @"SIM";
    
}

# pragma Water helper methods

- (void)logWaterIntakeWithAmount: (int)amount
{
//    NSInteger waterIntake = [[NSUserDefaults standardUserDefaults] integerForKey:@"waterIntake"];
//    NSInteger waterGoal =   [[NSUserDefaults standardUserDefaults] integerForKey:@"waterGoal"];
//    
//    if ( (waterIntake+amount) > waterGoal) {
//       // [self warnAgainstWater];
//    }
    
    
    
//    LoggingData *newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"LoggingData" inManagedObjectContext:self.managedObjectContext];
//    
//    NSDate *now = [NSDate date];
//    [now descriptionWithLocale:[NSLocale systemLocale]];
//    
//    newEntry.date_time = now;
//    newEntry.fluit_type = @"water";
//    newEntry.fluit_amount = [NSNumber numberWithInt:amount];
//    newEntry.temp = [NSNumber numberWithInt:20];
//    
//    NSError *error;
//    if (![self.managedObjectContext save:&error]) {
//        NSLog(@"Failed to save water intake: %@", [error localizedDescription]);
//    }
    
    
    
    // Schedule a notification "Remember to drink"
   // [self scheduleNotification];
    
}
@end
