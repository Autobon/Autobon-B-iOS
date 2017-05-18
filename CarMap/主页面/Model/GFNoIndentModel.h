//
//  GFNoIndentModel.h
//  CarMapB
//
//  Created by 陈光法 on 16/11/23.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFNoIndentModel : NSObject


@property (nonatomic, copy) NSString *orderNum; // 订单编号
@property (nonatomic, copy) NSString *orderID;  // 订单ID
@property (nonatomic, copy) NSString *type;     // 施工项目ID
@property (nonatomic, copy) NSString *typeName; // 施工项目名字
@property (nonatomic, copy) NSString *status;   // 订单状态
@property (nonatomic, copy) NSString *statusName;

@property (nonatomic, copy) NSString *techLatitude;     // 技师的维度
@property (nonatomic, copy) NSString *techLongitude;    // 技师的经度
@property (nonatomic, copy) NSString *techId;           // 技师ID



@property (nonatomic, copy) NSString *signTime;     // 签到时间
@property (nonatomic, copy) NSString *startTime;    // 技师开始工作时间（上传施工前照片后）
@property (nonatomic, copy) NSString *createTime;   // 订单创造时间
@property (nonatomic, copy) NSString *agreedStartTime;  // 预约开始间
@property (nonatomic, copy) NSString *agreedEndTime;    // 最迟交车时间
@property (nonatomic, strong) NSArray *photoUrlArr;     // 地址照片地址数组
@property (nonatomic, copy) NSString *remark;   // 订单备注

@property (nonatomic, copy) NSString *latitude;   // 商户的维度
@property (nonatomic, copy) NSString *longitude;   // 商户的经度

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
