//
//  ShowEditViewController.h
//  iSpend
//
//  Created by Academy387 on 12/8/14.
//  Copyright (c) 2014 Academy387. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowEditViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *dailyLabel;
@property (weak, nonatomic) IBOutlet UITextField *expenseNameTextView;
@property (weak, nonatomic) IBOutlet UITextField *expenseCostTextView;
@property (weak, nonatomic) IBOutlet UIPickerView *changeCurrenyPickItem;
@end
