//
//  TopBarViewController.m
//  HydrateMe
//
//  Created by Shafi on 09/04/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import "TopBarViewController.h"
#import "AppDelegate.h"

@interface TopBarViewController ()

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
-(int)getWaterIntakeUntilNow;
-(void)updateBarIndicatorPosition;

@end

@implementation TopBarViewController

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
    
    //Update hydration bar
    [self updateBarIndicatorPosition];
    
    //Setting a notification center for CoreData
    [[NSNotificationCenter defaultCenter]
     addObserver: self
     selector: @selector (updatePositionOfMan:)
     name: NSManagedObjectContextObjectsDidChangeNotification
     object: nil];
    NSLog(@"viewDidLoad!");

}

-(void)viewDidAppear:(BOOL)animated
{
    //Update hydration bar
    [self updateBarIndicatorPosition];
        NSLog(@"viewDidAppear!");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) updatePositionOfMan:(NSNotification *)notification
{
    [self updateBarIndicatorPosition];
    
    NSLog(@"Inside top bar!");
}

-(void)updateBarIndicatorPosition
{
    float periodWaterGoal = 500.0; //water goal for the 3 hours period
    
    float newX =  self.view.frame.size.width*([self getWaterIntakeUntilNow]/periodWaterGoal);
    if(newX > self.view.frame.size.width)
        newX =  self.view.frame.size.width-self.manOnBar.frame.size.width;

    /*
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self.manOnBar setFrame:CGRectMake(newX, self.manOnBar.frame.origin.y, self.manOnBar.frame.size.width, self.manOnBar .frame.size.height)];
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Moved to pos: %f", newX);
                     }];
     */
    
    [self.manOnBar setFrame:CGRectMake(newX, self.manOnBar.frame.origin.y, self.manOnBar.frame.size.width, self.manOnBar.frame.size.height)];
    
}

-(int)getWaterIntakeUntilNow
{
    int waterIntakeUntilNow=1;

    NSDate *now = [NSDate date];
    NSDate *fourHoursAgo = [[NSDate alloc] initWithTimeIntervalSinceNow:-(60*2)]; // (60*60*3)
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity =
    [NSEntityDescription entityForName:@"LoggingData"
                inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    
    NSPredicate *predicate =
    [NSPredicate predicateWithFormat:@"(date_time > %@) && (date_time < %@)", fourHoursAgo, now];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (array == nil) {
        NSLog(@"Fetch water logging data failed");
    }
    else {
        for (NSManagedObject *logData in array) {
            NSString *fluidType = [logData valueForKey:@"fluit_type"];
            if ([fluidType isEqualToString:@"water"]) {
                int fluidAmount = [[logData valueForKey:@"fluit_amount"] intValue];
                waterIntakeUntilNow += fluidAmount;
            }
        }
        
    }
    
    return waterIntakeUntilNow;
}






@end
