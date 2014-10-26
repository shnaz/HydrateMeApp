//
//  CoffeeSubViewController.h
//  HydrateMe
//
//  Created by Shafi on 03/04/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoffeeSubViewController : UIViewController
- (IBAction)largeCoffeeButton:(id)sender;
- (IBAction)mediumCoffeeButton:(id)sender;
- (IBAction)smallCoffeeButton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end
