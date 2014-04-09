//
//  StartScreenViewController.h
//  HydrateMe
//
//  Created by Mads Engels and Simon Benfeldt Jørgensen
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface StartScreenViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

// Man-Woman Figures
- (IBAction)manFigureAction:(id)sender;
- (IBAction)womanFigureAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *womanFigureAction;
@property (nonatomic, retain) IBOutlet UIButton *manFigureAction;

// Weight picker
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *weightPicker;
- (IBAction)weightPickerInvoker:(id)sender;

//Activity level
- (IBAction)lazyButtonAction:(id)sender;
- (IBAction)mediumButtonAction:(id)sender;
- (IBAction)sportyButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *mediumButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *sportyButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *lazyButtonOutlet;

// Fluid goal label
@property (weak, nonatomic) IBOutlet UILabel *waterGoalLabel;
@property (weak, nonatomic) IBOutlet UILabel *coffeeGoalLabel;
@property (weak, nonatomic) IBOutlet UILabel *softDrinkGoalLabel;

// Final Lets Drink button
- (IBAction)drinkButton:(id)sender;


@end
