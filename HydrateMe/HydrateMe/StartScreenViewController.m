//
//  StartScreenViewController.m
//  HydrateMe
//
//  Created by Mads Engels on 4/2/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import "StartScreenViewController.h"

@interface StartScreenViewController ()

-(void)calculateAndShowDailyFluidGoal;
-(void)updateGenderImageSelection;
-(void)updateActivityButtonSelection;

@end

@implementation StartScreenViewController


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
    
    //[self.weightPicker setHidden:YES];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"beenHereBefore"]==nil) {
        //first time app is used
        //MAYBE DELETE below instead use isEverythingFilledOut to figure out if everything is filled out
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"male" forKey:@"userGender"];
        [defaults setInteger:80 forKey:@"userWeight"];
        [defaults setDouble:0.0 forKey:@"activityLevel"];
        [defaults synchronize];
        
    } else {
        int userWeight = [[NSUserDefaults standardUserDefaults] integerForKey:@"userWeight"];
        self.weightLabel.text = [NSString stringWithFormat:@"%d", userWeight];
        [self.weightPicker selectRow:(userWeight-27) inComponent:0 animated:YES];
        
        [self updateActivityButtonSelection];
        [self updateGenderImageSelection];
    }
    
    [self calculateAndShowDailyFluidGoal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PickerView
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 100;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSNumber *weight = [NSNumber numberWithInt:row + 27];
    
    
    NSString *title = [weight stringValue];
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    return attString;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSNumber *weight = [NSNumber numberWithInt:row + 27];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:[weight integerValue] forKey:@"userWeight"];
    [defaults synchronize];
    
    self.weightLabel.text = [weight stringValue];
    [self calculateAndShowDailyFluidGoal];
    pickerView.hidden = YES;
}

- (IBAction)weightPickerInvoker:(id)sender {
    
    if (self.weightPicker.isHidden) {
        int selectedRow = [[NSUserDefaults standardUserDefaults] integerForKey:@"userWeight"]-27;
        [self.weightPicker selectRow:selectedRow inComponent:0 animated:YES];
        
        [self.weightPicker setHidden:NO];
    } else {
        [self.weightPicker setHidden:YES];
        
        [self calculateAndShowDailyFluidGoal];
    }
}

#pragma mark - Daily fluid goal calculation method

-(void)calculateAndShowDailyFluidGoal
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger userWeight = [defaults integerForKey:@"userWeight"];
    NSString *gender = [defaults objectForKey:@"userGender"];
    double activityLevel = [defaults doubleForKey:@"activityLevel"];
    double temperatur = 1.0;
    double genderFactor = [gender isEqualToString:@"male"] ? 1.3 : 1.0; //Maybe some other values
    
    int waterGoal= ((((userWeight)-20)*15)+1500)*(activityLevel)*(temperatur)* genderFactor;
    [defaults setInteger:waterGoal forKey:@"waterGoal"];
    self.waterGoalLabel.text = [NSString stringWithFormat:@"%d", waterGoal];
    
    int softDrinkGoal = 500; //maybe another amount i dunno
    [defaults setInteger:softDrinkGoal forKey:@"softDrinkGoal"];//fix amount
    self.softDrinkGoalLabel.text = [NSString stringWithFormat:@"%d", softDrinkGoal];
    
    int coffeeGoal = 750; //maybe another amount i dunno
    [defaults setInteger:coffeeGoal forKey:@"coffeeGoal"];
    self.coffeeGoalLabel.text = [NSString stringWithFormat:@"%d", coffeeGoal];
    
    [defaults synchronize];
}

//IMPLEMENT THIS and use it to see if everything is filled out before the lets drink button can be clicked
//
-(bool)isEverythingFilledOut
{
    
    return true;
}


#pragma mark - Activity buttons

- (IBAction)lazyButtonAction:(id)sender {
    [[NSUserDefaults standardUserDefaults] setDouble:1.0 forKey:@"activityLevel"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self calculateAndShowDailyFluidGoal];
    [self updateActivityButtonSelection];
}

- (IBAction)mediumButtonAction:(id)sender {
    [[NSUserDefaults standardUserDefaults] setDouble:1.2 forKey:@"activityLevel"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self calculateAndShowDailyFluidGoal];
    [self updateActivityButtonSelection];
}

- (IBAction)sportyButtonAction:(id)sender {
    [[NSUserDefaults standardUserDefaults] setDouble:1.4 forKey:@"activityLevel"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self calculateAndShowDailyFluidGoal];
    [self updateActivityButtonSelection];
}

-(void)updateActivityButtonSelection
{
    UIColor *selectedButtonColor=[UIColor colorWithRed:(41/255.0) green:(128/255.0) blue:(185/255.0) alpha:1.0];
    UIColor *unselectedButtonColor=[UIColor colorWithRed:(52/255.0) green:(152/255.0) blue:(219/255.0) alpha:1.0];
    UIColor *selectedLabelColor=[UIColor colorWithRed:(40/255.0) green:(80/255.0) blue:(110/255.0) alpha:1.0];
    UIColor *unselectedLabelColor=[UIColor whiteColor];
    
    [self.lazyButtonOutlet setTitleColor:unselectedLabelColor forState:UIControlStateNormal];
    self.lazyButtonOutlet.backgroundColor = unselectedButtonColor;
    [self.mediumButtonOutlet setTitleColor:unselectedLabelColor forState:UIControlStateNormal];
    self.mediumButtonOutlet.backgroundColor = unselectedButtonColor;
    [self.sportyButtonOutlet setTitleColor:unselectedLabelColor forState:UIControlStateNormal];
    self.sportyButtonOutlet.backgroundColor = unselectedButtonColor;
    
    double activityLevel = [[NSUserDefaults standardUserDefaults] doubleForKey:@"activityLevel"];
    if (activityLevel == 1.0) {
        [self.lazyButtonOutlet setTitleColor:selectedLabelColor forState:UIControlStateNormal];
        self.lazyButtonOutlet.backgroundColor = selectedButtonColor;
    } else if(activityLevel == 1.2) {
        [self.mediumButtonOutlet setTitleColor:selectedLabelColor forState:UIControlStateNormal];
        self.mediumButtonOutlet.backgroundColor = selectedButtonColor;
    } else{
        [self.sportyButtonOutlet setTitleColor:selectedLabelColor forState:UIControlStateNormal];
        self.sportyButtonOutlet.backgroundColor = selectedButtonColor;
    }
}

#pragma mark - Gender Selection

- (IBAction)manFigureAction:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:@"male" forKey:@"userGender"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self updateGenderImageSelection];
    [self calculateAndShowDailyFluidGoal];
}

- (IBAction)womanFigureAction:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:@"female" forKey:@"userGender"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [self updateGenderImageSelection];
    [self calculateAndShowDailyFluidGoal];
}

-(void)updateGenderImageSelection
{
    NSString *gender = [[NSUserDefaults standardUserDefaults] objectForKey:@"userGender"];
    if ([gender isEqualToString:@"male"]) {
        [self.manFigureAction setImage:[UIImage imageNamed:@"manblue.png"] forState:UIControlStateNormal];
        [self.womanFigureAction setImage:[UIImage imageNamed:@"womanwhite.png"] forState:UIControlStateNormal];
        
    } else if([gender isEqualToString:@"female"]) {
        [self.manFigureAction setImage:[UIImage imageNamed:@"manwhite.png"] forState:UIControlStateNormal];
        [self.womanFigureAction setImage:[UIImage imageNamed:@"womanblue.png"] forState:UIControlStateNormal];
    }
}


#pragma mark - Lets drink button
- (IBAction)drinkButton:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"beenHereBefore"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //GO TO NEXT VIEW
    
}


@end
