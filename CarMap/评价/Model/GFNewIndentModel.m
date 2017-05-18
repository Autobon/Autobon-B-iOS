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
        
        NSArray *typeArr = [self.type componentsSeparatedByString:@","];
        NSArray *arr = @[@"隔热膜", @"隐形车衣", @"车身改色", @"美容清洁"];
        for(int i=0; i<typeArr.count; i++) {
        
            NSInteger index = [typeArr[i] integerValue] - 1;
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
        self.startTime = [NSString stringWithFormat:@"%@", dic[@"startTime"]];
        NSDate *dd1 = [NSDate dateWithTimeIntervalSince1970:[self.startTime doubleValue] / 1000];
        self.startTime = [formatter stringFromDate:dd1];
        
        if(dic[@"techName"] == nil) {
            
            self.techName = @"无";
        }else {
            
            self.techName = [NSString stringWithFormat:@"%@", dic[@"techName"]];
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
        
    }
    
    return self;
}


@end
