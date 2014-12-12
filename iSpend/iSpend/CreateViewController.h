//
//  CreateViewController.h
//  iSpend
//
//  Created by Academy387 on 12/8/14.
//  Copyright (c) 2014 Academy387. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Plan.h"
#import "ShowEditViewController.h"

@interface CreateViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *planNameTextView;
@property (weak, nonatomic) IBOutlet UITextField *planDurationTextView;
@property (weak, nonatomic) IBOutlet UITextField *planBudgetTextView;
@property (weak, nonatomic) IBOutlet UIPickerView *currencyPickItem;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property Plan *plan;
@property NSArray *currencies;
@property NSInteger rowValue;
@end
