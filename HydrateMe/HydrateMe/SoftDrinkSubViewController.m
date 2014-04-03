//
//  SoftDrinkSubViewController.m
//  HydrateMe
//
//  Created by Shafi on 03/04/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import "SoftDrinkSubViewController.h"

@interface SoftDrinkSubViewController ()

@end

@implementation SoftDrinkSubViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)largeSoftDrinkButton:(id)sender {
    self.testLabel.text = @"500ML";
}

- (IBAction)mediumSoftDrinkButton:(id)sender {
    self.testLabel.text = @"330ML";
}

- (IBAction)smallSoftDrink:(id)sender {
    self.testLabel.text = @"200ML";
}
@end
