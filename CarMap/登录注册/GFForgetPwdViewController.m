//
//  GFForgetPwdViewController.m
//  车邻邦客户端
//
//  Created by 陈光法 on 16/3/7.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFForgetPwdViewController.h"
#import "GFNavigationView.h"
#import "GFTextField.h"
//#import "GFHttpTool.h"

@interface GFForgetPwdViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    CGFloat jiange1;
    CGFloat jiange2;
    CGFloat jiange3;
    
    
}

@property (nonatomic, strong) GFNavigationView *navView;
@property (nonatomic, strong) GFTextField *phoneTxt;
@property (nonatomic, strong) GFTextField *verifyTxt;
@property (nonatomic, strong) GFTextField *passwordTxt;

@end

@implementation GFForgetPwdViewController

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
    
    jiange1 = kHeight * 0.0287;
    jiange2 = kHeight * 0.008;
    jiange3 = kHeight * 0.068;
    
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"找回密码" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}

- (void)_setView {
    
    // 请输入手机号
    self.phoneTxt = [[GFTextField alloc] initWithY:64 + jiange1 withPlaceholder:@"请输入手机号"];
    [self.view addSubview:self.phoneTxt];
    
    // 请输入验证码
    self.verifyTxt = [[GFTextField alloc] initWithY:CGRectGetMaxY(self.phoneTxt.frame) + jiange2 withPlaceholder:@"请输入验证码"];
    [self.view addSubview:self.verifyTxt];
    // 获取验证码
    CGFloat getVerifyButW = kWidth * 0.172;
    CGFloat getVerifyButH = kHeight * 0.042;
    CGFloat getVerifyButX = kWidth - getVerifyButW - kWidth * 0.075;
    CGFloat getVerifyButY = (kHeight * 0.078 - getVerifyButH) / 2.0;
    UIButton *getVerifyBut = [UIButton buttonWithType:UIButtonTypeCustom];
    getVerifyBut.frame = CGRectMake(getVerifyButX, getVerifyButY, getVerifyButW, getVerifyButH);
    getVerifyBut.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
    getVerifyBut.layer.borderWidth = 1;
    getVerifyBut.layer.cornerRadius = 5;
    [getVerifyBut setTitle:@"获取验证" forState:UIControlStateNormal];
    [getVerifyBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
    getVerifyBut.titleLabel.font = [UIFont systemFontOfSize:12 / 320.0 * kWidth];
    [self.verifyTxt addSubview:getVerifyBut];
    [getVerifyBut addTarget:self action:@selector(getVerifyButClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 请输入新密码
    self.passwordTxt = [[GFTextField alloc] initWithY:CGRectGetMaxY(self.verifyTxt.frame) + jiange2 withPlaceholder:@"请输入新密码"];
    [self.view addSubview:self.passwordTxt];
    
    
    // 确认按钮
    CGFloat signInButW = kWidth - (kWidth * 0.116) * 2;
    CGFloat signInButH = kHeight * 0.07;
    CGFloat signInButX = kWidth * 0.116;
    CGFloat signInButY = CGRectGetMaxY(self.passwordTxt.frame) + jiange3;
    UIButton *signInBut = [UIButton buttonWithType:UIButtonTypeCustom];
    signInBut.frame = CGRectMake(signInButX, signInButY, signInButW, signInButH);
    signInBut.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    signInBut.layer.cornerRadius = 5;
    [signInBut setTitle:@"确认" forState:UIControlStateNormal];
    [self.view addSubview:signInBut];
    
    
    
    
    
}


- (void)getVerifyButClick:(UIButton *)sender {
    
    NSLog(@"获取验证码");
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
