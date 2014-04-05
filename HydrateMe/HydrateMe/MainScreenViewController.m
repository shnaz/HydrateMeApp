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
#import "AppDelegate.h"


@interface MainScreenViewController () <UIScrollViewDelegate>


@end

WaterSubViewController *waterSubViewController;
SoftDrinkSubViewController *softDrinkSubviewController;
CoffeeSubViewController *coffeeSubViewController;

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
    
    [[NSNotificationCenter defaultCenter]
     addObserver: self
     selector: @selector (iCloudChangesImported:)
     name: NSManagedObjectContextObjectsDidChangeNotification
     object: nil];
    
    waterSubViewController = [[WaterSubViewController alloc] init];
    softDrinkSubviewController = [[SoftDrinkSubViewController alloc] init];
    coffeeSubViewController = [[CoffeeSubViewController alloc] init];
    
    // Initializing middle slider
    [self.mainScrollView setContentSize:CGSizeMake(3 * self.mainScrollView.bounds.size.width, self.mainScrollView.bounds.size.height)];
    
    CGRect aFrame = self.mainScrollView.bounds;
    waterSubViewController.view.frame = aFrame;
    [self.mainScrollView addSubview:waterSubViewController.view];
    
    
    aFrame = CGRectOffset(aFrame, self.mainScrollView.bounds.size.width, 0);
    softDrinkSubviewController.view.frame = aFrame;
    [self.mainScrollView addSubview:softDrinkSubviewController.view];
    
    
    aFrame = CGRectOffset(aFrame, self.mainScrollView.bounds.size.width, 0);
    coffeeSubViewController.view.frame = aFrame;
    [self.mainScrollView addSubview:coffeeSubViewController.view];
    

    //SIMON edit
    //Reading the latest userdata from core data
    _currentWaterIntakeLabel.text = @"0";
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    //NSManagedObjectContext
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"UserData"
               inManagedObjectContext:context];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
//   // Results should be in descending order of timeStamp.
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
//
//  
    NSManagedObject *matches = nil;
  
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                                error:&error];
//
    if ([objects count] == 0) {
    _currentWaterIntakeLabel.text = @"N/A";
       } else {
          matches = objects[0];
         _currentWaterIntakeLabel.text =
           [NSString stringWithFormat:@"%@", [matches valueForKey:@"fluidgoal"]];
       }
    
    
//    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
//    [request setEntity:entityDesc];
    
    // Results should be in descending order of timeStamp.
//    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"timeStamp" ascending:NO];
//    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
//    
//    NSArray *results = [managedObjectContext executeFetchRequest:request error:NULL];
//    Entity *latestEntity = [results objectAtIndex:0];
//    
    
    
    
    
}
-(void) iCloudChangesImported:(NSNotification *)notification {
    NSLog(@"Core data changed!!");
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
