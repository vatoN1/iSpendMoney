//
//  ShowEditViewController.h
//  iSpend
//
//  Created by Academy387 on 12/8/14.
//  Copyright (c) 2014 Academy387. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateViewController.h"
#import "Plan.h"
#import "Expense.h"

@interface ShowEditViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *dailyLabel;
@property (weak, nonatomic) IBOutlet UITextField *expenseNameTextView;
@property (weak, nonatomic) IBOutlet UITextField *expenseCostTextView;
@property (weak, nonatomic) IBOutlet UIPickerView *changeCurrenyPickItem;
@property NSArray *currencies;
@property NSInteger rowValue;

@property Plan* plan;

-(void)addedPlan:(Plan*)plan;

@end
