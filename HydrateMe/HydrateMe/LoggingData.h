//
//  LoggingData.h
//  HydrateMe
//
//  Created by Shafi on 04/04/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LoggingData : NSManagedObject

@property (nonatomic, retain) NSDate * date_time;
@property (nonatomic, retain) NSNumber * fluit_amount;
@property (nonatomic, retain) NSString * fluit_type;
@property (nonatomic, retain) NSNumber * temp;

@end
