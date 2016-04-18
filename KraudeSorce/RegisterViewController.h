//
//  RegisterViewController.h
//  KraudeSorce
//
//  Created by Yash Dalal on 3/2/16.
//  Copyright © 2016 Yash Dalal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnderlineTextField.h"

@interface RegisterViewController : UIViewController<UITextFieldDelegate>{
    IBOutlet UnderlineTextField *usernamefield;
    IBOutlet UnderlineTextField *passwordfield;
    IBOutlet UILabel *errorMessage;
}

-(IBAction)buttontapped:(id)sender;

@end
