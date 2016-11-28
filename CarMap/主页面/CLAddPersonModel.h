//
//  CLAddPersonModel.h
//  CarMap
//
//  Created by 李孟龙 on 16/2/29.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLAddPersonModel : NSObject

@property (nonatomic ,copy) NSString *headImageURL;
@property (nonatomic ,copy) NSString *nameString;
@property (nonatomic ,copy) NSString *phoneString;
@property (nonatomic ,copy) NSString *personId;


#pragma mark - 二期接口数据
@property (nonatomic, copy) NSString *orderID;
@property (nonatomic, copy) NSString *avatar;   // 头像地址
@property (nonatomic, copy) NSString *jishiID;  // 技师ID
@property (nonatomic, copy) NSString *name;     // 技师名字
@property (nonatomic, copy) NSString *phone;    // 技师手机号
@property (nonatomic, copy) NSString *orderCount;   // 订单数
@property (nonatomic, copy) NSString *distance;     // 距离
@property (nonatomic, copy) NSString *cancelCount;  // 弃单数
@property (nonatomic, copy) NSString *evaluate;     // 好评率

@property (nonatomic, copy) NSString *filmLevel;    // 隔热膜星级
@property (nonatomic, copy) NSString *fileWorkingSeniority; // 年限

@property (nonatomic, copy) NSString *colorModifyLevel; // 车身改色
@property (nonatomic, copy) NSString *colorModifyWorkingSeniority;  // 年限

@property (nonatomic, copy) NSString *carCoverLevel;    // 隐形车衣
@property (nonatomic, copy) NSString *carCoverWorkingSeniority; // 年限

@property (nonatomic, copy) NSString *beautyLevel;  // 美容清洁
@property (nonatomic, copy) NSString *beautyWorkingSeniority;   // 年限

- (instancetype)initWithDictionary:(NSDictionary *)dic;


@end
