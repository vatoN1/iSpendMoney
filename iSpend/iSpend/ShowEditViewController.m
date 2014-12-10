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
    self.currencies = [[NSArray alloc] initWithObjects:@"AUD", @"BAM", @"CAD", @"SGD", @"BRL", @"CHF", @"CZK", @"DKK", @"EUR", @"GBP", @"HKD", @"HRK", @"INR", @"JPY", @"MXN", @"NOK", @"PLN", @"QAR", @"RSD", @"RUB", @"SEK", @"TRY", @"USD", @"XBT", nil];
    
    self.statusLabel.text = [[NSString alloc] initWithFormat:@"%@ %@", @(self.plan.budget).stringValue, self.plan.currency];
    self.dailyLabel.text = [[NSString alloc] initWithFormat:@"%.1g %@", self.plan.daily, self.plan.currency];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSString *webAddress = [[NSString alloc] initWithFormat:@"%@, %@, %@, %@, %@, %@", @"http://rate-exchange.appspot.com/currency?from=", self.plan.currency, @"&to=", [self.currencies objectAtIndex:self.rowValue], @"&q=", @(self.plan.budget).stringValue];
    
    //@"http://rate-exchange.appspot.com/currency?from=USD&to=EUR&q=100"
    
    NSURL *serverUrl = [[NSURL alloc] initWithString:webAddress];
    
    // request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:serverUrl];
    
    //connection
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"%@", [responseDict valueForKey:@"v"]);
     }];
    
    //nastaviti implementaciju / preracunati novi daily, novi budget i self.plan.currency = novi
}
- (IBAction)addExpenseClicked:(id)sender {
    
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
