//
//  CarTableViewController.h
//  TableViewStory
//
//  Created by Mads Engels on 4/9/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface CarTableViewController : UITableViewController

//@property (nonatomic, strong) NSArray *carMakes;
//@property (nonatomic, strong) NSArray *carModels;
@property (nonatomic, strong) NSArray *statLogDates;
@property (nonatomic, strong) NSArray *statLogAmount;
@property (nonatomic, strong) NSArray *statLogFluidType;
@property (nonatomic, strong) NSArray *statLogFluidColor;
//@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end
