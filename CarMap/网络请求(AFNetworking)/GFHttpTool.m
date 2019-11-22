//
//  GFHttpTool.m
//  GFHttpTool(AFNetworking)
//
//  Created by 陈光法 on 15/12/15.
//  Copyright © 2015年 陈光法. All rights reserved.
//*** 网络请求 ****

#import "GFHttpTool.h"
#import "AFNetworking.h"
#import "GFTipView.h"
#import "GFAlertView.h"
#import "Reachability.h"







//测试服务器
NSString *const prefixURL = @"http://118.31.41.230:7123/api/mobile";
NSString* const HOST = @"http://118.31.41.230:7123/api/mobile";
NSString* const PUBHOST = @"http://118.31.41.230:7123/api";



//新的正式服务器
//NSString *const prefixURL = @"http://47.93.17.218:12345/api/mobile";
//NSString* const HOST = @"http://47.93.17.218:12345/api/mobile";
//NSString* const PUBHOST = @"http://47.93.17.218:12345/api";


//NSString *const prefixURL = @"http://10.0.14.19:12345/api/mobile";
//NSString* const HOST = @"http://10.0.14.19:12345/api/mobile";
//NSString* const PUBHOST = @"http://10.0.14.19:12345/api";

@implementation GFHttpTool
// 模版
+ (void)getWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    if ([GFHttpTool isConnectionAvailable]) {
        
        NSString *suffixURL = @"";
        NSString *url = [NSString stringWithFormat:@"%@%@", HOST, suffixURL];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
//                    [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
                }else {
//                    [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
                }
                failure(error);
            }
        }];
        
    }else {
        
        [GFHttpTool addAlertView:@"网络无链接，请检查网络"];
    }
}

+ (void)postWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    if ([GFHttpTool isConnectionAvailable]) {
        
        NSString *suffixURL = @"";
        NSString *url = [NSString stringWithFormat:@"%@%@", HOST, suffixURL];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
//                    [GFTipView tipViewWithNormalHeightWithMessage:@"请求超时，请重试" withShowTimw:1.5];
                }else {
//                    [GFTipView tipViewWithNormalHeightWithMessage:@"请求失败，请重试" withShowTimw:1.5];
                }
                
                failure(error);
            }
        }];
        
    }else {
        
        [GFHttpTool addAlertView:@"网络无链接，请检查网络"];
    }
    
}

#pragma mark - 二期合作商加盟
// 二期
+ (void)jiamengPostWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    if ([GFHttpTool isConnectionAvailable]) {
        
//        NSString *suffixURL = @"/coop/merchant/certificate";
//        NSString *url = [NSString stringWithFormat:@"%@%@", HOST, suffixURL];
        NSString *url = [NSString stringWithFormat:@"%@/api/mobile/coop/merchant/certificate",BaseHttp];
        GFAlertView *alertView = [GFAlertView initWithJinduTiaoTipName:@"提交中..."];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
//        //申明请求的数据是json类型
//        manager.requestSerializer=[AFJSONRequestSerializer serializer];
//        //申明返回的结果是json类型
//        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        // 获取token
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"autoken"];
//        NSLog(@"---%@--\n--%@", url, token);
//        autoken="cooperator:/Ga65PRJ+9fUyAWFKA5mzQ=="
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        
        
        [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [alertView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [alertView removeFromSuperview];
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
//                NSLog(@"===%@", errorStr);
                
                failure(error);
            }
        }];
        
    }else {
        
        [GFHttpTool addAlertView:@"网络无链接，请检查网络"];
    }
    
}

#pragma mark - 获取验证码  
// 二期
+ (void)codeGetParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {

    if ([GFHttpTool isConnectionAvailable]) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *URLString = [NSString stringWithFormat:@"%@/pub/v2/verifySms",PUBHOST];
        
        [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
   
}

#pragma mark - 注册合作商户 
// 二期
+ (void)postRegisterParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *alertView = [GFAlertView initWithJinduTiaoTipName:@"提交中..."];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/merchant/register",HOST];
        [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [alertView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [alertView removeFromSuperview];
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
}

#pragma mark - 登录方法 
// 二期
+ (void)postLoginParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *alertView = [GFAlertView initWithJinduTiaoTipName:@"正在登录..."];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/merchant/login",HOST];
//        NSLog(@"-----%@----%@---",URLString,parameters);
        [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [alertView removeFromSuperview];
            
            // 获取token 针对个人的操作要加
            NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage]; // 获得响应头
//            NSLog(@"####################################\n---%@--",[cookieJar cookies]); // 获取响应头的数组
            NSUserDefaults *autokenValue = [NSUserDefaults standardUserDefaults];
            for (int i = 0; i < [cookieJar cookies].count; i++) {
                NSHTTPCookie *cookie = [cookieJar cookies][i]; // 实例化响应头数组对象
                if ([cookie.name isEqualToString:@"autoken"]) { // 获取响应头数组对象里地名字为autoken的对象
//                    NSLog(@"############%@", [NSString stringWithFormat:@"%@=%@",[cookie name],[cookie value]]); //获取响应头数组对象里地名字为autoken的对象的数据，这个数据是用来验证用户身份相当于“key”
                    [autokenValue setObject:[NSString stringWithFormat:@"%@=%@", cookie.name, cookie.value] forKey:@"autoken"];
                    ICLog(@"===autoken===\n%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"autoken"]);
                    break;
                }
            }
            
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [alertView removeFromSuperview];
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
}

#pragma mark - 忘记密码
+ (void)postForgetPwdParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *alertView = [GFAlertView initWithJinduTiaoTipName:@"提交中..."];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/resetPassword",HOST];
        [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [alertView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [alertView removeFromSuperview];
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
}

#pragma mark - 修改密码
+ (void)postChangePasswordParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *alertView = [GFAlertView initWithJinduTiaoTipName:@"提交中..."];
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/changePassword",HOST];
        
        
        [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
            [alertView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [alertView removeFromSuperview];
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
}

#pragma mark - 上传营业执照副本
// 二期
+ (void)postcertificateImage:(NSData *)imageData success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *alertView = [GFAlertView initWithJinduTiaoTipName:@"上传中..."];
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/merchant/bussinessLicensePic",HOST];
        
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        
        [manager POST:URLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:imageData name:@"file" fileName:@"1235.jpg" mimeType:@"JPEG"];
            
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSData *responseObject) {
            [alertView removeFromSuperview];
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            if(success) {
                success(dictionary);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [alertView removeFromSuperview];
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
}

#pragma mark - 一键下单接口
// 二期
+ (void)postOneIndentDictionary:(NSDictionary *)dictionary success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
//        NSLog(@"－－－－－－dictionary--%@---",dictionary);
        GFAlertView *alertView = [GFAlertView initWithJinduTiaoTipName:@"下单中..."];
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
//        NSLog(@"token---%@--",token);
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/merchant/order",HOST];
        
        
        [manager POST:URLString parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
            [alertView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [alertView removeFromSuperview];
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
}

#pragma mark - 商户查询技师列表（距离优先）
// 二期
+ (void)jishiListGetWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    if ([GFHttpTool isConnectionAvailable]) {
        
        NSString *suffixURL = @"/coop/merchant/technician/distance";
        NSString *url = [NSString stringWithFormat:@"%@%@", HOST, suffixURL];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"autoken"];
        
        ICLog(@"token---%@--",token);
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        // 清除NULL
        AFJSONResponseSerializer *response = (AFJSONResponseSerializer *)manager.responseSerializer;
        response.removesKeysWithNullValues = YES;
        ICLog(@"---URLString-%@----parameters---%@",url,parameters);
        [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
        
    }else {
        
        [GFHttpTool addAlertView:@"网络无链接，请检查网络"];
    }
}

#pragma mark - 商户查询技师列表（模糊查询）
// 二期
+ (void)jishiMohuGetWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    if ([GFHttpTool isConnectionAvailable]) {
        
        NSString *suffixURL = @"/coop/merchant/technician/assign";
        NSString *url = [NSString stringWithFormat:@"%@%@", HOST, suffixURL];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        // 清除NULL
        AFJSONResponseSerializer *response = (AFJSONResponseSerializer *)manager.responseSerializer;
        response.removesKeysWithNullValues = YES;
        
        [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failure) {
                ICLog(@"error---%@--",error);
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
        
    }else {
        
        [GFHttpTool addAlertView:@"网络无链接，请检查网络"];
    }
}

#pragma mark - 获取订单列表（包括已完成、未完成、已评价、未评价）
// 二期
+ (void)dingdanPostWithDictionary:(NSDictionary *)dictionary success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    if ([GFHttpTool isConnectionAvailable]) {
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/merchant/order",HOST];
        ICLog(@"token----%@--",token);
        
        [manager GET:URLString parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
}

#pragma mark - 上传订单图片
// 二期
+ (void)postOrderImage:(NSData *)imageData success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *alertView = [GFAlertView initWithJinduTiaoTipName:@"上传中..."];
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/merchant/order/uploadPhoto",HOST];
        
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        
        [manager POST:URLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:imageData name:@"file" fileName:@"1235.jpg" mimeType:@"JPEG"];
            
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSData *responseObject) {
            [alertView removeFromSuperview];
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            if(success) {
                success(dictionary);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [alertView removeFromSuperview];
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
   
    
}

#pragma mark - 获取商户已完成的订单列表
// 二期
+ (void)postListFinishedDictionary:(NSDictionary *)dictionary success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        // 清除NULL
        AFJSONResponseSerializer *response = (AFJSONResponseSerializer *)manager.responseSerializer;
        response.removesKeysWithNullValues = YES;
        
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/merchant/order",HOST];
        
        
        [manager GET:URLString parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
}

#pragma mark - 获取商户未评论订单列表
// 二期
+ (void)postListUncommentDictionary:(NSDictionary *)dictionary success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        
        // 清除NULL
        AFJSONResponseSerializer *response = (AFJSONResponseSerializer *)manager.responseSerializer;
        response.removesKeysWithNullValues = YES;
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/merchant/order",HOST];
        
        
        [manager GET:URLString parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
}

#pragma mark - 获取商户信息
+ (void)GetInformationSuccess:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *alertView = [GFAlertView initWithJinduTiaoTipName:@"获取中..."];
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/merchant",HOST];
        
        
        [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
            [alertView remove];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [alertView remove];
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
}

#pragma mark - 订单评论
// 二期
+ (void)postCommentDictionary:(NSDictionary *)dictionary success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *alertView = [GFAlertView initWithJinduTiaoTipName:@"提交中..."];
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        // 清除NULL
        AFJSONResponseSerializer *response = (AFJSONResponseSerializer *)manager.responseSerializer;
        response.removesKeysWithNullValues = YES;
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/merchant/order/comment",HOST];
        
        
        [manager POST:URLString parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
            [alertView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [alertView removeFromSuperview];
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
   
    
}

#pragma mark - 获取技师信息
+ (void)GetTechnicianParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    
    if ([GFHttpTool isConnectionAvailable]) {
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/technician/getTechnician",HOST];
        
        
        [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
            
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
}

#pragma mark - 更新个推ID的方法
+ (void)postPushIdDictionary:(NSDictionary *)dictionary success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    NSString *token = [userDefaultes objectForKey:@"autoken"];
    
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
    NSString *URLString = [NSString stringWithFormat:@"%@/coop/pushId",HOST];
    
    
    [manager POST:URLString parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        if(success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(failure) {
            
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFHttpTool addAlertView:@"请求超时，请重试"];
            }else {
                [GFHttpTool addAlertView:@"请求失败，请重试"];
            }
            
            failure(error);
        }
    }];
    
}

#pragma mark - 获取商户订单数，，在个人信息页面的订单数
// 二期
+ (void)postOrderCountsuccess:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *alertView = [GFAlertView initWithJinduTiaoTipName:@"获取中..."];
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/merchant/order/orderCount",HOST];
        
        
        [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
            [alertView remove];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [alertView remove];
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
}

#pragma mark - 获取技师详情，，根据技师ID
// 二期
+ (void)getjishiDetailOrderId:(NSInteger )jishiID success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {

    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *alertView = [GFAlertView initWithJinduTiaoTipName:@"正在获取技师信息..."];
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        // 清除NULL
        AFJSONResponseSerializer *response = (AFJSONResponseSerializer *)manager.responseSerializer;
        response.removesKeysWithNullValues = YES;
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/merchant/technician/%ld",HOST, jishiID];
        
        
        [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
            [alertView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [alertView removeFromSuperview];
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
}

#pragma mark - 查询所有业务员
+ (void)postGetSaleListSuccess:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *alertView = [GFAlertView initWithJinduTiaoTipName:@"获取中..."];
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        // 清除NULL
        AFJSONResponseSerializer *response = (AFJSONResponseSerializer *)manager.responseSerializer;
        response.removesKeysWithNullValues = YES;
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/getSaleList",HOST];
        
        
        [manager POST:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
            [alertView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [alertView removeFromSuperview];
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
}

#pragma mark - 移除业务员
+ (void)postSaleFiredDictionary:(NSDictionary *)dictionary success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *alertView = [GFAlertView initWithJinduTiaoTipName:@"移除中..."];
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/saleFired",HOST];
        
        
        [manager POST:URLString parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
            [alertView remove];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [alertView remove];
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
}

#pragma mark - 增加业务员
+ (void)postAddAccountDictionary:(NSDictionary *)dictionary success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *alertView = [GFAlertView initWithJinduTiaoTipName:@"提交中..."];
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/addAccount",HOST];
        
        
        [manager POST:URLString parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
            [alertView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [alertView removeFromSuperview];
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
}

#pragma mark - 获取通知消息
+ (void)getMessageDictionary:(NSDictionary *)dictionary Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        
//        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"获取中..."];
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/message",HOST];
        
        
        [manager GET:URLString parameters:dictionary progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
//            [aView remove];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            [aView remove];
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
}


#pragma mark - 查找合伙人
+ (void)getSearch:(NSString *)string Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    
    
    if ([GFHttpTool isConnectionAvailable]) {
        
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"查找中..."];
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
//        NSLog(@"token--%@--",token);
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/technician/search",HOST];
//        NSLog(@"------URLString----%@",URLString);
        
        [manager GET:URLString parameters:@{@"query":string} progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            //            NSLog(@"----responseObject--%@--",responseObject);
            if(success) {
                
                [aView removeFromSuperview];
                
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if(failure) {
                [aView removeFromSuperview];
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
        
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
}

#pragma mark - 为订单指定技师
// 二期
+ (void)postAppintTechForOrder:(NSDictionary *)dictionary Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *alertView = [GFAlertView initWithJinduTiaoTipName:@"请求中..."];
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/merchant/order/appoint",HOST];
        
        
        [manager POST:URLString parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
            [alertView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [alertView removeFromSuperview];
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
}

#pragma mark - 修改员工账户
+ (void)postChangeWorkMsgParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {

    if ([GFHttpTool isConnectionAvailable]) {
        
        NSString *workId = parameters[@"workID"];
        
        NSString *suffixURL = [NSString stringWithFormat:@"/coop/account/%@", workId];
        NSString *url = [NSString stringWithFormat:@"%@%@", HOST, suffixURL];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"autoken"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        
        [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {



            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];

    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
}

#pragma mark - 获取订单详情
+ (void)getOrderDetailOrderId:(NSInteger )orderId success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/technician/order/%ld",HOST,orderId];
        
        [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
}

#pragma mark - 商户撤单
// 二期
+ (void)postCanceledOrder:(NSString *)orderId Success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *alertView = [GFAlertView initWithJinduTiaoTipName:@"请求中..."];
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop//merchant/order/%@/cancel",HOST,orderId];
//        NSLog(@"--URLString----%@--",URLString);
        
        [manager PUT:URLString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [alertView removeFromSuperview];
            
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [alertView removeFromSuperview];
            
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else {
        
        [GFHttpTool addAlertView:@"网络无链接，请检查网络"];
    }
        

}

// 老接口，，不用了
#pragma mark - 提交加盟信息
+ (void)postCheckForUser:(NSDictionary *)check success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *alertView = [GFAlertView initWithJinduTiaoTipName:@"提交中..."];
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        //        NSString *URLString = [NSString stringWithFormat:@"%@/coop/check",HOST];
        
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/check",HOST];
        
        
        [manager POST:URLString parameters:check progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
            [alertView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [alertView removeFromSuperview];
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
    
}
#pragma mark - 上传法人正面照
+ (void)postIdImageViewImage:(NSData *)imageData success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *alertView = [GFAlertView initWithJinduTiaoTipName:@"上传中..."];
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/corporationIdPicA",HOST];
        
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager POST:URLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:imageData name:@"file" fileName:@"1235.jpg" mimeType:@"JPEG"];
            
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSData *responseObject) {
            [alertView removeFromSuperview];
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            if(success) {
                success(dictionary);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [alertView removeFromSuperview];
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
}
#pragma mark - 获取商户未完成订单
+ (void)postListUnfinishedDictionary:(NSDictionary *)dictionary success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    
    if ([GFHttpTool isConnectionAvailable]) {
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/order/listUnfinished",HOST];
        
        
        [manager POST:URLString parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
    
    
}

#pragma mark - 商户员工收藏技师
+ (void)favoriteTechnicianPostWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"加载中..."];
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/favorite/technician/%@",HOST,parameters[@"techId"]];
        //        NSLog(@"token-可能是这里错了-%@-－－URLString--%@-",token,URLString);
        [manager POST:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            //            NSLog(@"走出来了");
            [aView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            //            NSLog(@"没有走出来－－－%@--",error);
            [aView removeFromSuperview];
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFHttpTool addAlertView:@"请求超时，请重试"];
            }else {
                [GFHttpTool addAlertView:@"请求失败，请重试"];
            }
            if(failure) {
                failure(error);
            }
        }];
        
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
    
    
    
}

#pragma mark - 商户员工删除收藏技师
+ (void)favoriteTechnicianDeleteWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    
    
    
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"加载中..."];
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/favorite/technician/%@",HOST,parameters[@"cooperatorId"]];
        //        NSLog(@"token-可能是这里错了-%@-－－URLString--%@-",token,URLString);
        [manager DELETE:URLString parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            //            NSLog(@"走出来了");
            [aView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            //            NSLog(@"没有走出来－－－%@--",error);
            [aView removeFromSuperview];
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFHttpTool addAlertView:@"请求超时，请重试"];
            }else {
                [GFHttpTool addAlertView:@"请求失败，请重试"];
            }
            if(failure) {
                failure(error);
            }
        }];
        
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
    
    
    
}

#pragma mark - 商户员工查询收藏技师列表
+ (void)favoriteTechnicianGetWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    
    
    
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"加载中..."];
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/favorite/technician",HOST];
        //        NSLog(@"token-可能是这里错了-%@-－－URLString--%@-",token,URLString);
        [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            //            NSLog(@"走出来了");
            [aView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            //            NSLog(@"没有走出来－－－%@--",error);
            [aView removeFromSuperview];
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFHttpTool addAlertView:@"请求超时，请重试"];
            }else {
                [GFHttpTool addAlertView:@"请求失败，请重试"];
            }
            if(failure) {
                failure(error);
            }
        }];
        
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
    
    
    
}

#pragma mark - 通过订单id查询流程记录列表
+ (void)merchanOrderStatusScoreGetWithParamenters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *aView = [GFAlertView initWithJinduTiaoTipName:@"加载中..."];
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/merchant/order/%@/status/score",HOST,parameters[@"orderId"]];
        //        NSLog(@"token-可能是这里错了-%@-－－URLString--%@-",token,URLString);
        [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            //            NSLog(@"走出来了");
            [aView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            //            NSLog(@"没有走出来－－－%@--",error);
            [aView removeFromSuperview];
            // 判断请求超时
            NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
            if([errorStr isEqualToString:@"The request timed out."]) {
                [GFHttpTool addAlertView:@"请求超时，请重试"];
            }else {
                [GFHttpTool addAlertView:@"请求失败，请重试"];
            }
            if(failure) {
                failure(error);
            }
        }];
        
        
        
    }else{
        
        [GFHttpTool addAlertView:@"无网络连接"];
    }
}


#pragma mark - 获取产品列表
+ (void)getProductOfferWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/product/offer",HOST];
        
        [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
}

#pragma mark - 查看商户产品详情
+ (void)getProductOfferDetailWithOrderId:(NSString *)orderId success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/product/offer/%@",HOST,orderId];
        
        [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
}

#pragma mark - 获取套餐列表
+ (void)getProductOfferSetMenuWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/product/offer/set/menu",HOST];
        
        [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
}

#pragma mark - 查看套餐详情
+ (void)getProductOfferSetMenuDetailWithOrderId:(NSString *)orderId success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/product/offer/set/menu/%@",HOST,orderId];
        ICLog(@"--URLString-----%@---token--%@---", URLString, token);
        [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
}

#pragma mark - 新增我的套餐
+ (void)postProductOfferSetMenuCreateWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/product/offer/set/menu/create",HOST];
        
        [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
}

#pragma mark - 添加报价产品至套餐
+ (void)postProductOfferSetMenuAddWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/product/offer/set/menu/add",HOST];
        
        [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
}

#pragma mark - 报价产品从套餐移除
+ (void)postProductOfferSetMenuRemoveWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/product/offer/set/menu/remove",HOST];
        
        [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
}

#pragma mark - 删除套餐
+ (void)deleteProductOfferSetMenuWithOrderId:(NSString *)orderId success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/product/offer/set/menu/%@",HOST,orderId];
        
        [manager DELETE:URLString parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
}

#pragma mark - 数据下单接口
+ (void)postCoopMerchantDataOrderWithParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 请求超时时间设置
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/merchant/data/order",HOST];
        
        [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if(failure) {
                
                // 判断请求超时
                NSString *errorStr = error.userInfo[@"NSLocalizedDescription"];
                if([errorStr isEqualToString:@"The request timed out."]) {
                    [GFHttpTool addAlertView:@"请求超时，请重试"];
                }else {
                    [GFHttpTool addAlertView:@"请求失败，请重试"];
                }
                
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
}








#pragma mark - AlertView
+ (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withShowTimw:1.0];
    [tipView tipViewShow];
}


#pragma mark - 判断网络连接情况
// 加号方法里只能够调用加号方法
+(BOOL)isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
    }
    
    if (!isExistenceNetwork) {
        return NO;
    }
    
    return isExistenceNetwork;
}



@end
