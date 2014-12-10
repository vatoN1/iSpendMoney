//
//  CreateViewController.m
//  iSpend
//
//  Created by Academy387 on 12/8/14.
//  Copyright (c) 2014 Academy387. All rights reserved.
//

#import "CreateViewController.h"

@interface CreateViewController ()

@end

@implementation CreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.currencies = [[NSArray alloc] initWithObjects:@"AUD", @"BAM", @"CAD", @"SGD", @"BRL", @"CHF", @"CZK", @"DKK", @"EUR", @"GBP", @"HKD", @"HRK", @"INR", @"JPY", @"MXN", @"NOK", @"PLN", @"QAR", @"RSD", @"RUB", @"SEK", @"TRY", @"USD", @"XBT", nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)stepClicked:(UIStepper *)sender {
    
    NSUInteger days = sender.value;
    self.planDurationTextView.text = [NSString stringWithFormat:@"%02lu", (unsigned long)days];
    
}


// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.currencies.count;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    
    title = self.currencies[row];
    return title;
}

- (void)pickerView: (UIPickerView *) pickerView didSelectRow: (NSInteger)row inComponent: (NSInteger) component {
    self.rowValue = row;
}


- (IBAction)saveClicked:(id)sender {
    
    self.plan = [[Plan alloc] initWithName:self.planNameTextView.text andDuration:[self.planDurationTextView.text integerValue] andBudget:[self.planBudgetTextView.text integerValue]andCurrency:[self.currencies objectAtIndex:self.rowValue]];
    [self performSegueWithIdentifier:@"showPlanEdit" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqual:@"showPlanEdit"])
    {
        ShowEditViewController *controller = (ShowEditViewController*)[segue  destinationViewController];
        
        [controller addedPlan:self.plan];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
