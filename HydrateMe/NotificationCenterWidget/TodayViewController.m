//
//  TodayViewController.m
//  NotificationCenterWidget
//
//  Created by Simon Benfeldt Jørgensen on 07/10/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "AppDelegate.h"
//#import <IBMBluemix/IBMBluemix.h>
//#import <IBMData/IBMData.h>

@interface TodayViewController () <NCWidgetProviding>
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIButton *glass_one;
@property (weak, nonatomic) IBOutlet UIButton *glass_two;
@property (weak, nonatomic) IBOutlet UIButton *glass_three;



@end


@implementation TodayViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(userDefaultsDidChange:)
                                                     name:NSUserDefaultsDidChangeNotification
                                                   object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.preferredContentSize = CGSizeMake(320, 50);
  //  [self updateNumberLabelText];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

- (void)userDefaultsDidChange:(NSNotification *)notification {
//    [self updateNumberLabelText];
}

//- (void)updateNumberLabelText {
//    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.uniguld.hydrateme"];
//    NSInteger number = [defaults integerForKey:@"MyNumberKey"];
//    
//    self.numberLabel.text = [NSString stringWithFormat:@"%d %@", number, @"%"];
//}





@end
