//
//  GFNoIndentModel.m
//  CarMapB
//
//  Created by 陈光法 on 16/11/23.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFNoIndentModel.h"

@implementation GFNoIndentModel



- (instancetype)initWithDictionary:(NSDictionary *)dic {
    
    self = [super init];
    
    if(self != nil) {
        
        self.orderNum = [NSString stringWithFormat:@"%@", dic[@"orderNum"]];
        self.orderID = [NSString stringWithFormat:@"%@", dic[@"id"]];
        self.type = [NSString stringWithFormat:@"%@", dic[@"type"]];
        NSArray *typeIdArr = [self.type componentsSeparatedByString:@","];
        NSArray *arr = @[@"隔热膜", @"隐形车衣", @"车身改色", @"美容清洁",@"安全膜",@"其他"];
        
        self.techId = [NSString stringWithFormat:@"%@", dic[@"techId"]];
        for(int i= 0; i<typeIdArr.count; i++) {
            NSInteger typeIndex = [typeIdArr[i] integerValue] - 1;
            if (typeIndex > arr.count - 1){
                typeIndex = arr.count - 1;
            }
            if(i == 0) {
            
                self.typeName = arr[typeIndex];
            }else {
                
                self.typeName = [NSString stringWithFormat:@"%@,%@", self.typeName, arr[typeIndex]];
            }
        }
        self.status = [NSString stringWithFormat:@"%@", dic[@"status"]];
        if([self.status isEqualToString:@"CREATED_TO_APPOINT"]) {
        
            self.statusName = @"待指派";
        }else if([self.status isEqualToString:@"NEWLY_CREATED"]) {
            
            self.statusName = @"未接单";
        }else if([self.status isEqualToString:@"TAKEN_UP"]) {
            
            self.statusName = @"已接单";
        }else if([self.status isEqualToString:@"IN_PROGRESS"]) {
            
            self.statusName = @"已出发";
        }else if([self.status isEqualToString:@"SIGNED_IN"]) {
            
            self.statusName = @"已签到";
        }else if([self.status isEqualToString:@"AT_WORK"]) {
            
            self.statusName = @"施工中";
        }
        
        // 显示时间
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
        
        self.techLatitude = [NSString stringWithFormat:@"%@", dic[@"techLatitude"]];
        self.techLongitude = [NSString stringWithFormat:@"%@", dic[@"techLongitude"]];
        self.signTime = [NSString stringWithFormat:@"%@", dic[@"signTime"]];
        NSDate *dd11 = [NSDate dateWithTimeIntervalSince1970:[self.signTime doubleValue] / 1000];
        self.signTime = [formatter stringFromDate:dd11];
        self.startTime = [NSString stringWithFormat:@"%@", dic[@"startTime"]];
        NSDate *dd111 = [NSDate dateWithTimeIntervalSince1970:[self.startTime doubleValue] / 1000];
        self.startTime = [formatter stringFromDate:dd111];
        self.createTime = [NSString stringWithFormat:@"%@", dic[@"createTime"]];
        NSDate *dd1111 = [NSDate dateWithTimeIntervalSince1970:[self.createTime doubleValue] / 1000];
        self.createTime = [formatter stringFromDate:dd1111];
        self.agreedStartTime = [NSString stringWithFormat:@"%@", dic[@"agreedStartTime"]];
        NSDate *dd11111 = [NSDate dateWithTimeIntervalSince1970:[self.agreedStartTime doubleValue] / 1000];
        self.agreedStartTime = [formatter stringFromDate:dd11111];
        self.agreedEndTime = [NSString stringWithFormat:@"%@", dic[@"agreedEndTime"]];
        NSDate *dd111111 = [NSDate dateWithTimeIntervalSince1970:[self.agreedEndTime doubleValue] / 1000];
        self.agreedEndTime = [formatter stringFromDate:dd111111];
        self.remark = [NSString stringWithFormat:@"%@", dic[@"remark"]];
        
        NSString *photoStr = [NSString stringWithFormat:@"%@", dic[@"photo"]];
        self.photoUrlArr = [photoStr componentsSeparatedByString:@","];
        
        self.latitude = [NSString stringWithFormat:@"%@", dic[@"latitude"]];
        self.longitude = [NSString stringWithFormat:@"%@", dic[@"longitude"]];
    }
    
    return self;
}
@end
