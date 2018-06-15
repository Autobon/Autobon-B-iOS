//
//  GFNewIndentModel.h
//  CarMapB
//
//  Created by 陈光法 on 16/11/24.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFNewIndentModel : NSObject


@property (nonatomic, copy) NSString *orderNum;  // 订单编号
@property (nonatomic, copy) NSString *orderID;     //  订单ID
@property (nonatomic, copy) NSString *photo;   // 订单照片
@property (nonatomic, strong) NSArray *photoArr;    // 订单照片数组

@property (nonatomic, copy) NSString *type;  // 施工项目ID
@property (nonatomic, copy) NSString *typeName;  // 施工项目名字
@property (nonatomic, copy) NSString *agreedStartTime;  // 预约时间
@property (nonatomic, copy) NSString *remark;  // 下单备注
@property (nonatomic, copy) NSString *startTime;  // 施工时间
@property (nonatomic, copy) NSString *techName;  // 主技师
@property (nonatomic, copy) NSString *techId;       //主技师id
@property (nonatomic, copy) NSString *beforePhotos;  // 施工前的照片
@property (nonatomic, strong) NSArray *beforePhotosArr; // 施工前的照片数组
@property (nonatomic, copy) NSString *afterPhotos;  // 施工后的照片
@property (nonatomic, strong) NSArray *afterPhotosArr; // 施工后的照片数组
@property (nonatomic, copy) NSString *evaluate;  // 星级

@property (nonatomic, copy) NSString *agreedEndTime;    // 最迟交车时间

@property (nonatomic, copy) NSString *endTime;      // 施工结束时间

@property (nonatomic, copy) NSString *status;   // 订单的状态

@property (nonatomic, copy) NSString *createTime;   // 下单时间

@property (nonatomic, copy) NSString *techAvatar;
@property (nonatomic, copy) NSString *orderCount;
@property (nonatomic, copy) NSString *techPhone;

@property (nonatomic, copy) NSString *contactPhone;


- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
