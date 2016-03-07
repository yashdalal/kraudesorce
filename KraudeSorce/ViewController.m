//
//  ViewController.m
//  KraudeSorce
//
//  Created by Yash Dalal on 2/24/16.
//  Copyright © 2016 Yash Dalal. All rights reserved.
//

#import "ViewController.h"
#import <Firebase/Firebase.h>

@interface ViewController ()

@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc]init]; // initializing locationManager
    locationManager.delegate = self; // we set the delegate of locationManager to self.
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; // setting the accuracy
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];  //requesting location updates
    NSLog(@"got here");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    UIAlertController * errorAlert=   [UIAlertController
                                  alertControllerWithTitle:@"Error"
                                  message:@"There was an error retrieving your location"
                                  preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:errorAlert animated:YES completion:nil];
    NSLog(@"Error: %@",error.description);
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *crnLoc = [locations lastObject];
    latitude.text = [NSString stringWithFormat:@"%.8f",crnLoc.coordinate.latitude];
    longitude.text = [NSString stringWithFormat:@"%.8f",crnLoc.coordinate.longitude];
    altitude.text = [NSString stringWithFormat:@"%.0f m",crnLoc.altitude];
    speed.text = [NSString stringWithFormat:@"%.1f m/s", crnLoc.speed];
    
    // Create a reference to a Firebase database URL
    Firebase *ref = [[Firebase alloc] initWithUrl:@"https://fiery-inferno-2827.firebaseio.com"];
    // Write data to Firebase
    NSDictionary *alanisawesome = @{
                                    @"full_name" : @"Alan Turing",
                                    @"date_of_birth": @"June 23, 1912"
                                    };
    NSDictionary *gracehop = @{
                               @"full_name" : @"Grace Hopper",
                               @"date_of_birth": @"December 9, 1906"
                               };
    Firebase *usersRef = [ref childByAppendingPath: @"users"];
    NSDictionary *users = @{
                            @"alanisawesome": alanisawesome,
                            @"gracehop": gracehop
                            };
    [usersRef setValue: users];
    
    if(crnLoc.coordinate.latitude>38.62 && crnLoc.coordinate.latitude< 38.64 && crnLoc.coordinate.longitude>-90.31 && crnLoc.coordinate.longitude<-90.29){
        self.view.backgroundColor = [UIColor greenColor];
    }else{
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
}

@end
