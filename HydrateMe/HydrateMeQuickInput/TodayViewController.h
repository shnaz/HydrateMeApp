//
//  TodayViewController.h
//  HydrateMeQuickInput
//
//  Created by Simon Benfeldt Jørgensen on 26/10/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *goalLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentFluidAmountLabel;
@property (weak, nonatomic) IBOutlet UIButton *glassThreeButton;

- (IBAction)glassThreeButtonAction:(id)sender;

@end
