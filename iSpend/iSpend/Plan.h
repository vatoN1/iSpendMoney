//
//  Plan.h
//  iSpend
//
//  Created by academy387 bosmal on 12/8/14.
//  Copyright (c) 2014 Academy387. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Expense.h"

@interface Plan : NSObject

@property NSString *name;

@property int duration;

@property double budget;

@property NSString *currency;

@property NSMutableArray *expenses;

@property double daily;

@property NSDate* date;

-(id)initWithName:(NSString*)name andDuration:(int)duration andBudget:(double)budget andCurrency:(NSString*)currency;

-(NSMutableArray*)addExpenses:(Expense*)expense;

@end
