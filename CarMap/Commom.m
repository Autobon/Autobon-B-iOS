//
//  Commom.m
//  CarMapB
//
//  Created by inCar on 2018/6/15.
//  Copyright © 2018年 mll. All rights reserved.
//

#import "Commom.h"

@implementation Commom


+ (NSString *)dateToStringWithDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)dateToDetailStringWithDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    return [dateFormatter stringFromDate:date];
}

+ (NSDate *)timeIntervalToDateWithTimeInterval:(double )timeInterval{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return date;
}

@end
