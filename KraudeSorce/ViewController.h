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
    IBOutlet UILabel *amIinHolmes;
    CLLocationManager *locationManager;
}

@property (nonatomic, strong) IBOutlet UILabel *locationName;
@property (nonatomic, weak) IBOutlet UILabel *rating;
@property (nonatomic, strong) IBOutlet UIImageView *image;

@property (nonatomic, strong) NSString *lName;
@property (nonatomic, weak) NSString *rat;
@property (nonatomic, strong) NSString *imageTitle;

@end

