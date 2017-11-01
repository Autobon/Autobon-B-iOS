//
//  AppDelegate.m
//  CarMap
//
//  Created by 李孟龙 on 16/1/26.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "AppDelegate.h"
#import "GeTuiSdk.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>


#import "GFSignInViewController.h"
#import "GFEvaluateViewController.h"
#import "GFAlertView.h"
#import "GFOneIndentViewController.h"

#import "GFNoIndentViewController.h"

#import "GFMapViewController.h"

// 调试界面
//#import "GFJoinInViewController_1.h"
//#import "GFJoinInViewController_2.h"
//
//#import "GFIndentDetialsViewController.h"
#import "GFEvaluateShareViewController.h"
#import "GFHttpTool.h"

//#import "GFCooperationViewController.h"
#import "PoiSearchDemoViewController.h"
#import "CLAddPersonViewController.h"

#import <UMSocialCore/UMSocialCore.h>

// 个推开发者网站中申请App时，注册的AppId、AppKey、AppSecret
#define kGtAppId      @"IED5iJnuVu8dklsGy35E54"
#define kGtAppKey     @"22mn0WmsqS6k7omIUytIo4"
#define kGtAppSecret  @"QIBL2KCDIX5wbklRBLIxUA"

@interface AppDelegate ()<GeTuiSdkDelegate,BMKGeneralDelegate>
{
    NSDictionary *_launchDict;
    BMKMapManager *_mapManager;
//    ViewController *_firstView;
    UINavigationController *_navigation;
    NSDate *_pushDate;
    GFAlertView *_alertView;
}
@end

@implementation AppDelegate

//如果应用程序没有存活，点击推送打开程序，那么会在 launchOptions 中加入一对 key-value，value 就是当前激活的推送对象。
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _launchDict = [[NSDictionary alloc]initWithDictionary:launchOptions];
    // 通过个推平台分配的appId、 appKey 、appSecret 启动SDK，注：该方法需要在主线程中调用
    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:self];
    
    // 处理远程通知启动APP
    [self receiveNotificationByLaunchingOptions:launchOptions];
    
    // 注册APNS
    [self registerUserNotification];
    
    
//    [UMSocialData setAppKey:@"564d41b4e0f55a596d003fe4"];
//
//
//    [UMSocialWechatHandler setWXAppId:@"wx568c812182fa1a4d" appSecret:@"b2933cbe8ad5b3dcd26d1eb5825140b3" url:[NSString stringWithFormat:@"%@/shareB.html",BaseHttp]];
//
//    [UMSocialQQHandler setQQWithAppId:@"1105229897" appKey:@"k2nOEjpJOx5stTYA" url:[NSString stringWithFormat:@"%@/shareB.html",BaseHttp]];
////    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://hpecar.com:12345/shareB.html"];
//
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"1532716943" RedirectURL:[NSString stringWithFormat:@"%@/shareB.html",BaseHttp]];

    
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"564d41b4e0f55a596d003fe4"];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx568c812182fa1a4d" appSecret:@"b2933cbe8ad5b3dcd26d1eb5825140b3" redirectURL:[NSString stringWithFormat:@"%@/shareB.html",BaseHttp]];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105229897"/*设置QQ平台的appID*/  appSecret:nil redirectURL:[NSString stringWithFormat:@"%@/shareB.html",BaseHttp]];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"1532716943"/*设置微博平台的appID*/  appSecret:nil redirectURL:[NSString stringWithFormat:@"%@/shareB.html",BaseHttp]];
    
    
    
    
    
    
    
    
    
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"er5ppSPS6vxnd5BtvWDsgthy" generalDelegate:self];
    if (!ret) {
//        NSLog(@"manager start failed!");
    }
    
//    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
//    GFAddWorkerViewController *firstView = [[GFAddWorkerViewController alloc]init];
//    GFSignInViewController *firstView = [[GFSignInViewController alloc]init];
//    CLAutobonViewController *firstView = [[CLAutobonViewController alloc]init];
//    CLCertifyViewController *firstView = [[CLCertifyViewController alloc]init];
//    GFOneIndentViewController *firstView = [[GFOneIndentViewController alloc]init];
//    GFEvaluateShareViewController *firstView = [[GFEvaluateShareViewController alloc]init];
//    SecondViewController *firstView = [[SecondViewController alloc]init];
    GFSignInViewController *firstView = [[GFSignInViewController alloc]init];
    _navigation = [[UINavigationController alloc]initWithRootViewController:firstView];
//    GFNoIndentViewController *coopVC = [[GFNoIndentViewController alloc] init];
//    _navigation = [[UINavigationController alloc]initWithRootViewController:coopVC];
    _navigation.navigationBarHidden = YES;
    _window.rootViewController = _navigation;
    [_window makeKeyAndVisible];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
//        NSLog(@"联网成功");
    }
    else{
//        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
//        NSLog(@"授权成功");
    }
    else {
//        NSLog(@"onGetPermissionState %d",iError);
    }
}


//-(void)applicationWillEnterForeground:(UIApplication *)application{
//    NSLog(@"回到前台");
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSLog(@"---daying--%@--",[userDefaults objectForKey:@"title"]);
//    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
//    UILocalNotification *note = dictionary[UIApplicationLaunchOptionsLocalNotificationKey];
//    [dictionary description];
//    NSLog(@"--222-daying--%@--",[_launchDict description]);
//    
//    
//}


#pragma mark - 用户通知(推送) _自定义方法

/** 注册用户通知 */
- (void)registerUserNotification {
    
    /*
     注册通知(推送)
     申请App需要接受来自服务商提供推送消息
     */

    // 判读系统版本是否是“iOS 8.0”以上
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ||
        [UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
//        NSLog(@"zounaqule--");
        // 定义用户通知类型(Remote.远程 - Badge.标记 Alert.提示 Sound.声音)
        UIUserNotificationType types = UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge;
        // 定义用户通知设置
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        // 注册用户通知 - 根据用户通知设置
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
//        NSLog(@"注册APNs");
    } else {
//        NSLog(@"zounaquleaaaaa");
        // iOS8.0 以前远程推送设置方式
        // 定义远程通知类型(Remote.远程 - Badge.标记 Alert.提示 Sound.声音)
        // 注册远程通知 -根据远程通知类型
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
        
    }
}

/** 自定义：APP被“推送”启动时处理推送消息处理（APP 未启动--》启动）*/
- (void)receiveNotificationByLaunchingOptions:(NSDictionary *)launchOptions {
    if (!launchOptions)
        return;
    
    /*
     通过“远程推送”启动APP
     UIApplicationLaunchOptionsRemoteNotificationKey 远程推送Key
     */
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
//        NSLog(@"\n>---->>[Launching RemoteNotification]:%@", userInfo);
    }
}

/** 远程通知注册成功委托 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *myToken = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    myToken = [myToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    [GeTuiSdk registerDeviceToken:myToken];    /// 向个推服务器注册deviceToken
//    NSLog(@"\n>>>[DeviceToken Success]:%@\n\n",myToken);
//    16bfbdbc38a20858b6193bd86a7aa4bc3f5a834abb4a8575085bd95a4c681f38
}

/** 远程通知注册失败委托 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [GeTuiSdk registerDeviceToken:@""];     /// 如果APNS注册失败，通知个推服务器
//    NSLog(@"\n>>>[DeviceToken Error]:%@\n\n",error.description);
}




- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//Background Fetch 恢复SDK 运行
//    NSLog(@"后台运行");
    [GeTuiSdk resume];
    completionHandler(UIBackgroundFetchResultNewData);
//    UILocalNotification* ln = [[UILocalNotification alloc] init];
//    ln.fireDate = [NSDate dateWithTimeIntervalSinceNow:1.0];
//    ln.alertBody = @"category";
//    [[UIApplication sharedApplication] scheduleLocalNotification:ln];
//    NSLog(@"方法运行了");
    
}

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    // [4-EXT-1]: 个推SDK已注册，返回clientId
//    NSLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:clientId forKey:@"clientId"];
    
}
/** SDK遇到错误回调 */
- (void)GeTuiSdkDidOccurError:(NSError *)error {
    // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
//    NSLog(@"\n>>>[GexinSdk error]:%@\n\n", [error localizedDescription]);
}


/** SDK收到透传消息回调 */
- (void)GeTuiSdkDidReceivePayload:(NSString *)payloadId andTaskId:(NSString *)taskId andMessageId:(NSString *)aMsgId andOffLine:(BOOL)offLine fromApplication:(NSString *)appId {
    // [4]: 收到个推消息
    NSData *payload = [GeTuiSdk retrivePayloadById:payloadId];
    NSString *payloadMsg = nil;
    if (payload) {
        payloadMsg = [[NSString alloc] initWithBytes:payload.bytes length:payload.length encoding:NSUTF8StringEncoding];
        }
//    NSString *msg = [NSString stringWithFormat:@" payloadId=%@,taskId=%@,messageId:%@,payloadMsg:%@%@",payloadId,taskId,aMsgId,payloadMsg,offLine ? @"<离线消息>" : @""];
//    NSLog(@"\n>>>[GexinSdk ReceivePayload]:%@\n\n", msg);
    [GeTuiSdk sendFeedbackMessage:90001 taskId:taskId msgId:aMsgId];

    
    if (!offLine) {
        NSData *JSONData = [payloadMsg dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"responseJSON----%@--",responseJSON);
        
        if ([responseJSON[@"action"]isEqualToString:@"VERIFICATION_FAILED"] || [responseJSON[@"action"]isEqualToString:@"VERIFICATION_SUCCEED"]||[responseJSON[@"action"]isEqualToString:@"INVITATION_ACCEPTED"]){
            UILocalNotification*notification = [[UILocalNotification alloc] init];
            if (nil != notification)
            {
                notification.fireDate = [NSDate date];
                _pushDate = [NSDate date];
                notification.alertTitle = @"车邻邦";
                notification.alertBody = responseJSON[@"title"];
                notification.userInfo = @{@"dictionary":payloadMsg};
                AudioServicesPlaySystemSound(1307);
                [[UIApplication sharedApplication]scheduleLocalNotification:notification];
            }
        }else if ([responseJSON[@"action"] isEqualToString:@"ORDER_COMPLETE"]){
            NSDictionary *orderDictionary = responseJSON[@"order"];
            if ([orderDictionary[@"status"] isEqualToString:@"FINISHED"]) {
                AudioServicesPlaySystemSound(1307);
                _alertView = [[GFAlertView alloc] initWithHomeTipName:@"提醒" withTipMessage:[NSString stringWithFormat:@"订单编号为%@已结束工作，请您对此次工作的技师做出评价",orderDictionary[@"orderNum"]] withButtonNameArray:@[@"立即评价"]];
                [_alertView.okBut addTarget:self action:@selector(judgeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                _alertView.okBut.tag = [orderDictionary[@"id"] integerValue];
                UIWindow *window = [UIApplication sharedApplication].delegate.window;
                [window addSubview:_alertView];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"FINISHED" object:self userInfo:nil];
            }
            
        }else if ([responseJSON[@"action"]isEqualToString:@"NEW_MESSAGE"]){
            NSDictionary *messageDictionary = responseJSON[@"message"];
            AudioServicesPlaySystemSound(1307);
            _alertView = [[GFAlertView alloc]initWithTitleString:messageDictionary[@"title"] withTipMessage:messageDictionary[@"content"] withButtonNameArray:@[@"确定"]];

            UIWindow *window = [UIApplication sharedApplication].delegate.window;
            [window addSubview:_alertView];
            
        }else if ([responseJSON[@"action"]isEqualToString:@"ORDER_GIVEN_UP"]){
            UILocalNotification*notification = [[UILocalNotification alloc] init];
            if (nil != notification)
            {
                notification.fireDate = [NSDate date];
                _pushDate = [NSDate date];
                notification.alertTitle = responseJSON[@"title"];
                
                NSDictionary *orderDictionary = responseJSON[@"order"];
                notification.alertBody = [NSString stringWithFormat:@"订单编号为:%@ 已被技师放弃",orderDictionary[@"orderNum"]];
                notification.userInfo = @{@"dictionary":payloadMsg};
                AudioServicesPlaySystemSound(1307);
                [[UIApplication sharedApplication]scheduleLocalNotification:notification];
            }
        }
    
    }else{
//        NSLog(@"离线消息不接受");
    }
    
}



- (void)judgeBtnClick:(UIButton *)button{
//    NSLog(@"立即评价按钮");
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
//    [window.rootViewController push]
    GFEvaluateViewController *evaluateView = [[GFEvaluateViewController alloc]init];
    evaluateView.orderId = [NSString stringWithFormat:@"%ld",(long)button.tag];
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:evaluateView];
    navigation.navigationBarHidden = YES;
    evaluateView.isPush = NO;
    [window.rootViewController presentViewController:navigation animated:YES completion:nil];
    
//    for (UIView* next = [[button superview]superview]; next; next =
//         next.superview) {
//        UIResponder* nextResponder = [next nextResponder];
//        if ([nextResponder isKindOfClass:[UIViewController
//                                          class]]) {
//            UIViewController *view = (UIViewController *)nextResponder;
//            [view.navigationController pushViewController:[[CLMoreViewController alloc]init] animated:NO];
//            
//        }
//    }
}

/** APP已经接收到“远程”通知(推送) - 透传推送消息  */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    // 处理APNs代码，通过userInfo可以取到推送的信息（包括内容，角标，自定义参数等）。如果需要弹窗等其他操作，则需要自行编码。
#pragma mark - 后台运行调用的方法
//    NSLog(@"\n>>>[Receive ------ RemoteNotification - Background Fetch]:%@\n\n",userInfo);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"通知消息" forKey:@"title"];
    completionHandler(UIBackgroundFetchResultNewData);
    NSDictionary *apsDictionary = userInfo[@"aps"];
    NSDictionary *alertDictionary = apsDictionary[@"alert"];
    NSData *JSONData = [alertDictionary[@"payload"] dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
//    NSLog(@"----responseJSON----%@--",responseJSON);
    if ([responseJSON[@"action"] isEqualToString:@"ORDER_COMPLETE"]){
//        AudioServicesPlaySystemSound(1307);
        NSDictionary *orderDictionary = responseJSON[@"order"];
        
        if ([orderDictionary[@"status"] isEqualToString:@"FINISHED"]) {
             GFOneIndentViewController *oneIndentView = [[GFOneIndentViewController alloc]init];
            UIWindow *window = [UIApplication sharedApplication].delegate.window;
            UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:oneIndentView];
            navigation.navigationBarHidden = YES;
            window.rootViewController = navigation;
            _alertView = [[GFAlertView alloc] initWithHomeTipName:@"提醒" withTipMessage:[NSString stringWithFormat:@"订单编号为%@已结束工作，请您对此次工作的技师做出评价",orderDictionary[@"orderNum"]] withButtonNameArray:@[@"立即评价"]];
            [_alertView.okBut addTarget:self action:@selector(judgeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            _alertView.okBut.tag = [orderDictionary[@"id"] integerValue];
            
            [window addSubview:_alertView];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"FINISHED" object:self userInfo:nil];
        }
        
    }else if ([responseJSON[@"action"]isEqualToString:@"NEW_MESSAGE"]){
        NSDictionary *messageDictionary = responseJSON[@"message"];
        
        _alertView = [[GFAlertView alloc]initWithTitleString:messageDictionary[@"title"] withTipMessage:messageDictionary[@"content"] withButtonNameArray:@[@"确定"]];
        
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        [window addSubview:_alertView];
        
    }else if ([responseJSON[@"action"]isEqualToString:@"ORDER_GIVEN_UP"]){
        /*
        GFOneIndentViewController *oneIndentView = [[GFOneIndentViewController alloc]init];
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:oneIndentView];
        navigation.navigationBarHidden = YES;
        window.rootViewController = navigation;
        
        NSDictionary *orderDictionary = responseJSON[@"order"];
        GFIndentDetialsViewController *indentDeVC = [[GFIndentDetialsViewController alloc] init];
        indentDeVC.model = [[GFIndentModel alloc]init];
        indentDeVC.model.workTime = @"无";
        indentDeVC.model.orderNum = orderDictionary[@"orderNum"];
        indentDeVC.model.orderId = orderDictionary[@"id"];
        indentDeVC.model.commentDictionary = orderDictionary[@"comment"];
        indentDeVC.model.photo = orderDictionary[@"photo"];
        indentDeVC.model.workItemsName = @"无";
        NSArray *typeArray = @[@"隔热层",@"隐形车衣",@"车身改色",@"美容清洁"];
        NSInteger type = [orderDictionary[@"orderType"] integerValue] - 1;
        indentDeVC.model.orderType = typeArray[type];
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
        //            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[orderDictionary[@"orderTime"] floatValue]/1000];
        //            indentDeVC.model.workTime = [formatter stringFromDate:date];
        indentDeVC.model.remark = orderDictionary[@"remark"];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[orderDictionary[@"addTime"] floatValue]/1000];
        indentDeVC.model.signinTime = [formatter stringFromDate:date];
        
        
        indentDeVC.model.beforePhotos = @"1";
        indentDeVC.model.afterPhotos = @"1";
        
        
        
        
        
        [GFHttpTool GetTechnicianParameters:@{@"orderId":orderDictionary[@"id"]} success:^(id responseObject) {
            
//            NSLog(@"请求技师信息--%@--",responseObject);
            
            NSDictionary *dataDictionary = responseObject[@"data"];
            NSDictionary *technicianDictionary = dataDictionary[@"technician"];
            indentDeVC.model.workerArr = [[NSMutableArray alloc]init];
            [indentDeVC.model.workerArr addObject:technicianDictionary[@"name"]];
            [navigation pushViewController:indentDeVC animated:YES];
            
            
        } failure:^(NSError *error) {
            
        }];
       */
    }
    
    
    

}


//当应用程序存活并收到推送的时候。
//如果应用程序正在前台使用，直接调用这个方法，不产生提示。
//如果应用程序在后台，会产生提示。如果点击推送的消息打开应用程序，那么会调用这个方法。如果点击 icon 打开应用程序，就不会调用这个方法。
//如果应用程序没有存活，会产生提示，但是无论通过那种方式启动应用程序，都不会调用这个方法。如果我们需要处理收到的通知消息，我们需要使用上面的方法。
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    //系统提供给我们用来处理收到推送后操作的方法。
//    NSLog(@"消息来了a－－%@",notification.alertBody);
    
    
    long time = (long)[[NSDate date] timeIntervalSince1970] - [_pushDate timeIntervalSince1970];
//        NSLog(@"---time--%@----",notification.userInfo);

    if (0 < time && notification.userInfo) {
//        NSLog(@"消息来了a－－%@",notification.userInfo);
        NSData *JSONData = [notification.userInfo[@"dictionary"] dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
        
        if ([responseJSON[@"action"]isEqualToString:@"VERIFICATION_SUCCEED"] || [responseJSON[@"action"]isEqualToString:@"VERIFICATION_FAILED"]){
//            NSLog(@"认证消息");
            UIWindow *window = [UIApplication sharedApplication].delegate.window;
            GFSignInViewController *signin = [[GFSignInViewController alloc]init];
            UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:signin];
            navigation.navigationBarHidden = YES;
            window.rootViewController = navigation;
            
            
        }else if ([responseJSON[@"action"]isEqualToString:@"ORDER_GIVEN_UP"]){
            /*
            GFOneIndentViewController *oneIndentView = [[GFOneIndentViewController alloc]init];
            UIWindow *window = [UIApplication sharedApplication].delegate.window;
            UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:oneIndentView];
            navigation.navigationBarHidden = YES;
            window.rootViewController = navigation;
            
            NSDictionary *orderDictionary = responseJSON[@"order"];
            GFIndentDetialsViewController *indentDeVC = [[GFIndentDetialsViewController alloc] init];
            indentDeVC.model = [[GFIndentModel alloc]init];
            indentDeVC.model.workTime = @"无";
            indentDeVC.model.orderNum = orderDictionary[@"orderNum"];
            indentDeVC.model.orderId = orderDictionary[@"id"];
            indentDeVC.model.commentDictionary = orderDictionary[@"comment"];
            indentDeVC.model.photo = orderDictionary[@"photo"];
            indentDeVC.model.workItemsName = @"无";
            NSArray *typeArray = @[@"隔热层",@"隐形车衣",@"车身改色",@"美容清洁"];
            NSInteger type = [orderDictionary[@"orderType"] integerValue] - 1;
            indentDeVC.model.orderType = typeArray[type];
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
//            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[orderDictionary[@"orderTime"] floatValue]/1000];
//            indentDeVC.model.workTime = [formatter stringFromDate:date];
            indentDeVC.model.remark = orderDictionary[@"remark"];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[orderDictionary[@"addTime"] floatValue]/1000];
            indentDeVC.model.signinTime = [formatter stringFromDate:date];
            

            indentDeVC.model.beforePhotos = @"1";
            indentDeVC.model.afterPhotos = @"1";
            
            
            // 员工姓名添加
//            _workNameArr = [[NSMutableArray alloc] init];
//            NSDictionary *tech = obj[@"mainTech"];
//            NSDictionary *seTech = obj[@"secondTech"];
//            if(![tech isKindOfClass:[NSNull class]]) {
//                
//                [_workNameArr addObject:tech[@"name"]];
//            }else {
//                
//                [_workItemArr addObject:@"无"];
//            }
            
            
            
            
            [GFHttpTool GetTechnicianParameters:@{@"orderId":orderDictionary[@"id"]} success:^(id responseObject) {
                    
//                NSLog(@"请求技师信息--%@--",responseObject);
            
                NSDictionary *dataDictionary = responseObject[@"data"];
                NSDictionary *technicianDictionary = dataDictionary[@"technician"];
                indentDeVC.model.workerArr = [[NSMutableArray alloc]init];
                [indentDeVC.model.workerArr addObject:technicianDictionary[@"name"]];
                [navigation pushViewController:indentDeVC animated:YES];
                
                
            } failure:^(NSError *error) {

            }];
            
//            indentDeVC.model = model;
//            indentDeVC.itemStr = self.workItemArr[indexPath.row];
//            NSLog(@"=====================%@", indentDeVC.itemStr);
//            [self.navigationController pushViewController:indentDeVC animated:YES];
            
            
            */
        }
        
    }
    
    
    
    
}



//- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
//{
//    NSLog(@"禁用横屏");
//    return UIInterfaceOrientationMaskPortrait;
//}





-(void)btnClick:(UIButton *)button{
    [[button superview] removeFromSuperview];
//    NSLog(@"移走view");
}

@end
