//
//  GFChangePwdViewController.m
//  车邻邦客户端
//
//  Created by 陈光法 on 16/3/7.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFChangePwdViewController.h"
#import "GFNavigationView.h"
#import "GFTextField.h"

@interface GFChangePwdViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    
    CGFloat jiange1;
    CGFloat jiange2;
}

@property (nonatomic, strong) GFNavigationView *navView;

@property (nonatomic, strong) GFTextField *oldPwdTxt;
@property (nonatomic, strong) GFTextField *xinPwdtxt;

@end

@implementation GFChangePwdViewController

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
    
    jiange1 = kHeight * 0.0183;
    jiange2 = kWidth * 0.008;
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"修改密码" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}

- (void)_setView {
    
    
    // 请输入旧密码
    self.oldPwdTxt = [[GFTextField alloc] initWithY:64 + jiange1 withPlaceholder:@"请输入旧密码"];
    _oldPwdTxt.secureTextEntry = YES;
    [self.view addSubview:self.oldPwdTxt];
    
    UIButton *eyeButton = [[UIButton alloc]init];
    eyeButton.frame = CGRectMake(0, 0, 30, 20);
    eyeButton.center = CGPointMake(self.view.frame.size.width - 50, _oldPwdTxt.center.y);
    [eyeButton setBackgroundImage:[UIImage imageNamed:@"eyeClose"] forState:UIControlStateNormal];
    eyeButton.tag = 1;
    [eyeButton addTarget:self action:@selector(eyeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:eyeButton];
    
    
    
    
    // 请输入新密码
    self.xinPwdtxt = [[GFTextField alloc] initWithY:CGRectGetMaxY(self.oldPwdTxt.frame) + jiange2 withPlaceholder:@"请输入新密码"];
    _xinPwdtxt.secureTextEntry = YES;
    [self.view addSubview:self.xinPwdtxt];
    
    
    
    UIButton *eyeButton2 = [[UIButton alloc]init];
    eyeButton2.frame = CGRectMake(0, 0, 30, 20);
    eyeButton2.center = CGPointMake(self.view.frame.size.width - 50, _xinPwdtxt.center.y);
    [eyeButton2 setBackgroundImage:[UIImage imageNamed:@"eyeClose"] forState:UIControlStateNormal];
    eyeButton2.tag = 2;
    [eyeButton2 addTarget:self action:@selector(eyeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:eyeButton2];
    
    
    
    // "密码由8~18位英文字母与数字组成"
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(kWidth * 0.075, CGRectGetMaxY(self.xinPwdtxt.frame) + 10, kWidth - 50, kHeight * 0.021)];
    lab.text = @"密码由8~18位英文字母与数字组成";
    lab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
    lab.font = [UIFont systemFontOfSize:11 / 320.0 * kWidth];
    [self.view addSubview:lab];
    
    // 确认按钮
    CGFloat signInButW = kWidth - (kWidth * 0.116) * 2;
    CGFloat signInButH = kHeight * 0.07;
    CGFloat signInButX = kWidth * 0.116;
    CGFloat signInButY = CGRectGetMaxY(lab.frame) + kHeight * 0.045;
    UIButton *signInBut = [UIButton buttonWithType:UIButtonTypeCustom];
    signInBut.frame = CGRectMake(signInButX, signInButY, signInButW, signInButH);
    signInBut.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    signInBut.layer.cornerRadius = 5;
    [signInBut setTitle:@"提交" forState:UIControlStateNormal];
    [self.view addSubview:signInBut];
    
    
    
}

- (void)leftButClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - 眼睛按钮的响应方法
- (void)eyeBtnClick:(UIButton *)button{
    if (button.tag == 1) {
        if (self.oldPwdTxt.secureTextEntry) {
            [button setBackgroundImage:[UIImage imageNamed:@"eyeOpen"] forState:UIControlStateNormal];
        }else{
            [button setBackgroundImage:[UIImage imageNamed:@"eyeClose"] forState:UIControlStateNormal];
        }
        self.oldPwdTxt.secureTextEntry = !self.oldPwdTxt.secureTextEntry;
    }else{
        if (self.xinPwdtxt.secureTextEntry) {
            [button setBackgroundImage:[UIImage imageNamed:@"eyeOpen"] forState:UIControlStateNormal];
        }else{
            [button setBackgroundImage:[UIImage imageNamed:@"eyeClose"] forState:UIControlStateNormal];
        }
        self.xinPwdtxt.secureTextEntry = !self.xinPwdtxt.secureTextEntry;
        
    }
    
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
