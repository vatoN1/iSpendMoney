//
//  Expense.h
//  iSpend
//
//  Created by academy387 bosmal on 12/8/14.
//  Copyright (c) 2014 Academy387. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Expense : NSObject

@property NSString *name;

@property double value;

@property NSDate *date;

-(id)initWithName:(NSString*)name andValue:(double)value andDate:(NSDate*)date;

@end
