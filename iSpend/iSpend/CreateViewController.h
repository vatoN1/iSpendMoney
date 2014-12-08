//
//  CreateViewController.h
//  iSpend
//
//  Created by Academy387 on 12/8/14.
//  Copyright (c) 2014 Academy387. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *planNameTextView;
@property (weak, nonatomic) IBOutlet UITextField *planDurationTextView;
@property (weak, nonatomic) IBOutlet UIStepper *durationCounter;
@property (weak, nonatomic) IBOutlet UITextField *planBudgetTextView;
@property (weak, nonatomic) IBOutlet UIPickerView *currencyPickItem;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@end
