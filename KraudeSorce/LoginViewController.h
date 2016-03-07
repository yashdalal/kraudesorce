//
//  LoginViewController.h
//  KraudeSorce
//
//  Created by Yash Dalal on 3/2/16.
//  Copyright © 2016 Yash Dalal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController{
    IBOutlet UITextField *usernamefield;
    IBOutlet UITextField *passwordfield;
    
    NSDictionary *infodictionary;
}

-(IBAction)buttontapped:(id)sender;

@end
