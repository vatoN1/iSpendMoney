//
//  StartViewController.m
//  iSpend
//
//  Created by Academy387 on 12/8/14.
//  Copyright (c) 2014 Academy387. All rights reserved.
//

#import "StartViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)createClick:(id)sender {
    
}
- (IBAction)viewClick:(id)sender {
}
- (IBAction)deleteClick:(id)sender {
}

-(void)savePlan
{
    if (self.plan == nil) {
        //podici warning
    }
    
    else {
        NSDateFormatter *formatter;
        NSString        *dateString;
        
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd-MM-yyyy"];
        
        dateString = [formatter stringFromDate:self.plan.date];
        
        NSString *toSave = [[NSString alloc] initWithFormat:@"%@|%@|%@|%@|%@", self.plan.name, @(self.plan.duration).stringValue, @(self.plan.budget).stringValue, self.plan.currency, dateString];
        
        for (Expense* currentExpense in self.plan.expenses)
        {
            NSString *tempDate;
            tempDate = [formatter stringFromDate:currentExpense.date];
            NSString *toSaveTemp = [[NSString alloc] initWithFormat:@"%@|%@|%@|%@", toSave, currentExpense.name, @(currentExpense.value).stringValue, tempDate];
            toSave = toSaveTemp;
        }
        
        
        NSString *webAddress = @"http://academy387ios.azurewebsites.net/element";
        NSURL *serverUrl = [[NSURL alloc] initWithString:webAddress];
        
        NSString* formData = [[NSString alloc] initWithFormat:@"key=%@&value=%@&group=%@", @"activePlan", toSave, @"iSpendToken3"];
        NSData* data = [formData dataUsingEncoding:NSASCIIStringEncoding];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:serverUrl];
        [request setHTTPBody:data];
        [request setHTTPMethod:@"POST"];
        
        // Connection
        [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            NSLog(@"%@", @"Okay");
        }];
        
    }
}


-(void)getPlan
{
    NSString *webAddress = @"http://academy387ios.azurewebsites.net/group/iSpendToken3";
    NSURL *serverUrl = [[NSURL alloc] initWithString:webAddress];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:serverUrl];
    // Connection
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //NSArray* elements = [responseDict allValues];
        self.planData = [[NSString alloc] initWithString:(NSString *)[responseDict valueForKey:@"value"]];
        if (self.planData == @"empty") {
            //podici warning
        }
        
        else {
            NSArray *array = [self.planData componentsSeparatedByString:@"|"];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd-MM-yyyy"];
            NSDate *date = [dateFormat dateFromString:array[4]];
            self.plan = [[Plan alloc] initWithName:array[0] andDuration:[array[1] integerValue] andBudget:[array[2] doubleValue] andCurrency:array[3] andDate:date];
            
            if (array.count > 5) {
                for (int i = 5; i <= array.count - 3; i += 3) {
                    NSDate *dateExp = [dateFormat dateFromString:array[i+2]];
                    Expense *expense = [[Expense alloc] initWithName:array[i] andValue:[array[i+1] doubleValue] andDate:dateExp];
                    [self.plan addExpenses:expense];
                }
            }
        }
        
        
    }];
    
    
    
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
