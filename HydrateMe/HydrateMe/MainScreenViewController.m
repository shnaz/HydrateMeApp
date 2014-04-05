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
    
    [[NSNotificationCenter defaultCenter]
     addObserver: self
     selector: @selector (iCloudChangesImported:)
     name: NSManagedObjectContextObjectsDidChangeNotification
     object: nil];
    
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
