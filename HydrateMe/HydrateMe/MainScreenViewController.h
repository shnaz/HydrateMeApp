//
//  MainScreenViewController.h
//  HydrateMe
//
//  Created by Shafi on 02/04/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MainScreenViewController : UIViewController <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *currentWaterIntakeLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *mainPageControl;

@end
