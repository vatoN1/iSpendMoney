//
//  StartViewController.h
//  iSpend
//
//  Created by Academy387 on 12/8/14.
//  Copyright (c) 2014 Academy387. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Plan.h"
#import "Expense.h"

@interface StartViewController : UIViewController

@property Plan *plan;
@property NSString *planData;

-(void)savePlan;
-(void)getPlan;

@end
