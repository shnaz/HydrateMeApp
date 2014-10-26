//
//  MainScreenViewController.h
//  HydrateMe
//
//  Created by Simon on 02/04/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MainScreenViewController : UIViewController <UIScrollViewDelegate>

- (IBAction)currentWaterIntakeAction:(id)sender;
- (IBAction)settingsButton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *currentWaterDetailedLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentWaterIntakeLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentCoffeeIntakeLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentSoftDrinkIntakeLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *mainPageControl;

@property (weak, nonatomic) IBOutlet UIView *topBarView;

@property (weak, nonatomic) IBOutlet UIView *weatherView;

@end
