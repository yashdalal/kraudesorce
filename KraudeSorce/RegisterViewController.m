//
//  RegisterViewController.m
//  KraudeSorce
//
//  Created by Yash Dalal on 3/2/16.
//  Copyright © 2016 Yash Dalal. All rights reserved.
//

#import "RegisterViewController.h"
#import <Firebase/Firebase.h>

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)buttontapped:(id)sender{
    //check if username already exists in the database
    Firebase *ref = [[Firebase alloc] initWithUrl:@"https://fiery-inferno-2827.firebaseio.com"];
    // Write data to Firebase
    [ref createUser:usernamefield.text password:passwordfield.text withValueCompletionBlock:^(NSError *error, NSDictionary *result) {
        if (error) {
            switch (error.code) {
                case FAuthenticationErrorEmailTaken:
                    [errorMessage setText:@"The specified email is already in use."];
                    break;
                case FAuthenticationErrorInvalidEmail:
                    [errorMessage setText:@"The specified email is not a valid email."];
                    break;
                default:
                    break;
            }
        } else {
            NSString *uid = [result objectForKey:@"uid"];
            NSLog(@"Successfully created user account with uid: %@", uid);
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
