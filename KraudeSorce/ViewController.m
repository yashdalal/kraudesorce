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
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://fiery-inferno-2827.firebaseio.com"];
    // Write data to Firebase
    [myRootRef setValue:@"not testing"];
    if(crnLoc.coordinate.latitude>37 && crnLoc.coordinate.latitude< 38 && crnLoc.coordinate.longitude<-122 && crnLoc.coordinate.longitude>-123){
        self.view.backgroundColor = [UIColor greenColor];
    }else{
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
}

@end
