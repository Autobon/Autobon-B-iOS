//
//  Commom.h
//  CarMapB
//
//  Created by inCar on 2018/6/15.
//  Copyright © 2018年 mll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Commom : NSObject


+ (NSString *)dateToStringWithDate:(NSDate *)date;

+ (NSString *)dateToDetailStringWithDate:(NSDate *)date;

+ (NSDate *)timeIntervalToDateWithTimeInterval:(double )timeInterval;

+ (BOOL) validateCarLicense: (NSString *)carLicense;

#pragma mark - 整数正则表达式
+ (BOOL) validateInt: (NSString *)intString;

@end
