//
//  StartScreenViewController.h
//  HydrateMe
//
//  Created by Mads Engels and Simon Benfeldt Jørgensen
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

IBOutlet UIButton *toggleman;
IBOutlet UIButton *womanwhite;

IBOutlet UIButton *lazySelected;
IBOutlet UIButton *mediumSelected;
IBOutlet UIButton *sportySelected;

BOOL toggleIsOnman = NO;
BOOL toggleIsOnwoman = NO;
NSNumber *userWeightGolabal;
NSNumber *userActivityGolabal;
NSNumber * userTemperatureGolabal;


@interface StartScreenViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *mediumButtonOutlet;

@property (weak, nonatomic) IBOutlet UIButton *sportyButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *lazyButtonOutlet;


@property (weak, nonatomic) IBOutlet UITextField *gender_textfield;
@property (weak, nonatomic) IBOutlet UITextField *weight_textfield;
@property (weak, nonatomic) IBOutlet UILabel *change_label;

@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
//@property (strong,nonatomic)         NSArray *weightArray;


@property (weak, nonatomic) IBOutlet UIPickerView *weightPicker;

//- (IBAction)saveData:(id)sender;
//- (IBAction)findData:(id)sender;
//- (IBAction)clearData:(id)sender;

//ACTIVITY BUTTONS
- (IBAction)lazy:(id)sender;
- (IBAction)medium:(id)sender;
- (IBAction)sporty:(id)sender;



- (IBAction)getData:(id)sender;
- (IBAction)blueman:(id)sender;
- (IBAction)whitewoman:(id)sender;



- (IBAction)drinkButton:(id)sender;
//- (IBAction)weightFieldAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *womanwhite;
@property (nonatomic, retain) IBOutlet UIButton *toggleman;
- (IBAction)weightFieldAction2:(id)sender;



@end
