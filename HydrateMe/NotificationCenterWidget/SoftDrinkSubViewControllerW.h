//
//  SoftDrinkSubViewController.h
//  HydrateMe
//
//  Created by Shafi on 03/04/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SoftDrinkSubViewController : UIViewController

- (IBAction)largeSoftDrinkButton:(id)sender;
- (IBAction)mediumSoftDrinkButton:(id)sender;
- (IBAction)smallSoftDrink:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end
