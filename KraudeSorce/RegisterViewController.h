//
//  RegisterViewController.h
//  KraudeSorce
//
//  Created by Yash Dalal on 3/2/16.
//  Copyright © 2016 Yash Dalal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController{
    IBOutlet UITextField *usernamefield;
    IBOutlet UITextField *passwordfield;
}

-(IBAction)buttontapped:(id)sender;

@end