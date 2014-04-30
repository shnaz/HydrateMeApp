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
-(BOOL)isEverythingFilledOut;

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
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"beenHereBefore"]==nil) {
        //First time app is opened
        
        //Clear the NSUserdefault database just in case..
        [[NSUserDefaults standardUserDefaults] setPersistentDomain:[NSDictionary dictionary] forName:[[NSBundle mainBundle] bundleIdentifier]];
        
        //Disable the LETS DRINK button
        self.drinkButtonOutlet.enabled = NO;
        self.drinkButtonOutlet.backgroundColor = [UIColor grayColor];
        
    } else {
        int userWeight = [[NSUserDefaults standardUserDefaults] integerForKey:@"userWeight"];
        self.weightLabel.text = [NSString stringWithFormat:@"%d KG", userWeight];
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

-(void) updateEverything:(NSNotification *)notification
{
    [self calculateAndShowDailyFluidGoal];
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
    
    self.weightLabel.text = [NSString stringWithFormat:@"%@ KG",[weight stringValue]];
    [self calculateAndShowDailyFluidGoal];
    pickerView.hidden = YES;
}

- (IBAction)weightPickerInvoker:(id)sender {
    
    if (self.weightPicker.isHidden) {
        int selectedRow = 53; //Default selected row in picker
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"userWeight"] != nil)
            selectedRow = [[NSUserDefaults standardUserDefaults] integerForKey:@"userWeight"]-27;
        
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
    if(![self isEverythingFilledOut]){
        return;
    } else {
        UIColor *hydrateMeColor=[UIColor colorWithRed:(49/255.0) green:(139/255.0) blue:(255/255.0) alpha:1.0];
        self.drinkButtonOutlet.enabled = YES;
        self.drinkButtonOutlet.backgroundColor = hydrateMeColor;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger userWeight = [defaults integerForKey:@"userWeight"];
    NSString *gender = [defaults objectForKey:@"userGender"];
    double activityLevel = [defaults doubleForKey:@"activityLevel"];
    double temperatur = 1.0;
    double genderFactor = [gender isEqualToString:@"male"] ? 1.1 : 0.9; //Maybe some other values
    
    int waterGoal= ((((userWeight)-20)*15)+1500)*(activityLevel)*(temperatur)* genderFactor;
    [defaults setInteger:waterGoal forKey:@"waterGoal"];
    self.waterGoalLabel.text = [NSString stringWithFormat:@"%d", waterGoal];
    
    int softDrinkGoal = 500; //maybe another amount i dunno
    [defaults setInteger:softDrinkGoal forKey:@"softDrinkGoal"];
    self.softDrinkGoalLabel.text = [NSString stringWithFormat:@"%d", softDrinkGoal];
    
    int coffeeGoal = 750; //maybe another amount i dunno
    [defaults setInteger:coffeeGoal forKey:@"coffeeGoal"];
    self.coffeeGoalLabel.text = [NSString stringWithFormat:@"%d", coffeeGoal];
    
    [defaults synchronize];
}

//Check if user has chosen gender, weight and activity level
-(BOOL)isEverythingFilledOut
{
    bool isWeightEntered = [[NSUserDefaults standardUserDefaults] objectForKey:@"userWeight"] != nil;
    bool isGenderChosen  = [[NSUserDefaults standardUserDefaults] objectForKey:@"userGender"] != nil;
    bool isActLvlSet     = [[NSUserDefaults standardUserDefaults] objectForKey:@"activityLevel"] != nil;
    
    //NSLog(@"Weight= %u , Gender= %u , Activity= %u ", isWeightEntered,isGenderChosen,isActLvlSet);
    return (isWeightEntered && isGenderChosen && isActLvlSet);
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
    UIColor *selectedButtonColor=[UIColor colorWithRed:(0/255.0) green:(174/255.0) blue:(255/255.0) alpha:1.0];
    UIColor *unselectedButtonColor=[UIColor colorWithRed:(49/255.0) green:(139/255.0) blue:(255/255.0) alpha:1.0];
    UIColor *selectedLabelColor=[UIColor colorWithRed:(51/255.0) green:(51/255.0) blue:(51/255.0) alpha:1.0];
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
        [self.manFigureAction setImage:[UIImage imageNamed:@"manblue_newblue.png"] forState:UIControlStateNormal];
        [self.womanFigureAction setImage:[UIImage imageNamed:@"womanwhite.png"] forState:UIControlStateNormal];
        
    } else if([gender isEqualToString:@"female"]) {
        [self.manFigureAction setImage:[UIImage imageNamed:@"whiteman_newblue.png"] forState:UIControlStateNormal];
        [self.womanFigureAction setImage:[UIImage imageNamed:@"bluewoman_newblue.png"] forState:UIControlStateNormal];
    }
}


#pragma mark - Lets drink button
- (IBAction)drinkButton:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"beenHereBefore"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //Dismiss start screen and return to mainscreen
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
