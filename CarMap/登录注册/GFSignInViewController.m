//
//  GFSignInViewController.m
//  车邻邦客户端
//
//  Created by 陈光法 on 16/3/1.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFSignInViewController.h"
#import "GFNavigationView.h"
#import "GFTextField.h"
//#import "GFHttpTool.h"
#import "GFSignUpViewController.h"

#import "GFForgetPwdViewController.h"


@interface GFSignInViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    CGFloat jiange1;
}

@property (nonatomic, strong) GFNavigationView *navView;

@property (nonatomic, strong) GFTextField *enterpriseTxt;
@property (nonatomic, strong) GFTextField *phoneTxt;
@property (nonatomic, strong) GFTextField *passwordTxt;

@end

@implementation GFSignInViewController

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
    
    jiange1 = kHeight * 0.008;
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    

}

- (void)_setView {
    
    
    // LOGO图片
    CGFloat logoImgViewW = kWidth * 0.23;
    CGFloat logoImgViewH = kHeight * 0.068;
    CGFloat logoImgViewX = (kWidth - logoImgViewW) * 0.5;
    CGFloat logoImgViewY = kHeight * 0.141 + 20;
    UIImageView *logoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(logoImgViewX, logoImgViewY, logoImgViewW, logoImgViewH)];
    [self.view addSubview:logoImgView];
    logoImgView.backgroundColor = [UIColor redColor];
    
    // 企业简称
    self.enterpriseTxt = [[GFTextField alloc] initWithY:CGRectGetMaxY(logoImgView.frame) + kHeight * 0.091 withPlaceholder:@"企业简称"];
    [self.view addSubview:self.enterpriseTxt];
    
    // 手机号
    self.phoneTxt = [[GFTextField alloc] initWithY:CGRectGetMaxY(self.enterpriseTxt.frame) + jiange1 withPlaceholder:@"请输入您的手机号"];
    [self.view addSubview:self.phoneTxt];
    
    // 密码
    self.passwordTxt = [[GFTextField alloc] initWithY:CGRectGetMaxY(self.phoneTxt.frame) + jiange1 withPlaceholder:@"请输入您的密码"];
    [self.view addSubview:self.passwordTxt];
    
    // 登录按钮
    CGFloat signInButW = kWidth - (kWidth * 0.116) * 2;
    CGFloat signInButH = kHeight * 0.07;
    CGFloat signInButX = kWidth * 0.116;
    CGFloat signInButY = CGRectGetMaxY(self.passwordTxt.frame) + kHeight * 0.0443;
    UIButton *signInBut = [UIButton buttonWithType:UIButtonTypeCustom];
    signInBut.frame = CGRectMake(signInButX, signInButY, signInButW, signInButH);
    signInBut.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    signInBut.layer.cornerRadius = 5;
    [signInBut setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:signInBut];
    [signInBut addTarget:self action:@selector(signInButClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 边线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight - kHeight * 0.073, kWidth, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [self.view addSubview:lineView];
    
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame), kWidth, kHeight * 0.073)];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView];
    // 忘记密码
    UIButton *forgetBut = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetBut.frame = CGRectMake(0, 0, kWidth * 0.514, baseView.frame.size.height);
    [forgetBut setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetBut setTitleColor:[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] forState:UIControlStateNormal];
    [baseView addSubview:forgetBut];
    forgetBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    forgetBut.titleLabel.font = [UIFont systemFontOfSize:12 / 320.0 * kWidth];
    [forgetBut addTarget:self action:@selector(forgetButClick) forControlEvents:UIControlEventTouchUpInside];
    // 注册
    UIButton *signUpBut = [UIButton buttonWithType:UIButtonTypeCustom];
    signUpBut.frame = CGRectMake(CGRectGetMaxX(forgetBut.frame) + kWidth * 0.06, 0, kWidth - CGRectGetMaxX(forgetBut.frame) + kWidth * 0.06, kHeight * 0.073);
    [signUpBut setTitle:@"注册" forState:UIControlStateNormal];
    [signUpBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
    [baseView addSubview:signUpBut];
    signUpBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    signUpBut.titleLabel.font = [UIFont systemFontOfSize:12 / 320.0 * kWidth];
    [signUpBut addTarget:self action:@selector(signUpButCliclk) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)signInButClick {

    
}

- (void)forgetButClick {
    
    [self.navigationController pushViewController:[[GFForgetPwdViewController alloc] init] animated:YES];
}

-(void)signUpButCliclk {

    GFSignUpViewController *signUpVC = [[GFSignUpViewController alloc] init];
    [self.navigationController pushViewController:signUpVC animated:YES];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
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
