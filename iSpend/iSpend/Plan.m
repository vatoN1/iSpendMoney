//
//  Plan.m
//  iSpend
//
//  Created by academy387 bosmal on 12/8/14.
//  Copyright (c) 2014 Academy387. All rights reserved.
//

#import "Plan.h"

@implementation Plan

-(id)initWithName:(NSString*)name andDuration:(int)duration andBudget:(double)budget andCurrency:(NSString*)currency andDate:(NSDate*)date{
    self = [super init];
    if (self) {
        self.name = name;
        self.duration = duration;
        self.budget = budget;
        self.currency = currency;
        self.expenses = [[NSMutableArray alloc] init];
        self.daily = budget/duration;
        self.date = date;
    }
    return self;
}

-(NSMutableArray*)addExpenses:(Expense*)expense{
    [self.expenses addObject:expense];
    self.budget = self.budget - expense.value;
    self.daily = self.budget/self.duration;
    if (self.budget < 0) {
        self.budget = 0;
        self.daily = 0;
    }
    return self.expenses;
}

@end
