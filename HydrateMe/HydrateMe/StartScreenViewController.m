//
//  StartScreenViewController.m
//  HydrateMe
//
//  Created by Simon on 4/2/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import "StartScreenViewController.h"

@interface StartScreenViewController ()

-(void)calculateAndShowDailyFluidGoal;
-(void)updateGenderImageSelection;
-(void)updateActivityButtonSelection;
-(void)updateToogles;
-(void)checkWeightUnits;
-(BOOL)isEverythingFilledOut;
-(int)weightUnitConversion: (int)euWeightInput;
-(int)fluidUnitConversion: (int)euFluidtInput;


@end

@implementation StartScreenViewController
@synthesize weightUnits;
@synthesize fluidUnits;


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
        
        [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"usweightunit"];
        [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"usfluidunit"];
        
        //Clear the NSUserdefault database just in case..
        [[NSUserDefaults standardUserDefaults] setPersistentDomain:[NSDictionary dictionary] forName:[[NSBundle mainBundle] bundleIdentifier]];
        
        //Disable the LETS DRINK button
        self.drinkButtonOutlet.enabled = NO;
        self.drinkButtonOutlet.backgroundColor = [UIColor grayColor];
        
        //[[NSUserDefaults standardUserDefaults] setInteger:20 forKey:@"temperature"];
        //[[NSUserDefaults standardUserDefaults] synchronize];
        
    } else {
        int userWeight = [[NSUserDefaults standardUserDefaults] integerForKey:@"userWeight"];
        
        
        self.weightLabel.text = [NSString stringWithFormat:@"%d KG", userWeight];
        [self.weightPicker selectRow:(userWeight-20) inComponent:0 animated:YES];
        
        [self updateToogles];
        [self checkWeightUnits];
        
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
    return 200;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSNumber *weight = [NSNumber numberWithInt:row + 20];
    
    
    
    NSString *title = [weight stringValue];
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger userWeight = [defaults integerForKey:@"userWeight"];
    NSNumber *userWeightAsNumber =  [NSNumber numberWithInt:userWeight];
    NSString *usUnit = [defaults objectForKey:@"usweightunit"];
    NSNumber *weightConverted = [NSNumber numberWithInt:[self weightUnitConversion:[userWeightAsNumber integerValue]]];
    if ([usUnit  isEqual:  @"yes"]) {
        
        NSNumber *weight = [NSNumber numberWithInt:row*2 + 20];
        
        NSNumber *weightToKgTemp = [NSNumber numberWithInt:(row*2)/2.2046 + 20];
        [defaults setInteger:[weightToKgTemp integerValue] forKey:@"userWeight"];
        NSInteger userWeight = [defaults integerForKey:@"userWeight"];
        userWeightAsNumber =  [NSNumber numberWithInt:userWeight];
        weightConverted = [NSNumber numberWithInt:[self weightUnitConversion:[userWeightAsNumber integerValue]]];
      
     

        
        title = [weight stringValue];
        attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        self.weightLabel.text = [NSString stringWithFormat:@"%@ lbs",[weightConverted stringValue]];
        return attString;
    }
    
    if ([usUnit  isEqual:  @"no"]) {
        title = [weight stringValue];
        attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        self.weightLabel.text = [NSString stringWithFormat:@"%@ KG",[userWeightAsNumber stringValue]];
        return attString;
    }
    
    
    
    
    
    return attString;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSNumber *weight = [NSNumber numberWithInt:row + 20];
    
  
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:[weight integerValue] forKey:@"userWeight"];
    [defaults synchronize];
    
      //FOR UNIT CALCULATIONS
    
    
    [self checkWeightUnits];
    
    [self calculateAndShowDailyFluidGoal];
    pickerView.hidden = YES;
}

- (IBAction)weightPickerInvoker:(id)sender {
    
    if (self.weightPicker.isHidden) {
        int selectedRow = 60; //Default selected row in picker
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"userWeight"] != nil)
            selectedRow = [[NSUserDefaults standardUserDefaults] integerForKey:@"userWeight"]-20;
        
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
    NSInteger temperature = [defaults integerForKey:@"temperature"];
    double temperatureFactor = (((temperature-20)>0 ? (temperature-20) : 0)+100.0)/100.0 ;
    double genderFactor = [gender isEqualToString:@"male"] ? 1.1 : 0.9; //Maybe some other values
    
    NSLog(@"StartScreen Temp=%d",temperature);

    
    int waterGoal= ((((userWeight)-20)*15)+1500)*(activityLevel)*(temperatureFactor)* genderFactor;
    
    //int waterGoalConv = [self fluidUnitConversion:waterGoal];
    
    [defaults setInteger:waterGoal forKey:@"waterGoal"];
    self.waterGoalLabel.text = [NSString stringWithFormat:@"%d mL" , waterGoal];
    
    int softDrinkGoal = 500; //maybe another amount i dunno
    [defaults setInteger:softDrinkGoal forKey:@"softDrinkGoal"];
   // self.softDrinkGoalLabel.text = [NSString stringWithFormat:@"%d", softDrinkGoal];
    
    int coffeeGoal = 750; //maybe another amount i dunno
    [defaults setInteger:coffeeGoal forKey:@"coffeeGoal"];
    //self.coffeeGoalLabel.text = [NSString stringWithFormat:@"%d", coffeeGoal];
    [self checkFluidUnits];
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


-(void)updateToogles
{
    NSString *weightUnit = [[NSUserDefaults standardUserDefaults] objectForKey:@"usweightunit"];
    if ([weightUnit isEqualToString:@"yes"]) {
        self.weightUnits.selectedSegmentIndex=1;
        
    } else if([weightUnit isEqualToString:@"no"]) {
        self.weightUnits.selectedSegmentIndex=0;
    }
    
    NSString *fluidUnit = [[NSUserDefaults standardUserDefaults] objectForKey:@"usfluidunit"];
    if ([fluidUnit isEqualToString:@"yes"]) {
        self.fluidUnits.selectedSegmentIndex=0;
        
    } else if([fluidUnit isEqualToString:@"no"]) {
        self.fluidUnits.selectedSegmentIndex=1;
    }
    
    
}




-(void)checkWeightUnits

{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger userWeight = [defaults integerForKey:@"userWeight"];
    NSNumber *userWeightAsNumber =  [NSNumber numberWithInt:userWeight];
    NSString *usUnit = [defaults objectForKey:@"usweightunit"];
      NSNumber *weightConverted = [NSNumber numberWithInt:[self weightUnitConversion:[userWeightAsNumber integerValue]]];
    if ([usUnit  isEqual:  @"yes"]) {
      
        self.weightLabel.text = [NSString stringWithFormat:@"%@ lbs",[weightConverted stringValue]];
    }
    
    if ([usUnit  isEqual:  @"no"]) {
        
        self.weightLabel.text = [NSString stringWithFormat:@"%@ KG",[userWeightAsNumber stringValue]];
    }

    
}

-(void)checkFluidUnits
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     NSString *usFluidUnit = [defaults objectForKey:@"usfluidunit"];
    NSInteger waterGoal = [defaults integerForKey:@"waterGoal"];

    if ([usFluidUnit  isEqual:  @"no"]) {
        
        int waterGoalConverted = [self fluidUnitConversion:waterGoal];
     
       
        self.waterGoalLabel.text = [NSString stringWithFormat:@"%d" , waterGoalConverted];
        
        
    }
    
    if ([usFluidUnit  isEqual:  @"yes"]) {
        
      self.waterGoalLabel.text = [NSString stringWithFormat:@"%d" , waterGoal];
    }
    
}



-(int)weightUnitConversion: (int)euWeightInput
{

    int returnInt = euWeightInput *2.2046;
    return returnInt;
}

-(int)fluidUnitConversion: (int)euFluidtInput
{

    int returnInt = euFluidtInput * 0.0338140227018;
    return returnInt;
}




#pragma mark - Lets drink button
- (IBAction)drinkButton:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"beenHereBefore"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //Dismiss start screen and return to mainscreen
    [self dismissViewControllerAnimated:YES completion:nil];
    
}





-(IBAction)weightUnitAction:(UISegmentedControl *)sender
{
    switch (self.weightUnits.selectedSegmentIndex)
    {
        case 0:
            [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"usweightunit"];
            
            
           [self checkWeightUnits];
            break;
        case 1:
            [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"usweightunit"];
          [self checkWeightUnits];
            break;
        default: 
            break; 
    } 
}

-(IBAction)fluidUnitAction:(UISegmentedControl *)sender
{
    switch (self.fluidUnits.selectedSegmentIndex)
    {
        case 0:
            [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"usfluidunit"];
            
            
            [self calculateAndShowDailyFluidGoal];
           
            
            break;
        case 1:
            [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"usfluidunit"];
            
            [self calculateAndShowDailyFluidGoal];
            
            //  self.textLabel.text = @"Second Segment selected";
            break;
        default:
            [self checkFluidUnits];
            break;
    }
}
@end
