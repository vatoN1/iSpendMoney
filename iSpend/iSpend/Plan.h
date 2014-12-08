//
//  Plan.h
//  iSpend
//
//  Created by academy387 bosmal on 12/8/14.
//  Copyright (c) 2014 Academy387. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Expenses.h"

@interface Plan : NSObject

@property NSString *name;

@property NSInteger *duration;

@property NSNumber *budget;

@property NSString *currency;

@end
