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
        self.remark = [NSString stringWithFormat:@"%@", dic[@"remark"]];
        self.startTime = [NSString stringWithFormat:@"%@", dic[@"startTime"]];
        self.techName = [NSString stringWithFormat:@"%@", dic[@"techName"]];
        
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
    }
    
    return self;
}


@end
