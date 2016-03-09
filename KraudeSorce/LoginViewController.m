//
//  LoginViewController.m
//  KraudeSorce
//
//  Created by Yash Dalal on 3/2/16.
//  Copyright © 2016 Yash Dalal. All rights reserved.
//

#import "LoginViewController.h"
#import <Firebase/Firebase.h>


static NSString * const FirebaseURL = @"https://fiery-inferno-2827.firebaseio.com";

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
//    [self setBottomBorder:usernamefield];
//    [self setBottomBorder:passwordfield];
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}
//
//-(void) setBottomBorder: (UITextField*)tf{
//    CALayer *border = [CALayer layer];
//    CGFloat borderWidth = 1;
//    border.borderColor = [UIColor darkGrayColor].CGColor;
//    border.frame = CGRectMake(0, tf.frame.size.height - borderWidth, tf.frame.size.width, usernamefield.frame.size.height);
//    border.borderWidth = borderWidth;
//    [tf.layer addSublayer:border];
//    tf.layer.masksToBounds = YES;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)buttontapped:(id)sender{
    Firebase *ref = [[Firebase alloc] initWithUrl:FirebaseURL];
    [ref authUser:usernamefield.text password:passwordfield.text
withCompletionBlock:^(NSError *error, FAuthData *authData) {
        if (error) {
            switch(error.code) {
                case FAuthenticationErrorUserDoesNotExist:
                    errorMessage.text = @"This user does not exist";
                    break;
                case FAuthenticationErrorInvalidEmail:
                    errorMessage.text = @"Invalid Email Address";
                    break;
                case FAuthenticationErrorInvalidPassword:
                    errorMessage.text = @"Password doesn't match";
                    break;
                default:
                    errorMessage.text = @"Error logging in";
                    break;
            }
        } else {
            NSLog(@"successfully logged in with %@",authData);
            [self performSegueWithIdentifier:@"location" sender:self];
        }
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
