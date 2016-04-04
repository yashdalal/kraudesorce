//
//  ViewController.m
//  KraudeSorce
//
//  Created by Yash Dalal on 2/24/16.
//  Copyright © 2016 Yash Dalal. All rights reserved.
//

#import "ViewController.h"
#import <Firebase/Firebase.h>

static NSString * const FirebaseURL = @"https://fiery-inferno-2827.firebaseio.com";

@interface ViewController ()

@end

@implementation ViewController

BOOL isInHolmesLounge = NO;
NSInteger userCount;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"poop");
    locationManager = [[CLLocationManager alloc]init]; // initializing locationManager
    locationManager.delegate = self; // we set the delegate of locationManager to self.
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; // setting the accuracy
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];  //requesting location updates
    NSLog(@"poop");
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
    NSLog(@"got here");
    CLLocation *crnLoc = [locations lastObject];
    latitude.text = [NSString stringWithFormat:@"%.8f",crnLoc.coordinate.latitude];
    longitude.text = [NSString stringWithFormat:@"%.8f",crnLoc.coordinate.longitude];
    altitude.text = [NSString stringWithFormat:@"%.0f m",crnLoc.altitude];
    speed.text = [NSString stringWithFormat:@"%.1f m/s", crnLoc.speed];
    
    // Create a reference to a Firebase database URL
    Firebase *ref = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/locations/holmesLounge",FirebaseURL]];
    
    
    if(crnLoc.coordinate.latitude>38.648065 && crnLoc.coordinate.latitude<38.648243 && crnLoc.coordinate.longitude<-90.306222 && crnLoc.coordinate.longitude>-90.306667){
        
        if(!isInHolmesLounge){
            
            [ref observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *holmesSnapshot) {
                NSLog(@"%@", holmesSnapshot.value[@"userCount"]);
                userCount = [holmesSnapshot.value[@"userCount"] integerValue];
                
            } withCancelBlock:^(NSError *error) {
                NSLog(@"%@", error.description);
            }];
            userCount++;
            
            //overwrite database usercount with new one (increased by 1)
            Firebase *countRef = [ref childByAppendingPath: @"userCount"];
            [countRef setValue: [NSString stringWithFormat:@"%ld",(long)userCount]];
            isInHolmesLounge = YES;
        }
        self.view.backgroundColor = [UIColor greenColor];
    }else{
        if(isInHolmesLounge){
            
            [ref observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *holmesSnapshot) {
                NSLog(@"%@", holmesSnapshot.value[@"userCount"]);
                userCount = [holmesSnapshot.value[@"userCount"] integerValue];
                
            } withCancelBlock:^(NSError *error) {
                NSLog(@"%@", error.description);
            }];
            userCount--;
            
            //overwrite database usercount with new one (increased by 1)
            Firebase *countRef = [ref childByAppendingPath: @"userCount"];
            [countRef setValue: [NSString stringWithFormat:@"%ld",(long)userCount]];
            isInHolmesLounge = NO;
        }
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
}

@end
