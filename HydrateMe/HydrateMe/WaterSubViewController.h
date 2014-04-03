//
//  WaterSubViewController.h
//  HydrateMe
//
//  Created by Shafi on 03/04/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterSubViewController : UIViewController


- (IBAction)largeWaterButton:(id)sender;
- (IBAction)mediumWaterButton:(id)sender;
- (IBAction)smallWaterButton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end
