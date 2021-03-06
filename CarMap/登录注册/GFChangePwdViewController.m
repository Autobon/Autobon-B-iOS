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
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"服务中心" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}

- (void)_setView {
    
    
    // 请输入旧密码
    self.oldPwdTxt = [[GFTextField alloc] initWithY:64 + jiange1 withPlaceholder:@"请输入旧密码"];
    [self.view addSubview:self.oldPwdTxt];
    // 请输入新密码
    self.xinPwdtxt = [[GFTextField alloc] initWithY:CGRectGetMaxY(self.oldPwdTxt.frame) + jiange2 withPlaceholder:@"请输入新密码"];
    [self.view addSubview:self.xinPwdtxt];
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
