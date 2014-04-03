//
//  WaterSubViewController.m
//  HydrateMe
//
//  Created by Shafi on 03/04/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import "WaterSubViewController.h"

@interface WaterSubViewController ()

@end

@implementation WaterSubViewController

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

- (IBAction)largeWaterButton:(id)sender {
    self.testLabel.text = @"500 ml";
}

- (IBAction)mediumWaterButton:(id)sender {
    self.testLabel.text = @"330 ml";
}

- (IBAction)smallWaterButton:(id)sender {
    self.testLabel.text = @"200 ml";
}
@end
