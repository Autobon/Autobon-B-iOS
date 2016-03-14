//
//  GFSignUpViewController.m
//  车邻邦客户端
//
//  Created by 陈光法 on 16/3/2.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFSignUpViewController.h"
#import "GFNavigationView.h"
#import "GFTextField.h"
//#import "GFHttpTool.h"

#import "GFJoinInViewController_1.h"



@interface GFSignUpViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    
    CGFloat jiange1;
    CGFloat jiange2;
    CGFloat jiange3;
    CGFloat jiange4;
}

@property (nonatomic, strong) GFNavigationView *navView;

@property (nonatomic, strong) GFTextField *enterpriseNameTxt;
@property (nonatomic, strong) GFTextField *phoneTxt;
@property (nonatomic, strong) GFTextField *verifyTxt;
@property (nonatomic, strong) GFTextField *passwordTxt;
@property (nonatomic, strong) GFTextField *againPwdTxt;

@end

@implementation GFSignUpViewController

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
    jiange3 = kHeight * 0.143;
    jiange4 = kHeight * 0.015625;
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"加盟商" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}

- (void)_setView {
    
    // 企业简称
    self.enterpriseNameTxt = [[GFTextField alloc] initWithY:jiange1 + 64 withPlaceholder:@"企业简称"];
    [self.view addSubview:self.enterpriseNameTxt];
    
    // 请输入您的手机号
    self.phoneTxt = [[GFTextField alloc] initWithY:CGRectGetMaxY(self.enterpriseNameTxt.frame) + jiange2 withPlaceholder:@"请输入您的手机号"];
    [self.view addSubview:self.phoneTxt];
    
    // 验证码
    self.verifyTxt = [[GFTextField alloc] initWithY:CGRectGetMaxY(self.phoneTxt.frame) + jiange2 withPlaceholder:@"验证码"];
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
    
    // 密码
    self.passwordTxt = [[GFTextField alloc] initWithY:CGRectGetMaxY(self.verifyTxt.frame) + jiange2 withPlaceholder:@"密码"];
    [self.view addSubview:self.passwordTxt];
    
    // 确认密码
    self.againPwdTxt = [[GFTextField alloc] initWithY:CGRectGetMaxY(self.passwordTxt.frame) + jiange2 withPlaceholder:@"确认密码"];
    [self.view addSubview:self.againPwdTxt];
    
    // 注册按钮
    CGFloat signUpButW = kWidth - (kWidth * 0.116) * 2;
    CGFloat signUpButH = kHeight * 0.07;
    CGFloat signUpButX = kWidth * 0.116;
    CGFloat signUpButY = CGRectGetMaxY(self.againPwdTxt.frame) + jiange3;
    UIButton *signUpBut = [UIButton buttonWithType:UIButtonTypeCustom];
    signUpBut.frame = CGRectMake(signUpButX, signUpButY, signUpButW, signUpButH);
    signUpBut.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    signUpBut.layer.cornerRadius = 5;
    [signUpBut setTitle:@"注册" forState:UIControlStateNormal];
    [self.view addSubview:signUpBut];
    [signUpBut addTarget:self action:@selector(signUpButClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 车邻邦合作商加盟服务协议
    CGFloat agreeLabW = kWidth;
    CGFloat agreeLabH = kHeight * 0.024;
    CGFloat agreeLabX = 0;
    CGFloat agreeLabY = CGRectGetMaxY(signUpBut.frame) + jiange4;
    UILabel *agreeLab = [[UILabel alloc] initWithFrame:CGRectMake(agreeLabX, agreeLabY, agreeLabW, agreeLabH)];
    [self.view addSubview:agreeLab];
    agreeLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
    agreeLab.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *MAStr = [[NSMutableAttributedString alloc] initWithString:@"点击“注册”代表本人已阅读并同意《车邻邦合作商服务协议》"];
    [MAStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] range:NSMakeRange(16, 12)];
    agreeLab.attributedText = MAStr;
    agreeLab.font = [UIFont systemFontOfSize:10.5 / 320.0 * kWidth];
    agreeLab.userInteractionEnabled = YES;
    
    CGFloat agreeButW = kWidth / 2.0;
    CGFloat agreeButH = agreeLabH;
    CGFloat agreeButX = kWidth / 2.0;
    CGFloat agreeButY = 0;
    UIButton *agreeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    agreeBut.frame = CGRectMake(agreeButX, agreeButY, agreeButW, agreeButH);
    [agreeLab addSubview:agreeBut];
    [agreeBut addTarget:self action:@selector(agreeButClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
}


- (void)agreeButClick {


    NSLog(@"同意");
}


- (void)signUpButClick {

    GFJoinInViewController_1 *joinVC_1 = [[GFJoinInViewController_1 alloc] init];
    [self.navigationController pushViewController:joinVC_1 animated:YES];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
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
