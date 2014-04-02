//
//  StartScreenViewController.m
//  HydrateMe
//
//  Created by Mads Engels on 4/2/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import "StartScreenViewController.h"
#define selectedButtonColor [UIColor colorWithRed:(41/255.0) green:(128/255.0) blue:(185/255.0) alpha:1.0]
#define unselectedButtonColor [UIColor colorWithRed:(52/255.0) green:(152/255.0) blue:(219/255.0) alpha:1.0]
#define selectedLabelColor [UIColor colorWithRed:(52/255.0) green:(73/255.0) blue:(94/255.0) alpha:1.0]
#define unselectedLabelColor [UIColor whiteColor]

@interface StartScreenViewController ()
-(int)calculateDailyHydrationLevel: (int) userWeight activityLevelaug:(double)activityLevel environmentLevelaug:(double)enviromentLevel;


@end

NSInteger selectedRow = 53;
NSString *actlevel = @"medium";


//[UIColor colorWithRed:(255/255.0) green:(0/255.0) blue:(0/255.0) alpha:1]




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
    userWeightGolabal = [NSNumber numberWithInt:80];
    userActivityGolabal =[NSNumber numberWithInt:1.2];
    userTemperatureGolabal=[NSNumber numberWithInt:1];
	// Do any additional setup after loading the view.
    
    [self.weightPicker setHidden:YES];
    
    userActivityGolabal =[NSNumber numberWithDouble:1.2];
    int daily = [self calculateDailyHydrationLevel:[userWeightGolabal intValue] activityLevelaug:[userActivityGolabal doubleValue] environmentLevelaug:[userTemperatureGolabal doubleValue]];
    NSString *dayW = [NSString stringWithFormat:@"%d", daily];
    _change_label.text = dayW;
    
    
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
    NSLog(@"Selected row %d",row);
    
    selectedRow = row;
    
    
    NSNumber *weight = [NSNumber numberWithInt:row + 27];
    self.weightLabel.text = [weight stringValue];
    userWeightGolabal = weight;
    
}

-(int)calculateDailyHydrationLevel: (int) userWeight activityLevelaug:(double)activityLevel environmentLevelaug:(double)enviromentLevel
{
    return ((((userWeight)-20)*15)+1500)*(activityLevel)*(enviromentLevel);
}



- (IBAction)saveData:(id)sender {
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    NSManagedObject *newContact;
    newContact = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Contacts"
                  inManagedObjectContext:context];
    [newContact setValue: _weight_textfield.text forKey:@"weight"];
    [newContact setValue: _gender_textfield.text forKey:@"gender"];
    [newContact setValue: [NSDate date] forKey:@"log_date"];
    _weight_textfield.text = @"";
    _gender_textfield.text = @"";
    NSError *error;
    [context save:&error];
    _change_label.text = @"Contact saved";
}


- (IBAction)findData:(id)sender {
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"Contacts"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSPredicate *pred =
    [NSPredicate predicateWithFormat:@"(weight = %@)",
     _weight_textfield.text];
    [request setPredicate:pred];
    NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    if ([objects count] == 0) {
        _change_label.text = @"No matches";
    } else {
        matches = objects[0];
        _weight_textfield.text = [matches valueForKey:@"weight"];
        _gender_textfield.text = [matches valueForKey:@"gender"];
        //_change_label.text =  @"test2";
        _change_label.text = [NSString stringWithFormat:
                              @"Logged date: %@", [matches valueForKey:@"log_date"]];
    }
}

- (IBAction)clearData:(id)sender {
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"Contacts"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSPredicate *pred =
    [NSPredicate predicateWithFormat:@"(weight = %@)",
     _weight_textfield.text];
    [request setPredicate:pred];
    NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    if ([objects count] == 0) {
        _change_label.text = @"No matches";
    } else {
        matches = objects[0];
        _weight_textfield.text = [NSString stringWithFormat:@"Deleted: %@", [matches valueForKey:@"weight"]];
        _gender_textfield.text = [matches valueForKey:@"gender"];
        
        [context deleteObject:matches];
        
        _change_label.text = [NSString stringWithFormat:
                              @"%lu matches found", (unsigned long)[objects count]];
    }
    
    
}



- (IBAction)getData:(id)sender {
    
    NSDate *current = [NSDate date];
    NSDate *past = [[NSDate alloc] initWithTimeIntervalSinceNow:-60];
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"Contacts"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(log_date > %@) && (log_date < %@)",past,current];
    [request setPredicate:pred];
    NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    if ([objects count] == 0) {
        _change_label.text = @"No matches";
    } else {
        matches = objects[0];
        _weight_textfield.text = [matches valueForKey:@"weight"];
        _gender_textfield.text = [matches valueForKey:@"gender"];
        //_change_label.text =  @"test2";
        _change_label.text = [NSString stringWithFormat:
                              @"%lu matches found", (unsigned long)[objects count]];
    }
    
    
}


//ACTIVITY BUTTONS

- (IBAction)lazy:(id)sender {
    
    userActivityGolabal =[NSNumber numberWithDouble:1];
    int daily = [self calculateDailyHydrationLevel:[userWeightGolabal intValue] activityLevelaug:[userActivityGolabal doubleValue] environmentLevelaug:[userTemperatureGolabal doubleValue]];
    NSString *dayW = [NSString stringWithFormat:@"%d", daily];
    _change_label.text = dayW;
    
    
    //LAZY
    [self.lazyButtonOutlet setTitleColor:selectedLabelColor forState:UIControlStateNormal];
    self.lazyButtonOutlet.backgroundColor = selectedButtonColor;
    //MEDIUM
    [self.mediumButtonOutlet setTitleColor:unselectedLabelColor forState:UIControlStateNormal];
    self.mediumButtonOutlet.backgroundColor = unselectedButtonColor;
    //SPORTY
    [self.sportyButtonOutlet setTitleColor:unselectedLabelColor forState:UIControlStateNormal];
    self.sportyButtonOutlet.backgroundColor = unselectedButtonColor;
    
 
}

- (IBAction)medium:(id)sender {
    
    userActivityGolabal =[NSNumber numberWithDouble:1.2];
    int daily = [self calculateDailyHydrationLevel:[userWeightGolabal intValue] activityLevelaug:[userActivityGolabal doubleValue] environmentLevelaug:[userTemperatureGolabal doubleValue]];
    NSString *dayW = [NSString stringWithFormat:@"%d", daily];
    _change_label.text = dayW;
    
    
    //LAZY
    [self.lazyButtonOutlet setTitleColor:unselectedLabelColor forState:UIControlStateNormal];
    self.lazyButtonOutlet.backgroundColor = unselectedButtonColor;
    //MEDIUM
    [self.mediumButtonOutlet setTitleColor:selectedLabelColor forState:UIControlStateNormal];
    self.mediumButtonOutlet.backgroundColor = selectedButtonColor;
    //SPORTY
    [self.sportyButtonOutlet setTitleColor:unselectedLabelColor forState:UIControlStateNormal];
    self.sportyButtonOutlet.backgroundColor = unselectedButtonColor;
    
}

- (IBAction)sporty:(id)sender {
    userActivityGolabal =[NSNumber numberWithDouble:1.4];
    int daily = [self calculateDailyHydrationLevel:[userWeightGolabal intValue] activityLevelaug:[userActivityGolabal doubleValue] environmentLevelaug:[userTemperatureGolabal doubleValue]];
    NSString *dayW = [NSString stringWithFormat:@"%d", daily];
    _change_label.text = dayW;
    
    [lazySelected setBackgroundColor:[UIColor colorWithRed:(255/255.0) green:(0/255.0) blue:(0/255.0) alpha:1] ];
    
    //LAZY
    [self.lazyButtonOutlet setTitleColor:unselectedLabelColor forState:UIControlStateNormal];
    self.lazyButtonOutlet.backgroundColor = unselectedButtonColor;
    //MEDIUM
    [self.mediumButtonOutlet setTitleColor:unselectedLabelColor forState:UIControlStateNormal];
    self.mediumButtonOutlet.backgroundColor = unselectedButtonColor;
    //SPORTY
    [self.sportyButtonOutlet setTitleColor:selectedLabelColor forState:UIControlStateNormal];
    self.sportyButtonOutlet.backgroundColor = selectedButtonColor;
    
}

//GENDER BUTTONS

- (IBAction)blueman:(id)sender {
    if(toggleIsOnman){
        toggleIsOnwoman = NO;
        
    }
    else {
        toggleIsOnwoman = NO;
        toggleIsOnman = YES;
        
    }
    
    
    [self.toggleman setImage:[UIImage imageNamed:toggleIsOnman ? @"manblue.png" :@"manwhite.png"] forState:UIControlStateNormal];
    
    [self.womanwhite setImage:[UIImage imageNamed:toggleIsOnwoman ? @"womanblue.png" :@"womanwhite.png"] forState:UIControlStateNormal];
    
}

- (IBAction)whitewoman:(id)sender {
    if(toggleIsOnwoman){
        toggleIsOnman = NO;
        
    }
    else {
        toggleIsOnman = NO;
        toggleIsOnwoman = YES;
    }
    
    
    [self.toggleman setImage:[UIImage imageNamed:toggleIsOnman ? @"manblue.png" :@"manwhite.png"] forState:UIControlStateNormal];
    
    [self.womanwhite setImage:[UIImage imageNamed:toggleIsOnwoman ? @"womanblue.png" :@"womanwhite.png"] forState:UIControlStateNormal];
    
}


//SAVE BUTTON
- (IBAction)drinkButton:(id)sender {
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    NSManagedObject *newContact;
    newContact = [NSEntityDescription
                  insertNewObjectForEntityForName:@"UserData"
                  inManagedObjectContext:context];
    
    if(toggleIsOnman == YES && toggleIsOnwoman == NO){
        // NSNumber *ma = [NSNumber numberWithFloat:80];
        
        int daily = [self calculateDailyHydrationLevel:[userWeightGolabal intValue] activityLevelaug:[userActivityGolabal doubleValue] environmentLevelaug:[userTemperatureGolabal intValue]];
        
        [newContact setValue: userWeightGolabal forKey:@"weight"];
        [newContact setValue: @"m" forKey:@"gender"];
        [newContact setValue: userActivityGolabal forKey:@"activity"];
        [newContact setValue: [NSNumber numberWithInt:daily] forKey:@"fluidgoal"];
        
        NSError *error;
        [context save:&error];
        //_change_label.text = [userWeightGolabal stringValue];
        
    }
    else{
        
        //TO DO - Save Female DATA
        //TO DO -
        int daily = [self calculateDailyHydrationLevel:[userWeightGolabal intValue] activityLevelaug:[userActivityGolabal doubleValue] environmentLevelaug:[userTemperatureGolabal intValue]];
        
        [newContact setValue: userWeightGolabal forKey:@"weight"];
        [newContact setValue: @"f" forKey:@"gender"];
        [newContact setValue: userActivityGolabal forKey:@"activity"];
        [newContact setValue: [NSNumber numberWithInt:daily] forKey:@"fluidgoal"];
        
        NSError *error;
        [context save:&error];
        
    }
    
    //GO TO NEXT VIEW
    
}



- (IBAction)weightFieldAction2:(id)sender {
    
    if (self.weightPicker.isHidden) {
        [self.weightPicker selectRow:selectedRow inComponent:0 animated:YES];
        [self.weightPicker setHidden:NO];
        
    } else {
        [self.weightPicker setHidden:YES];
        
        int daily = [self calculateDailyHydrationLevel:[userWeightGolabal intValue] activityLevelaug:[userActivityGolabal doubleValue] environmentLevelaug:[userTemperatureGolabal intValue]];
        NSString *dayW = [NSString stringWithFormat:@"%d", daily];
        _change_label.text = dayW;
        
        
    }
    
    
}
@end
