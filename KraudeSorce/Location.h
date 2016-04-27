//
//  Location.h
//  KraudeSorce
//
//  Created by Yash Dalal on 4/26/16.
//  Copyright © 2016 Yash Dalal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *busyLevel;
@property (nonatomic, strong) NSString *image;

//should have a coordinates property (maybe a coordinates object)

@end
