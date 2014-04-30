//
//  StatScreenViewController.m
//  HydrateMe
//
//  Created by Shafi on 05/04/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import "StatScreenViewController.h"
#import "GraphSubViewController.h"

@interface StatScreenViewController ()

@end

@implementation StatScreenViewController

GraphSubViewController *graphSubViewController;

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
    
    // Initializing and adding Topbar view
    graphSubViewController = [[GraphSubViewController alloc] init];
    [self.graphViewContainer addSubview:graphSubViewController.view];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backToMainButton:(id)sender
{
    //Dismiss start screen and return to mainscreen
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
