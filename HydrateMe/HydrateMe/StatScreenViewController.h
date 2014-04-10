//
//  StatScreenViewController.h
//  HydrateMe
//
//  Created by Shafi on 05/04/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface StatScreenViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
- (IBAction)button1:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *label1;

//@property (weak, nonatomic) IBOutlet UILabel *fluidTypeStatLabel;
//@property (weak, nonatomic) IBOutlet UILabel *timestampStatLabel;
//@property (weak, nonatomic) IBOutlet UILabel *amountStatLabel;
//@property (nonatomic, strong) NSArray *amounttypeArray;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellinTable;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UITableView *recentLogDataTable;

@end
