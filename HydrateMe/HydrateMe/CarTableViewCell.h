//
//  CarTableViewCell.h
//  TableViewStory
//
//  Created by Mads Engels on 4/9/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface CarTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *makeLabel;
@property (weak, nonatomic) IBOutlet UILabel *modelLabel;
@property (weak, nonatomic) IBOutlet UILabel *fluidAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *fluidTypeColorLabel;

@end
