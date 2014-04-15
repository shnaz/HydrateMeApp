//
//  WeatherSubViewController.h
//  HydrateMe
//
//  Created by Shafi on 15/04/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface WeatherSubViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *areaNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaTempLabel;

@end
