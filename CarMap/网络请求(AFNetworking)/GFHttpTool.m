//
//  GFHttpTool.m
//  GFHttpTool(AFNetworking)
//
//  Created by 陈光法 on 15/12/15.
//  Copyright © 2015年 陈光法. All rights reserved.
//*** 网络请求 ****

#import "GFHttpTool.h"
#import "AFNetworking.h"
#import "Reachability.h"
#import "GFTipView.h"
#import "GFAlertView.h"




NSString* const HOST = @"http://121.40.157.200:12345/api/mobile";
NSString* const PUBHOST = @"http://121.40.157.200:12345/api";

@implementation GFHttpTool

#pragma mark - 获取验证码
+ (void)codeGetParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {

    if ([GFHttpTool isConnectionAvailable]) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *URLString = [NSString stringWithFormat:@"%@/pub/verifySms",PUBHOST];
        [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failure) {
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
   
}


#pragma mark - 注册合作商户
+ (void)postRegisterParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *alertView = [GFAlertView initWithJinduTiaoTipName:@"提交中..."];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/register",HOST];
        [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [alertView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [alertView removeFromSuperview];
            if(failure) {
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
}

#pragma mark - 登录方法
+ (void)postLoginParameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *alertView = [GFAlertView initWithJinduTiaoTipName:@"正在登录..."];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/login",HOST];
        NSLog(@"-----%@----%@---",URLString,parameters);
        [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [alertView removeFromSuperview];
            
            // 获取token 针对个人的操作要加
            NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage]; // 获得响应头
            NSLog(@"####################################\n---%@--",[cookieJar cookies]); // 获取响应头的数组
            NSUserDefaults *autokenValue = [NSUserDefaults standardUserDefaults];
            for (int i = 0; i < [cookieJar cookies].count; i++) {
                NSHTTPCookie *cookie = [cookieJar cookies][i]; // 实例化响应头数组对象
                if ([cookie.name isEqualToString:@"autoken"]) { // 获取响应头数组对象里地名字为autoken的对象
                    NSLog(@"############%@", [NSString stringWithFormat:@"%@=%@",[cookie name],[cookie value]]); //获取响应头数组对象里地名字为autoken的对象的数据，这个数据是用来验证用户身份相当于“key”
                    [autokenValue setObject:[NSString stringWithFormat:@"%@=%@", cookie.name, cookie.value] forKey:@"autoken"];
                    break;
                }
            }
            
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [alertView removeFromSuperview];
            if(failure) {
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
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/resetPassword",HOST];
        [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [alertView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [alertView removeFromSuperview];
            if(failure) {
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
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
}


#pragma mark - 上传营业执照副本
+ (void)postcertificateImage:(NSData *)imageData success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *alertView = [GFAlertView initWithJinduTiaoTipName:@"上传中..."];
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/bussinessLicensePic",HOST];
        
        
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
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
   
    
}


#pragma mark - 提交加盟信息
+ (void)postCheckForUser:(NSDictionary *)check success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *alertView = [GFAlertView initWithJinduTiaoTipName:@"提交中..."];
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/check",HOST];
        
        
        [manager POST:URLString parameters:check progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
            [alertView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [alertView removeFromSuperview];
            if(failure) {
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
    
}



#pragma mark - 一键下单接口
+ (void)postOneIndentDictionary:(NSDictionary *)dictionary success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    
    if ([GFHttpTool isConnectionAvailable]) {
        NSLog(@"－－－－－－dictionary--%@---",dictionary);
        GFAlertView *alertView = [GFAlertView initWithJinduTiaoTipName:@"下单中..."];
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        NSLog(@"token---%@--",token);
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/order/createOrder",HOST];
        
        
        [manager POST:URLString parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
            [alertView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [alertView removeFromSuperview];
            if(failure) {
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
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/order/listUnfinished",HOST];
        
        
        [manager POST:URLString parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failure) {
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
   
    
    
}


#pragma mark - 上传订单图片
+ (void)postOrderImage:(NSData *)imageData success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *alertView = [GFAlertView initWithJinduTiaoTipName:@"上传中..."];
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/order/uploadPhoto",HOST];
        
        
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
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
   
    
}


#pragma mark - 获取商户已完成的订单列表
+ (void)postListFinishedDictionary:(NSDictionary *)dictionary success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/order/listFinished",HOST];
        
        
        [manager POST:URLString parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failure) {
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
    
}


#pragma mark - 获取商户未评论订单列表
+ (void)postListUncommentDictionary:(NSDictionary *)dictionary success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/order/listUncomment",HOST];
        
        
        [manager POST:URLString parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failure) {
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
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/getCoop",HOST];
        
        
        [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
            [alertView remove];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [alertView remove];
            if(failure) {
                failure(error);
            }
        }];
    }else{
        [GFHttpTool addAlertView:@"无网络连接"];
    }
    
    
    
}

#pragma mark - 订单评论
+ (void)postCommentDictionary:(NSDictionary *)dictionary success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *alertView = [GFAlertView initWithJinduTiaoTipName:@"提交中..."];
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/order/comment",HOST];
        
        
        [manager POST:URLString parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
            [alertView removeFromSuperview];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [alertView removeFromSuperview];
            if(failure) {
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
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/technician/getTechnician",HOST];
        
        
        [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
            
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if(failure) {
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
                failure(error);
            }
        }];
    
}


#pragma mark - 获取商户订单数
+ (void)postOrderCountsuccess:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    if ([GFHttpTool isConnectionAvailable]) {
        GFAlertView *alertView = [GFAlertView initWithJinduTiaoTipName:@"获取中..."];
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Cookie"];
        NSString *URLString = [NSString stringWithFormat:@"%@/coop/order/orderCount",HOST];
        
        
        [manager POST:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
            [alertView remove];
            if(success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [alertView remove];
            if(failure) {
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
        NSString *token = [userDefaultes objectForKey:@"autoken"];
        
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
