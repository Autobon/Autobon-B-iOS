//
//  CLOrderStatusTimeModel.m
//  CarMapB
//
//  Created by inCar on 2018/6/15.
//  Copyright © 2018年 mll. All rights reserved.
//


#import "CLOrderStatusTimeModel.h"
#import "Commom.h"



@implementation CLOrderStatusTimeModel

- (void)setModelForData:(NSDictionary *)dataDictionary{
    self.recordTime = [dataDictionary[@"recordTime"] doubleValue]/1000;
    NSDate *date = [Commom timeIntervalToDateWithTimeInterval:self.recordTime];
    
    self.recordDateString = [Commom dateToDetailStringWithDate:date];
//    ICLog(@"------recordTime---%f---recordDateString---%@----",self.recordTime,self.recordDateString);
    self.orderId = [NSString stringWithFormat:@"%@",dataDictionary[@"orderId"]];
    self.status = [dataDictionary[@"status"] intValue];
    if (self.status == 0) {
        self.statusString = @"未接单";
    }else if(self.status == 10){
        self.statusString = @"已接单";
    }else if(self.status == 20){
        self.statusString = @"已出发";
    }else if(self.status == 30){
        self.statusString = @"已签到";
    }else if(self.status == 40){
        self.statusString = @"施工中";
    }else if(self.status == 50){
        self.statusString = @"已完成";
    }
}


@end
