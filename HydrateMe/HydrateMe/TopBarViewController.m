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
    
    //Initializing managedObjectContext to be able to use Core data
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    //Setting a notification center for CoreData
    [[NSNotificationCenter defaultCenter]
     addObserver: self
     selector: @selector (updatePositionOfMan:)
     name: NSManagedObjectContextObjectsDidChangeNotification
     object: nil];
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    //Update manOnBar's position
    [self updateBarIndicatorPosition];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Change manOnBar's position with animation
-(void) updatePositionOfMan:(NSNotification *)notification
{
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self updateBarIndicatorPosition];
                     }
                     completion:^(BOOL finished){
                     }];
    
}

//Changes manOnBar's position without animation
-(void)updateBarIndicatorPosition
{
    float periodWaterGoal = 500.0; //water goal for the 3 hours period
    
    float newX =  self.view.frame.size.width*([self getWaterIntakeUntilNow]/periodWaterGoal);
    if(newX > self.view.frame.size.width)
        newX =  self.view.frame.size.width-self.manOnBar.frame.size.width;
    
    [self.manOnBar setFrame:CGRectMake(newX, self.manOnBar.frame.origin.y, self.manOnBar.frame.size.width, self.manOnBar.frame.size.height)];
}

-(int)getWaterIntakeUntilNow
{
    int waterIntakeUntilNow=1;
    
    NSDate *now = [NSDate date];
    NSDate *fourHoursAgo = [[NSDate alloc] initWithTimeIntervalSinceNow:-(60*60*3)];//3hours=(60*60*3)
    
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
