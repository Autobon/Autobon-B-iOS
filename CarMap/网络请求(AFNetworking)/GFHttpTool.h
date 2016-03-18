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


// 上传营业执照副本
+ (void)postcertificateImage:(NSData *)imageData success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


// 上传法人身份证照片
+ (void)postIdImageViewImage:(NSData *)imageData success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;



@end
