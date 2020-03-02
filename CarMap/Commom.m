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

+ (NSString *)dateToHHMMStringWithDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    
    return [dateFormatter stringFromDate:date];
}

+ (NSDate *)stringHHMMToDateWithDate:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    
    return [dateFormatter dateFromString:dateString];
}

+ (NSDate *)timeIntervalToDateWithTimeInterval:(double )timeInterval{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return date;
}

#pragma mark - 车牌号正则表达式
+ (BOOL) validateCarLicense: (NSString *)carLicense
{
    BOOL flag;
    if (carLicense.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex = @"^([京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}(([0-9]{5}[DF])|([DF]([A-HJ-NP-Z0-9])[0-9]{4})))|([京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-HJ-NP-Z0-9]{4}[A-HJ-NP-Z0-9挂学警港澳]{1})$";
    NSPredicate *carLicensePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [carLicensePredicate evaluateWithObject:carLicense];
}

#pragma mark - 整数正则表达式
+ (BOOL) validateInt: (NSString *)intString
{
    BOOL flag;
    if (intString.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex = @"^\\d{7}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:intString];
}

#pragma mark - 整数正则表达式
+ (BOOL) validateLetterInt: (NSString *)intString
{
    BOOL flag;
    if (intString.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex = @"^[0-9a-zA-Z]{7}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:intString];
}


@end
