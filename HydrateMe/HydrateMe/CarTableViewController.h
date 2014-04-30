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

@property (nonatomic, strong) NSMutableArray *statLogDates;
@property (nonatomic, strong) NSMutableArray *statLogAmount;
@property (nonatomic, strong) NSMutableArray *statLogFluidType;
@property (nonatomic, strong) NSMutableArray *statLogFluidColor;
@property (nonatomic, strong) NSMutableArray *statLogDatesAsDates;


@end
