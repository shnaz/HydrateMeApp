//
//  MainScreenViewController.m
//  HydrateMe
//
//  Created by Shafi on 02/04/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import "MainScreenViewController.h"
#import "WaterSubViewController.h"
#import "SoftDrinkSubViewController.h"
#import "CoffeeSubViewController.h"
#import "TopBarViewController.h"
#import "AppDelegate.h"


@interface MainScreenViewController () <UIScrollViewDelegate>

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
- (void)calculateCurrentFluidIntakeLevels;
-(NSDictionary *)getFluidIntakesUntilNow;

@end

WaterSubViewController *waterSubViewController;
SoftDrinkSubViewController *softDrinkSubviewController;
CoffeeSubViewController *coffeeSubViewController;

TopBarViewController *topBarSubViewController;

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
-(void) updateEverything:(NSNotification *)notification
{
    //NSLog(@"New enities added to CoreData!");
    [self calculateCurrentFluidIntakeLevels];
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

- (void)calculateCurrentFluidIntakeLevels
{
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
    
    self.currentWaterIntakeLabel.text = [NSString stringWithFormat:@"%.0f", currentWaterLevel];
    self.currentSoftDrinkIntakeLabel.text = [NSString stringWithFormat:@"%.0f", currentSoftDrinkLevel];
    self.currentCoffeeIntakeLabel.text = [NSString stringWithFormat:@"%.0f", currentCoffeeLevel];
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
