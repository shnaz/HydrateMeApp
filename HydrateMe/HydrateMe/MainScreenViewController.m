//
//  MainScreenViewController.m
//  HydrateMe
//
//  Created by Simon on 02/04/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import "AppDelegate.h"
#import "MainScreenViewController.h"
#import "WaterSubViewController.h"
#import "SoftDrinkSubViewController.h"
#import "CoffeeSubViewController.h"
#import "TopBarViewController.h"
#import "WeatherSubViewController.h"
#import <IBMBluemix/IBMBluemix.h>
#import <IBMData/IBMData.h>


@interface MainScreenViewController () <UIScrollViewDelegate>

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
- (void)calculateCurrentFluidIntakeLevels;
-(int)getWaterIntakeUntilNow;
-(NSDictionary *)getFluidIntakesUntilNow;

@end

WaterSubViewController *waterSubViewController;
SoftDrinkSubViewController *softDrinkSubviewController;
CoffeeSubViewController *coffeeSubViewController;

TopBarViewController *topBarSubViewController;
WeatherSubViewController *weatherSubViewController;

@implementation MainScreenViewController

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
    // Do any additional setup after loading the view.
    
    AppDelegate *appDelegate =[[UIApplication sharedApplication] delegate];
    self.managedObjectContext= [appDelegate managedObjectContext];
    
    // Initializing and adding Topbar view
    topBarSubViewController = [[TopBarViewController alloc] init];
    [self.topBarView addSubview:topBarSubViewController.view];
    
    // Initializing and adding Weather view
    weatherSubViewController = [[WeatherSubViewController alloc] init];
    [self.weatherView addSubview:weatherSubViewController.view];
    
    //Middle slider views init
    waterSubViewController = [[WaterSubViewController alloc] init];
    softDrinkSubviewController = [[SoftDrinkSubViewController alloc] init];
    coffeeSubViewController = [[CoffeeSubViewController alloc] init];
    
    // Initializing middle slider
    [self.mainScrollView setContentSize:CGSizeMake(3 * self.mainScrollView.bounds.size.width, self.mainScrollView.bounds.size.height)];
    
    //Adding subviews to middle slider
    CGRect aFrame = self.mainScrollView.bounds;
    waterSubViewController.view.frame = aFrame;
    [self.mainScrollView addSubview:waterSubViewController.view];
    
    aFrame = CGRectOffset(aFrame, self.mainScrollView.bounds.size.width, 0);
    softDrinkSubviewController.view.frame = aFrame;
    [self.mainScrollView addSubview:softDrinkSubviewController.view];
    
    aFrame = CGRectOffset(aFrame, self.mainScrollView.bounds.size.width, 0);
    coffeeSubViewController.view.frame = aFrame;
    [self.mainScrollView addSubview:coffeeSubViewController.view];
    
    
    //Updating Current intake level
    [self calculateCurrentFluidIntakeLevels];
    
    //Setting a notification center for CoreData
    [[NSNotificationCenter defaultCenter]
     addObserver: self
     selector: @selector (updateEverything:)
     name: NSManagedObjectContextObjectsDidChangeNotification
     object: nil];
    

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"beenHereBefore"]==nil) {
        self.view.hidden = YES;
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"beenHereBefore"]==nil) {
        [self performSegueWithIdentifier:@"settingsScreenSegue" sender:self];
    }
    //Updating Current intake level
    [self calculateCurrentFluidIntakeLevels];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.view.hidden = NO;
}

-(void) updateEverything:(NSNotification *)notification
{
    //NSLog(@"New enities added to CoreData!");
    [self calculateCurrentFluidIntakeLevels];
    [self sentValuesToNotificationCenter];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.mainScrollView.frame.size.width;
    int page = floor((self.mainScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;    
    self.mainPageControl.currentPage = page;

}


- (void)sentValuesToNotificationCenter
{
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.uniguld.hydrateme"];
    
    NSInteger perCentage =[self getWaterIntakeUntilNow];
    
    [sharedDefaults setInteger:perCentage forKey:@"MyNumberKey"];
    [sharedDefaults synchronize];   // (!!) This is crucial.
}

- (void)calculateCurrentFluidIntakeLevels
{
    if (self.view.window == nil)
        return;
    
    
    NSDictionary *fluidIntakeSoFar = [self getFluidIntakesUntilNow];
    float waterIntake =     [[fluidIntakeSoFar objectForKey:@"waterIntake"] floatValue];
    float softDrinkIntake = [[fluidIntakeSoFar objectForKey:@"softDrinkIntake"] floatValue];
    float coffeeIntake =    [[fluidIntakeSoFar objectForKey:@"coffeeIntake"] floatValue];
    
    float waterGoal =       [[NSUserDefaults standardUserDefaults] integerForKey:@"waterGoal"];
    float softDrinkGoal =   [[NSUserDefaults standardUserDefaults] integerForKey:@"softDrinkGoal"];
    float coffeeGoal =      [[NSUserDefaults standardUserDefaults] integerForKey:@"coffeeGoal"];
    
    float currentWaterLevel = (waterIntake/waterGoal)*100;
    float currentSoftDrinkLevel = (softDrinkIntake/softDrinkGoal)*100;
    float currentCoffeeLevel = (coffeeIntake/coffeeGoal)*100;
    
    self.currentWaterIntakeLabel.text = [NSString stringWithFormat:@"%.0f%%",
                                         (isnan(currentWaterLevel) ? 0.0 : currentWaterLevel) ];
    self.currentSoftDrinkIntakeLabel.text = [NSString stringWithFormat:@"%.0f%%",
                                             (isnan(currentSoftDrinkLevel) ? 0.0 : currentSoftDrinkLevel) ];
    self.currentCoffeeIntakeLabel.text = [NSString stringWithFormat:@"%.0f%%",
                                          (isnan(currentCoffeeLevel) ? 0.0 : currentCoffeeLevel) ];
    self.currentWaterDetailedLabel.text = [NSString stringWithFormat:@"%0.0f/%0.0f", waterIntake, waterGoal];
    
    [[NSUserDefaults standardUserDefaults] setInteger:waterIntake forKey:@"waterIntake"];
    [[NSUserDefaults standardUserDefaults] setInteger:softDrinkIntake forKey:@"softDrinkIntake"];
    [[NSUserDefaults standardUserDefaults] setInteger:coffeeIntake forKey:@"coffeeIntake"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


-(NSDictionary *)getFluidIntakesUntilNow
{
    int waterIntakeUntilNow=0;
    int coffeeIntakeUntilNow=0;
    int softDrinkIntakeUntilNow = 0;
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
    [components setHour:00];
    NSDate *today00AM = [calendar dateFromComponents:components];
    
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity =
    [NSEntityDescription entityForName:@"LoggingData"
                inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    
    NSPredicate *predicate =
    [NSPredicate predicateWithFormat:@"(date_time > %@) && (date_time < %@)", today00AM, now];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
    //NSLog(@"%@",[array description]);
    if (array == nil) {
        NSLog(@"Fetch water logging data failed");
    }
    else {
        for (NSManagedObject *logData in array) {
            NSString *fluidType = [logData valueForKey:@"fluit_type"];
            if ([fluidType isEqualToString:@"water"]) {
                int fluidAmount = [[logData valueForKey:@"fluit_amount"] intValue];
                waterIntakeUntilNow += fluidAmount;
            }else if ([fluidType isEqualToString:@"softdrink"]) {
                int fluidAmount = [[logData valueForKey:@"fluit_amount"] intValue];
                softDrinkIntakeUntilNow += fluidAmount;
            }else{
                int fluidAmount = [[logData valueForKey:@"fluit_amount"] intValue];
                coffeeIntakeUntilNow += fluidAmount;
            }
        }

    }
    
    return [[NSDictionary alloc] initWithObjectsAndKeys:
            [NSNumber numberWithInt: waterIntakeUntilNow], @"waterIntake",
            [NSNumber numberWithInt: softDrinkIntakeUntilNow], @"softDrinkIntake",
            [NSNumber numberWithInt: coffeeIntakeUntilNow], @"coffeeIntake",
            nil];;
}


-(int)getWaterIntakeUntilNow
{
    
    
    NSDictionary *fluidIntakeSoFar = [self getFluidIntakesUntilNow];
    float waterIntake =     [[fluidIntakeSoFar objectForKey:@"waterIntake"] floatValue];

    
    float waterGoal =       [[NSUserDefaults standardUserDefaults] integerForKey:@"waterGoal"];
   
    
    float currentWaterLevel = (waterIntake/waterGoal)*100;
    int myInt = (int) currentWaterLevel;

    
    return myInt;
}

//This switches between the two label, percentage and detailed
- (IBAction)currentWaterIntakeAction:(id)sender
{
    self.currentWaterDetailedLabel.hidden = !self.currentWaterDetailedLabel.hidden;
    self.currentWaterIntakeLabel.hidden = !self.currentWaterIntakeLabel.hidden;
}

//This navigates to 'startScreen'
- (IBAction)settingsButton:(id)sender
{
    [self performSegueWithIdentifier:@"settingsScreenSegue" sender:self];

}


@end
