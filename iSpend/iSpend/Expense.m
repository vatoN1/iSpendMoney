//
//  Expense.m
//  iSpend
//
//  Created by academy387 bosmal on 12/8/14.
//  Copyright (c) 2014 Academy387. All rights reserved.
//

#import "Expense.h"

@implementation Expense

-(id)initWithName:(NSString*)name andValue:(double)value andDate:(NSDate*)date{
    self = [super init];
    if (self) {
        self.name = name;
        self.value = value;
        self.date = date;
    }
    return self;
}

@end
