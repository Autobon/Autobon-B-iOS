//
//  GFIndentModel.h
//  CarMap
//
//  Created by 陈光法 on 16/3/8.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFIndentModel : NSObject

@property (nonatomic, copy) NSString *orderId;      // 订单Id
@property (nonatomic, copy) NSString *orderNum;     // 订单编号
@property (nonatomic ,copy) NSString *orderType;    // 订单类型
@property (nonatomic, copy) NSString *photo;        // 订单图片
@property (nonatomic, copy) NSString *signinTime;   // 下单时间
@property (nonatomic, copy) NSString *remark;       // 下单备注
@property (nonatomic, copy) NSString *workTime;     // 预约时间
@property (nonatomic, strong) NSDictionary *commentDictionary;     // 评论字典
@property (nonatomic ,strong) NSDictionary *mainTechDictionary;    // 主技师字典
@property (nonatomic ,strong) NSDictionary *secondTechDictionary;  // 次技师字典
@property (nonatomic ,strong) NSString *status;

@property (nonatomic, strong) NSMutableArray *workerArr;    // 施工人员
@property (nonatomic, copy) NSString *beforePhotos;         // 施工前照片
@property (nonatomic, copy) NSString *afterPhotos;          // 施工后照片
@property (nonatomic, copy) NSString *workItems;      // 施工项目


@end
