//
//  CLOrderStatusTimeModel.h
//  CarMapB
//
//  Created by inCar on 2018/6/15.
//  Copyright © 2018年 mll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLOrderStatusTimeModel : NSObject

@property (nonatomic ,strong) NSString *recordDateString;
@property (nonatomic ) double recordTime;
@property (nonatomic ,strong) NSString *orderId;
@property (nonatomic ,strong) NSString *statusString;
@property (nonatomic ) int status;

- (void)setModelForData:(NSDictionary *)dataDictionary;



@end
