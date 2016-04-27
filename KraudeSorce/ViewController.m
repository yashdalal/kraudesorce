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
    
    _locationName.text = _lName;
    _rating.text = _rat;
    [_image setImage:[UIImage imageNamed:_imageTitle]];
    
    [self checkBusiness];
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

-(void) checkBusiness{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"EEEE"];
    NSString *today = [dateFormatter stringFromDate:[NSDate date]];
    
    
    NSString *hour = [self hourToNearestFifteen];
    
    //Firebase *ref = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/locations/holmesLounge/meanData/%@/%@",FirebaseURL, today, hour]];
    Firebase *ref = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/locations/holmesLounge/meanData/Monday/12:00",FirebaseURL]];
    
    __block NSInteger holmesMean;
    
    [ref observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *holmesSnapshot) {
        holmesMean = [holmesSnapshot.value[@"mean"] integerValue];
        if(holmesMean < 55){
            _rating.text = @"Empty";
        }else{
            _rating.text = @"Busy";
        }
    } withCancelBlock:^(NSError *error) {
        NSLog(@"%@", error.description);
    }];
    
}

-(NSString*) hourToNearestFifteen {
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    
    minute = round(minute/15.0)*15;
    
    NSString *outputTime = [NSString stringWithFormat:@"%ld:%ld", (long)hour, (long)minute];
    
    if(minute == 60){
        hour = hour + 1;
        outputTime = [NSString stringWithFormat:@"%ld:00", hour];
    }else if (minute == 0){
        outputTime = [NSString stringWithFormat:@"%ld:00", hour];
    }
    
    return outputTime;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *crnLoc = [locations lastObject];
    
    // Create a reference to a Firebase database URL
    Firebase *ref = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/locations/holmesLounge/analytics/currentCount",FirebaseURL]];
    
    [self checkBusiness];
    
    
    if(crnLoc.coordinate.latitude>38 && crnLoc.coordinate.latitude< 39 && crnLoc.coordinate.longitude<-90 && crnLoc.coordinate.longitude>-91){
        
        if(!isInHolmesLounge){
            
            [ref observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *holmesSnapshot) {
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
        amIinHolmes.text = @"You are currently in Holmes Lounge";
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
        amIinHolmes.text = @"";
    }
    
}

@end
