//
//  GFNewIndentModel.m
//  CarMapB
//
//  Created by 陈光法 on 16/11/24.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFNewIndentModel.h"

@implementation GFNewIndentModel



- (instancetype)initWithDictionary:(NSDictionary *)dic {

    
    self = [super init];
    
    if(self != nil) {
    
        // 显示时间
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
//        NSString *dateString = [formatter stringFromDate:[NSDate date]];
        
        self.orderNum = [NSString stringWithFormat:@"%@", dic[@"orderNum"]];
        self.orderID = [NSString stringWithFormat:@"%@", dic[@"id"]];
        self.type = [NSString stringWithFormat:@"%@", dic[@"type"]];
        
        self.photo = [NSString stringWithFormat:@"%@", dic[@"photo"]];
        NSArray *pArr = [self.photo componentsSeparatedByString:@","];
        self.photoArr = pArr;
        
        self.orderCount = [NSString stringWithFormat:@"%@", dic[@"orderCount"]];
        self.techAvatar = [NSString stringWithFormat:@"%@", dic[@"techAvatar"]];
        
        self.contactPhone = [NSString stringWithFormat:@"%@",dic[@"contactPhone"]];
        
        NSArray *typeArr = [self.type componentsSeparatedByString:@","];
        NSArray *arr = @[@"隔热膜", @"隐形车衣", @"车身改色", @"美容清洁", @"安全膜", @"其他"];
        for(int i=0; i<typeArr.count; i++) {
        
            NSInteger index = [typeArr[i] integerValue] - 1;
            if (index > arr.count - 1){
                index = arr.count - 1;
            }
            if(i == 0) {
            
                self.typeName = arr[index];
            }else {
                
                self.typeName = [NSString stringWithFormat:@"%@,%@", self.typeName, arr[index]];
            }
        }
    
        self.agreedStartTime = [NSString stringWithFormat:@"%@", dic[@"agreedStartTime"]];
        NSDate *dd = [NSDate dateWithTimeIntervalSince1970:[self.agreedStartTime doubleValue] / 1000];
        self.agreedStartTime = [formatter stringFromDate:dd];
        
        self.agreedEndTime = [NSString stringWithFormat:@"%@", dic[@"agreedEndTime"]];
        NSDate *dd44 = [NSDate dateWithTimeIntervalSince1970:[self.agreedEndTime doubleValue] / 1000];
        self.agreedEndTime = [formatter stringFromDate:dd44];
        
        if(dic[@"endTime"] == nil) {
            
            self.endTime = @"无";
        }else {
            
            self.endTime = [NSString stringWithFormat:@"%@", dic[@"endTime"]];
            NSDate *dd44 = [NSDate dateWithTimeIntervalSince1970:[self.endTime doubleValue] / 1000];
            self.endTime = [formatter stringFromDate:dd44];
        }
        
        self.remark = [NSString stringWithFormat:@"%@", dic[@"remark"]];
        if([self.remark isEqualToString:@"(null)"]){
            self.remark = @"无";
        }
        self.startTime = [NSString stringWithFormat:@"%@", dic[@"startTime"]];
        NSDate *dd1 = [NSDate dateWithTimeIntervalSince1970:[self.startTime doubleValue] / 1000];
        self.startTime = [formatter stringFromDate:dd1];
        
        if(dic[@"techName"] == nil) {
            
            self.techName = @"无";
        }else {
            
            self.techName = [NSString stringWithFormat:@"%@", dic[@"techName"]];
        }
        
        if(dic[@"techId"] == nil) {
            
            self.techId = @"无";
        }else {
            
            self.techId = [NSString stringWithFormat:@"%@", dic[@"techId"]];
        }
        
        if(dic[@"beforePhotos"] == nil) {
        
            self.beforePhotos = @"无";
        }else {
    
            self.beforePhotos = [NSString stringWithFormat:@"%@", dic[@"beforePhotos"]];
            self.beforePhotosArr = [self.beforePhotos componentsSeparatedByString:@","];

        }
        
        if(dic[@"afterPhotos"] == nil) {
        
            self.afterPhotos = @"无";
        }else {
        
            self.afterPhotos = [NSString stringWithFormat:@"%@", dic[@"afterPhotos"]];
            self.afterPhotosArr = [self.afterPhotos componentsSeparatedByString:@","];
        }
        
        

        self.status = [NSString stringWithFormat:@"%@", dic[@"status"]];
        
        self.createTime = [NSString stringWithFormat:@"%@", dic[@"createTime"]];
        NSDate *dd11 = [NSDate dateWithTimeIntervalSince1970:[self.createTime doubleValue] / 1000];
        self.createTime = [formatter stringFromDate:dd11];
        
        if(dic[@"techPhone"] == nil) {
        
            self.techPhone = @"无";
        }else {
            
            self.techPhone = [NSString stringWithFormat:@"%@", dic[@"techPhone"]];
        }
        
        if(dic[@"evaluate"] == nil) {
            
            self.evaluate = @"无";
        }else {
            
            NSInteger ii = (NSInteger)([dic[@"evaluate"] floatValue] + 0.5);
            self.evaluate = [NSString stringWithFormat:@"%ld", ii];
        }
        
        
        
        
        
        self.techLatitude = [NSString stringWithFormat:@"%@",dic[@"techLatitude"]];
        self.techLongitude = [NSString stringWithFormat:@"%@",dic[@"techLongitude"]];
        self.latitude = [NSString stringWithFormat:@"%@",dic[@"latitude"]];
        self.longitude = [NSString stringWithFormat:@"%@",dic[@"longitude"]];
        
        
        
        if([self.status isEqualToString:@"CREATED_TO_APPOINT"]) {
            self.statusString = @"待指派";
        }else if([self.status isEqualToString:@"NEWLY_CREATED"]) {
            self.statusString = @"未接单";
        }else if([self.status isEqualToString:@"TAKEN_UP"]) {
            self.statusString = @"已接单";
        }else if([self.status isEqualToString:@"IN_PROGRESS"]) {
            self.statusString = @"已出发";
        }else if([self.status isEqualToString:@"SIGNED_IN"]) {
            self.statusString = @"已签到";
        }else if([self.status isEqualToString:@"AT_WORK"]) {
            self.statusString = @"施工中";
        }else if([self.status isEqualToString:@"FINISHED"]) {
            self.statusString = @"待评价";
        }else if([self.status isEqualToString:@"COMMENTED"]) {
            self.statusString = @"已评价";
        }else {
            self.statusString = @"已撤消";
        }
        
        if(dic[@"license"] == nil) {
            self.license = @"";
        }else{
            self.license = dic[@"license"];
        }
        
        
        if(dic[@"vin"] == nil) {
            self.vin = @"";
        }else{
            self.vin = dic[@"vin"];
        }
        
        
    }
    
    return self;
}


@end
