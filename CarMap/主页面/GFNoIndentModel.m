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
        NSArray *arr = @[@"隔热膜", @"隐形车衣", @"车身改色", @"美容清洁"];
        for(int i= 0; i<typeIdArr.count; i++) {
        
            if(i == 0) {
            
                self.typeName = arr[[typeIdArr[i] integerValue] - 1];
            }else {
                
                self.typeName = [NSString stringWithFormat:@"%@,%@", self.typeName, arr[[typeIdArr[i] integerValue] - 1]];
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
        
        self.techLatitude = [NSString stringWithFormat:@"%@", dic[@"techLatitude"]];
        self.techLongitude = [NSString stringWithFormat:@"%@", dic[@"techLongitude"]];
        self.signTime = [NSString stringWithFormat:@"%@", dic[@"signTime"]];
        self.startTime = [NSString stringWithFormat:@"%@", dic[@"startTime"]];
        self.createTime = [NSString stringWithFormat:@"%@", dic[@"createTime"]];
        self.agreedStartTime = [NSString stringWithFormat:@"%@", dic[@"agreedStartTime"]];
        self.agreedEndTime = [NSString stringWithFormat:@"%@", dic[@"agreedEndTime"]];
        self.remark = [NSString stringWithFormat:@"%@", dic[@"remark"]];
        
        NSString *photoStr = [NSString stringWithFormat:@"%@", dic[@"photo"]];
        self.photoUrlArr = [photoStr componentsSeparatedByString:@","];
        
        self.latitude = [NSString stringWithFormat:@"%@", dic[@"latitude"]];
        self.longitude = [NSString stringWithFormat:@"%@", dic[@"longitude"]];
    }
    
    return self;
}
@end
