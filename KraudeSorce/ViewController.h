//
//  ViewController.h
//  KraudeSorce
//
//  Created by Yash Dalal on 2/24/16.
//  Copyright © 2016 Yash Dalal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h> 

@interface ViewController : UIViewController<CLLocationManagerDelegate>{
    IBOutlet UILabel *latitude;
    IBOutlet UILabel *longitude;
    IBOutlet UILabel *altitude;
    IBOutlet UILabel *speed;
    
    IBOutlet UILabel *rating;
    IBOutlet UILabel *amIinHolmes;
    CLLocationManager *locationManager;
}



@end

