//
//  ShowEditViewController.m
//  iSpend
//
//  Created by Academy387 on 12/8/14.
//  Copyright (c) 2014 Academy387. All rights reserved.
//

#import "ShowEditViewController.h"

@interface ShowEditViewController ()

@end

@implementation ShowEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.currencies = [[NSArray alloc] initWithObjects:@"AUD", @"BAM",  @"BRL", @"CAD", @"CHF", @"CZK", @"DKK", @"EUR", @"GBP", @"HKD", @"HRK", @"INR", @"JPY", @"MXN", @"NOK", @"PLN", @"QAR", @"RSD", @"RUB", @"SEK", @"SGD", @"TRY", @"USD", @"XBT", nil];
    
    if ([[NSDate date] compare:self.plan.date] != NSOrderedAscending)
    {
        NSTimeInterval secondsBetween = [[NSDate date] timeIntervalSinceDate:self.plan.date];
        int numberOfDays = secondsBetween / 86400;
        self.plan.duration -= numberOfDays;
    }
    
    [self.changeCurrenyPickItem selectRow:[self.currencies indexOfObject:self.plan.currency] inComponent:0 animated:YES];
    
    self.statusLabel.text = [[NSString alloc] initWithFormat:@"%@ %@", @(self.plan.budget).stringValue, self.plan.currency];
    self.dailyLabel.text = [[NSString alloc] initWithFormat:@"%.2f %@", self.plan.daily, self.plan.currency];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.plan.expenses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    if(indexPath.row % 2 == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"expenseItem1"];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"expenseItem2"];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];

    
    Expense *e = (Expense*)[self.plan.expenses objectAtIndex:indexPath.row];
    cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@  %@ %@  %@", e.name, @(e.value).stringValue, self.plan.currency, [dateFormatter stringFromDate:e.date]];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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

- (IBAction)saveEditPlanClicked:(id)sender {
    NSString *webAddress = [[NSString alloc] initWithFormat:@"%@%@%@%@%@%@", @"http://rate-exchange.appspot.com/currency?from=", self.plan.currency, @"&to=", [self.currencies objectAtIndex:self.rowValue], @"&q=", @(self.plan.budget).stringValue];
    
    //@"http://rate-exchange.appspot.com/currency?from=USD&to=EUR&q=100"
    
    NSURL *serverUrl = [[NSURL alloc] initWithString:webAddress];
    
    // request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:serverUrl];
    
    //connection
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
         self.plan.budget = round([[responseDict valueForKey:@"v"] doubleValue]*100.0)/100.0;
         
         
         self.plan.currency = [self.currencies objectAtIndex:self.rowValue];
         self.plan.daily = self.plan.budget/self.plan.duration;
         
         self.statusLabel.text = [[NSString alloc] initWithFormat:@"%.2f %@", self.plan.budget, self.plan.currency];
         self.dailyLabel.text = [[NSString alloc] initWithFormat:@"%.2f %@", self.plan.daily, self.plan.currency];
     }];
    
}
- (IBAction)addExpenseClicked:(id)sender {
    if (![self.expenseNameTextView.text isEqualToString:@""] && ![self.expenseCostTextView.text isEqualToString:@""] && self.plan.budget >= [self.expenseCostTextView.text doubleValue]) {
        Expense *newExpense = [[Expense alloc] initWithName:self.expenseNameTextView.text andValue:[self.expenseCostTextView.text doubleValue] andDate:[NSDate date]];
        [self.plan addExpenses:newExpense];
        
        
        self.statusLabel.text = [[NSString alloc] initWithFormat:@"%@ %@", @(self.plan.budget).stringValue, self.plan.currency];
        self.dailyLabel.text = [[NSString alloc] initWithFormat:@"%.2f %@", self.plan.daily, self.plan.currency];
        
        [self.tableView reloadData];
    }
    
}



-(void)addedPlan:(Plan*)plan{
    self.plan = plan;
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
