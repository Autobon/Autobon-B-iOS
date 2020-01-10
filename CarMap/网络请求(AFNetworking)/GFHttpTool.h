//
//  GFHttpTool.h
//  GFHttpTool(AFNetworking)
//
//  Created by 陈光法 on 15/12/15.
//  Copyright © 2015年 陈光法. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFHttpTool : NSObject

//+ (void)get:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
//
//+ (void)post:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
#pragma mark - 判断网络连接情况
+(BOOL)isConnectionAvailable;

// 获取验证码
+ (void)codeGetParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


// 注册合作商户
+ (void)postRegisterParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

// 登录
+ (void)postLoginParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

// 找回密码
+ (void)postForgetPwdParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


// 修改密码
+ (void)postChangePasswordParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

// 上传营业执照副本
+ (void)postcertificateImage:(NSData *)imageData success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


// 上传法人身份证照片
+ (void)postIdImageViewImage:(NSData *)imageData success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


// 提交加盟信息
+ (void)postCheckForUser:(NSDictionary *)check success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


// 一键下单接口
+ (void)postOneIndentDictionary:(NSDictionary *)dictionary success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


// 获取商户未完成订单
+ (void)postListUnfinishedDictionary:(NSDictionary *)dictionary success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


// 上传订单图片
+ (void)postOrderImage:(NSData *)imageData success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;



// 获取商户已完成订单
+ (void)postListFinishedDictionary:(NSDictionary *)dictionary success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;



// 获取商户未评论订单
+ (void)postListUncommentDictionary:(NSDictionary *)dictionary success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

// 订单评论
+ (void)postCommentDictionary:(NSDictionary *)dictionary success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


// 获取商户信息
+ (void)GetInformationSuccess:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;



// 获取技师信息
+ (void)GetTechnicianParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


// 更新个推ID
+ (void)postPushIdDictionary:(NSDictionary *)dictionary success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


// 获取商户订单总数
+ (void)postOrderCountsuccess:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


// 查询所有业务员
+ (void)postGetSaleListSuccess:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

// 移除业务员
+ (void)postSaleFiredDictionary:(NSDictionary *)dictionary success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

// 增加业务员
+ (void)postAddAccountDictionary:(NSDictionary *)dictionary success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

// 获取通知列表
+ (void)getMessageDictionary:(NSDictionary *)dictionary Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

// 查找合伙人
+ (void)getSearch:(NSString *)string Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


//给订单指定技师
+ (void)postAppintTechForOrder:(NSDictionary *)dictionary Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


// 获取订单详情
+ (void)getOrderDetailOrderId:(NSInteger )orderId success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


// 商户撤单
+ (void)postCanceledOrder:(NSString *)orderId Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


#pragma mark - 版本二
// 修改员工账户
+ (void)postChangeWorkMsgParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

// 获取技师详情，，根据技师ID
// 二期
+ (void)getjishiDetailOrderId:(NSInteger )jishiID success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

#pragma mark - 商户查询技师列表（距离优先）
// 二期
+ (void)jishiListGetWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
#pragma mark - 商户查询技师列表（模糊查询）
// 二期
+ (void)jishiMohuGetWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
#pragma mark - 获取订单列表（包括已完成和未完成）
// 二期
+ (void)dingdanPostWithDictionary:(NSDictionary *)dictionary success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;






#pragma mark - 二期合作商加盟
+ (void)jiamengPostWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;







#pragma mark - 商户员工收藏技师
+ (void)favoriteTechnicianPostWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

#pragma mark - 商户员工删除收藏技师
+ (void)favoriteTechnicianDeleteWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

#pragma mark - 商户员工查询收藏技师列表
+ (void)favoriteTechnicianGetWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


#pragma mark - 通过订单id查询流程记录列表
+ (void)merchanOrderStatusScoreGetWithParamenters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


#pragma mark - 获取产品列表
+ (void)getProductOfferWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

#pragma mark - 查看商户产品详情
+ (void)getProductOfferDetailWithOrderId:(NSString *)orderId success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

#pragma mark - 获取套餐列表
+ (void)getProductOfferSetMenuWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

#pragma mark - 查看套餐详情
+ (void)getProductOfferSetMenuDetailWithOrderId:(NSString *)orderId success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

#pragma mark - 新增我的套餐
+ (void)postProductOfferSetMenuCreateWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

#pragma mark - 添加报价产品至套餐
+ (void)postProductOfferSetMenuAddWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

#pragma mark - 报价产品从套餐移除
+ (void)postProductOfferSetMenuRemoveWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

#pragma mark - 删除套餐
+ (void)deleteProductOfferSetMenuWithOrderId:(NSString *)orderId success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

#pragma mark - 数据下单接口
+ (void)postCoopMerchantDataOrderWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

#pragma mark - 新增我的套餐
+ (void)postCreateMenuSetProductOfferWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

#pragma mark - 修改套餐
+ (void)postUpdateMenuSetProductOfferWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

#pragma mark - 查询商户产品报价套餐列表
+ (void)getProductOfferMenuListWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

#pragma mark - 商户创建暂存订单
+ (void)postCoopMerchantOrderPreWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

#pragma mark - 商户获取暂存订单
+ (void)getCoopMerchantOrderPreWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

#pragma mark - 商户删除暂存订单
+ (void)deleteCoopMerchantOrderPreWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
#pragma mark - 评价订单多个技师
+ (void)postCoopMerchantOrderCommentMoreWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
#pragma mark - 获取订单技师列表
+ (void)getMerchantOrderTechWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

@end
