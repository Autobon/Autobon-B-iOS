//
//  GF PartnersMessageViewController.m
//  车邻邦客户端
//
//  Created by 陈光法 on 16/3/3.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFPartnersMessageViewController.h"
#import "GFNavigationView.h"
#import "GFTextField.h"
#import "GFIndentViewController.h"
#import "GFJoinInViewController_1.h"
#import "GFWorkerViewController.h"
#import "GFChangePwdViewController.h"
#import "GFSignInViewController.h"
#import "GFHttpTool.h"
#import "GFTipView.h"
#import "CLCooperatingViewController.h"
#import "CLWorkerModel.h"
#import "ACETelPrompt.h"
#import "GFTransformViewController.h"
//#import "CLImageView.h"

#import "GFCooperatingSucViewController.h"
#import "CLCollectViewController.h"
#import "CLCollectListViewController.h"


@interface GFPartnersMessageViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    CGFloat jiange1;
}

@property (nonatomic, strong) GFNavigationView *navView;

@end

@implementation GFPartnersMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 基础设置
    [self _setBase];
    
    // 界面搭建
    [self _setView];
}

- (void)_setBase {
    
    kWidth = [UIScreen mainScreen].bounds.size.width;
    kHeight = [UIScreen mainScreen].bounds.size.height;
    
    jiange1 = kHeight * 0.011;
    
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"合作商" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}

- (void)_setView {
    
    // 合作商信息
//    CGFloat baseView1W = kWidth;
    CGFloat baseView1H = kHeight * 0.167;
//    CGFloat baseView1X = 0;
//    CGFloat baseView1Y = 64;
    UIView *baseView1 = [[UIView alloc] init];
    baseView1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView1];
    
    [baseView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_navView.mas_bottom);
        make.height.mas_offset(kHeight * 0.167);
    }];
    
    CGFloat msgLabW = kWidth - (kWidth * 0.083) * 2;
    CGFloat msgLabH = kHeight * 0.03125;
    CGFloat msgLabX = kWidth * 0.083;
    CGFloat msgLabY = 0.0365 * kHeight;
    UILabel *msgLab = [[UILabel alloc] initWithFrame:CGRectMake(msgLabX, msgLabY, msgLabW, msgLabH)];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    msgLab.text = [userDefaults objectForKey:@"userFullname"];
    msgLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    [baseView1 addSubview:msgLab];
    
    // 订单数
    CGFloat shuLabW = kWidth * 0.139;
    CGFloat shuLabH = kHeight * 0.026;
    CGFloat shuLabX = msgLabX;
    CGFloat shuLabY = CGRectGetMaxY(msgLab.frame) + kHeight * 0.0234;
    UILabel *shuLab = [[UILabel alloc] initWithFrame:CGRectMake(shuLabX, shuLabY, shuLabW, shuLabH)];
    shuLab.text = @"订单数";
    shuLab.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    [baseView1 addSubview:shuLab];
    
    // 数目
    CGFloat muLabW = 100;
    CGFloat muLabH = shuLabH;
    CGFloat muLabX = CGRectGetMaxX(shuLab.frame);
    CGFloat muLabY = shuLabY;
    _muLab.frame = CGRectMake(muLabX, muLabY, muLabW, muLabH);
//    _muLab.text = @"200";
    _muLab.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    _muLab.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [baseView1 addSubview:_muLab];
    
    // 边线
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(0, baseView1H, kWidth, 1)];
    lineView4.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [baseView1 addSubview:lineView4];
    
    // 我的订单
    UIButton *orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    orderButton.frame = CGRectMake(0, 0, kWidth, kHeight * 0.078);
    [orderButton addTarget:self action:@selector(orderBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self setGFViewWithY:baseView1H + jiange1 withLeftImgName:@"order" withCenterText:@"我的订单" withRightImgName:@"right" withBut:orderButton];
    
    // 我的收藏
    UIButton *collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    collectButton.frame = CGRectMake(0, 0, kWidth, kHeight * 0.078);
    [collectButton addTarget:self action:@selector(collectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self setGFViewWithY:baseView1H + jiange1 *2 + kHeight * 0.078 withLeftImgName:@"collect" withCenterText:@"我的收藏" withRightImgName:@"right" withBut:collectButton];
    
    // 合作商加盟
    UIButton *joinInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    joinInButton.frame = CGRectMake(0, 0, kWidth, kHeight * 0.078);
    [joinInButton addTarget:self action:@selector(joinInBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self setGFViewWithY:baseView1H + jiange1 * 3 + kHeight * 0.078 *2 withLeftImgName:@"person-1" withCenterText:@"合作商加盟" withRightImgName:@"right" withBut:joinInButton];
    
    // 业务员管理
    UIButton *managerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    managerButton.frame = CGRectMake(0, 0, kWidth, kHeight * 0.078);
    [managerButton addTarget:self action:@selector(manageClick) forControlEvents:UIControlEventTouchUpInside];
    [self setGFViewWithY:baseView1H + jiange1 * 4 + kHeight * 0.078 * 3 withLeftImgName:@"worker" withCenterText:@"业务员管理" withRightImgName:@"right" withBut:managerButton];
    
    
    //通知列表
    UIButton *notificationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    notificationBtn.frame = CGRectMake(0, 0, kWidth, kHeight * 0.078);
    [notificationBtn addTarget:self action:@selector(notificationBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self setGFViewWithY:baseView1H + jiange1 * 5 + kHeight * 0.078 * 4 withLeftImgName:@"notification" withCenterText:@"通知列表" withRightImgName:@"right" withBut:notificationBtn];
    
    
    // 修改密码
    UIButton *changePasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    changePasswordButton.frame = CGRectMake(0, 0, kWidth, kHeight * 0.078);
    [changePasswordButton addTarget:self action:@selector(changePasswordClick) forControlEvents:UIControlEventTouchUpInside];
    [self setGFViewWithY:baseView1H + jiange1 * 6 + kHeight * 0.078 * 5 withLeftImgName:@"password-1" withCenterText:@"修改密码" withRightImgName:@"right" withBut:changePasswordButton];
    
    
    // 车邻班专职客服电话
    UIButton *phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneButton.frame = CGRectMake(0, 0, kWidth, kHeight * 0.078);
    [phoneButton addTarget:self action:@selector(phoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self setGFViewWithY:baseView1H + jiange1 * 7 + kHeight * 0.078 * 6 withLeftImgName:@"phone-1" withCenterText:@"车邻邦专职客服电话" withRightText:@"4001871500" withBut:phoneButton];
    
    // 退出登录
    CGFloat exitViewW = kWidth;
    CGFloat exitViewH = kHeight * 0.078;
    CGFloat exitViewX = 0;
    CGFloat exitViewY = kHeight - exitViewH;
    UIView *exitView = [[UIView alloc] initWithFrame:CGRectMake(exitViewX, exitViewY, exitViewW, exitViewH)];
    exitView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:exitView];
    // 边线
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 1)];
    lineView2.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [exitView addSubview:lineView2];
    // 按钮
    UIButton *exitBut = [UIButton buttonWithType:UIButtonTypeCustom];
    exitBut.frame = CGRectMake(0, 0, kWidth, exitViewH);
    [exitBut setTitle:@"退出登录" forState:UIControlStateNormal];
    [exitBut setTitleColor:[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] forState:UIControlStateNormal];
    exitBut.titleLabel.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    [exitBut addTarget:self action:@selector(leaveSignin) forControlEvents:UIControlEventTouchUpInside];
    [exitView addSubview:exitBut];
}

#pragma mark - 推出登录的响应方法
- (void)leaveSignin{
    
    GFSignInViewController *signinView = [[GFSignInViewController alloc]init];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:signinView];
    window.rootViewController = navigation;
    navigation.navigationBarHidden = YES;
}



- (void)setGFViewWithY:(CGFloat)y withLeftImgName:(NSString *)imgNameLeft withCenterText:(NSString *)centerStr withRightImgName:(NSString *)imgNameRight withBut:(UIButton *)button {

    CGFloat jianjv = kWidth * 0.037;
    
    CGFloat jiange = kHeight * 0.026;

    if (self.view.frame.size.height > 800) {
        y = y + 88;
    }else{
        y = y + 64;
    }
    
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, y, kWidth, kHeight * 0.078)];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView];
    
    
    CGFloat leftImgViewW = kWidth * 0.051;
    CGFloat leftImgViewH = baseView.frame.size.height - jiange * 2.0;
    CGFloat leftImgViewX = jianjv;
    CGFloat leftImgViewY = jiange;
    UIImageView *leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(leftImgViewX, leftImgViewY, leftImgViewW, leftImgViewH)];
//    leftImgView.backgroundColor = [UIColor redColor];
    leftImgView.image = [UIImage imageNamed:imgNameLeft];
    [baseView addSubview:leftImgView];
    
    CGFloat labW = 250;
    CGFloat labH = baseView.frame.size.height;
    CGFloat labX = CGRectGetMaxX(leftImgView.frame) + jianjv - 2;
    CGFloat labY = 0;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(labX, labY, labW, labH)];
    lab.text = centerStr;
    lab.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    [baseView addSubview:lab];
    
    CGFloat righntImgViewW = leftImgViewW*2/3.0;
    CGFloat righntImgViewH = leftImgViewH;
    CGFloat righntImgViewX = kWidth - jianjv - righntImgViewW;
    CGFloat righntImgViewY = leftImgViewY;
    UIImageView *righntImgView = [[UIImageView alloc] initWithFrame:CGRectMake(righntImgViewX, righntImgViewY, righntImgViewW, righntImgViewH)];
//    righntImgView.backgroundColor = [UIColor redColor];
    righntImgView.image = [UIImage imageNamed:imgNameRight];
    [baseView addSubview:righntImgView];
    
    // 边线
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 1)];
    lineView1.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [baseView addSubview:lineView1];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, baseView.frame.size.height - 1, kWidth, 1)];
    lineView2.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [baseView addSubview:lineView2];
    
    
    [baseView addSubview:button];
}

- (void)setGFViewWithY:(CGFloat)y withLeftImgName:(NSString *)imgNameLeft withCenterText:(NSString *)centerStr withRightText:(NSString *)rightStr withBut:(UIButton *)button{
    
    CGFloat jianjv = kWidth * 0.037;
    
    CGFloat jiange = kHeight * 0.026;
    
    if (self.view.frame.size.height > 800) {
        y = y + 88;
    }else{
        y = y + 64;
    }
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, y, kWidth, kHeight * 0.078)];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView];
    
    
    CGFloat leftImgViewW = kWidth * 0.051;
    CGFloat leftImgViewH = baseView.frame.size.height - jiange * 2.0;
    CGFloat leftImgViewX = jianjv;
    CGFloat leftImgViewY = jiange;
    UIImageView *leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(leftImgViewX, leftImgViewY, leftImgViewW, leftImgViewH)];
//    leftImgView.backgroundColor = [UIColor redColor];
    leftImgView.image = [UIImage imageNamed:imgNameLeft];
    [baseView addSubview:leftImgView];
    
    CGFloat labW = 250;
    CGFloat labH = baseView.frame.size.height;
    CGFloat labX = CGRectGetMaxX(leftImgView.frame) + jianjv - 2;
    CGFloat labY = 0;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(labX, labY, labW, labH)];
    lab.text = centerStr;
    lab.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    [baseView addSubview:lab];
    
    CGFloat righntImgViewW = 200;
    CGFloat righntImgViewH = labH;
    CGFloat righntImgViewX = kWidth - jianjv - righntImgViewW;
    CGFloat righntImgViewY = 0;
    UILabel *righntImgView = [[UILabel alloc] initWithFrame:CGRectMake(righntImgViewX, righntImgViewY, righntImgViewW, righntImgViewH)];
    righntImgView.text = rightStr;
    righntImgView.textAlignment = NSTextAlignmentRight;
    righntImgView.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [baseView addSubview:righntImgView];
    
    // 边线
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 1)];
    lineView1.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [baseView addSubview:lineView1];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, baseView.frame.size.height - 1, kWidth, 1)];
    lineView2.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [baseView addSubview:lineView2];
    
    
    [baseView addSubview:button];
}


#pragma mark - 我的订单
- (void)orderBtnClick {

    GFIndentViewController *indentView = [[GFIndentViewController alloc]init];
    [self.navigationController pushViewController:indentView animated:YES];
    
//    NSLog(@"我的订单");
}


#pragma mark - 我的收藏按钮响应方法
- (void)collectBtnClick{
    CLCollectListViewController *collectVC = [[CLCollectListViewController alloc]init];
    [self.navigationController pushViewController:collectVC animated:YES];
    
}


#pragma mark - 合作商加盟
- (void)joinInBtnClick {
    
    [GFHttpTool GetInformationSuccess:^(id responseObject) {
        
//        NSLog(@"---获取商户信息---%@----",responseObject);
        if ([responseObject[@"status"] integerValue] == 1) {
            NSDictionary *dataDictionary = responseObject[@"message"];
            
            GFCooperatingSucViewController *cooperatingView = [[GFCooperatingSucViewController alloc]init];
            
            if (![dataDictionary isKindOfClass:[NSNull class]]) {
                
                cooperatingView.dataDictionary = dataDictionary;
                cooperatingView.setLabel.text = @"审核成功";
                
            }
            
            [self.navigationController pushViewController:cooperatingView animated:YES];

            
        }else{
            [self addAlertView:@"请求失败"];
        }
        
        
    } failure:^(NSError *error) {
        
//        NSLog(@"---请求失败---%@----",error);
//         [self addAlertView:@"请求失败"];
    }];
    
    
    
//    NSLog(@"合作商加盟");
}

#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
}


#pragma mark - 业务员管理
- (void)manageClick {
    
    GFWorkerViewController *workerView = [[GFWorkerViewController alloc]init];
    [self.navigationController pushViewController:workerView animated:YES];

}


#pragma mark - 消息中心
- (void)notificationBtnClick{
    
    GFTransformViewController *transformView = [[GFTransformViewController alloc]init];
    [self.navigationController pushViewController:transformView animated:YES];
    
}


#pragma mark - 修改密码
- (void)changePasswordClick {
    
    GFChangePwdViewController *changePwd = [[GFChangePwdViewController alloc]init];
    [self.navigationController pushViewController:changePwd animated:YES];
//    NSLog(@"修改密码");
}


#pragma mark - 车邻邦专职客服电话
- (void)phoneBtnClick {
    
    [ACETelPrompt callPhoneNumber:@"4001871500" call:^(NSTimeInterval duration) {
//         NSLog(@"User made a call of %.1f seconds", duration);
    } cancel:^{
//          NSLog(@"User cancelled the call");
    }];
    
//    NSLog(@"车邻邦专职客服电话");
}



- (void)leftButClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
