//
//  LoggingData.m
//  HydrateMe
//
//  Created by Shafi on 04/04/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import "LoggingData.h"


@implementation LoggingData

@dynamic date_time;
@dynamic fluit_amount;
@dynamic fluit_type;
@dynamic temp;


-(NSString *)description{
    return [NSString stringWithFormat:@"Fluid: %@,  Amount: %@, Date: %@",
            self.fluit_type, self.fluit_amount, self.date_time];
}
@end
