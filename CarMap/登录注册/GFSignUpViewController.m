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
#import "GFTipView.h"
#import "GFHttpTool.h"


#import "GFJoinInViewController_1.h"



@interface GFSignUpViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    
    CGFloat jiange1;
    CGFloat jiange2;
    CGFloat jiange3;
    CGFloat jiange4;
    
    NSTimer *_timer;
    NSInteger _time;
    
    UIButton *_getVerifyBut;
    
    
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
    self.phoneTxt.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.phoneTxt];
    
    // 验证码
    self.verifyTxt = [[GFTextField alloc] initWithY:CGRectGetMaxY(self.phoneTxt.frame) + jiange2 withPlaceholder:@"验证码"];
    self.verifyTxt.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.verifyTxt];
    
    // 获取验证码
    CGFloat getVerifyButW = kWidth * 0.172;
    CGFloat getVerifyButH = kHeight * 0.042;
    CGFloat getVerifyButX = kWidth - getVerifyButW - kWidth * 0.075;
    CGFloat getVerifyButY = (kHeight * 0.078 - getVerifyButH) / 2.0;
    _getVerifyBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _getVerifyBut.frame = CGRectMake(getVerifyButX, getVerifyButY + _verifyTxt.frame.origin.y, getVerifyButW, getVerifyButH);
    _getVerifyBut.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
    _getVerifyBut.layer.borderWidth = 1;
    _getVerifyBut.layer.cornerRadius = 5;
    [_getVerifyBut setTitle:@"获取验证" forState:UIControlStateNormal];
    [_getVerifyBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
    _getVerifyBut.titleLabel.font = [UIFont systemFontOfSize:12 / 320.0 * kWidth];
    [self.view addSubview:_getVerifyBut];
    [_getVerifyBut addTarget:self action:@selector(getVerifyButClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 密码
    self.passwordTxt = [[GFTextField alloc] initWithY:CGRectGetMaxY(self.verifyTxt.frame) + jiange2 withPlaceholder:@"密码"];
    self.passwordTxt.secureTextEntry = YES;
    [self.view addSubview:self.passwordTxt];
    
    UIButton *eyeButton = [[UIButton alloc]init];
    eyeButton.frame = CGRectMake(0, 0, 30, 20);
    eyeButton.center = CGPointMake(_getVerifyBut.center.x, _passwordTxt.center.y);
    [eyeButton setBackgroundImage:[UIImage imageNamed:@"eyeClose"] forState:UIControlStateNormal];
    eyeButton.tag = 1;
    [eyeButton addTarget:self action:@selector(eyeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:eyeButton];
    
    
    
    // 确认密码
    self.againPwdTxt = [[GFTextField alloc] initWithY:CGRectGetMaxY(self.passwordTxt.frame) + jiange2 withPlaceholder:@"确认密码"];
    self.againPwdTxt.secureTextEntry = YES;
    [self.view addSubview:self.againPwdTxt];
    
    
    UIButton *eyeButton2 = [[UIButton alloc]init];
    eyeButton2.frame = CGRectMake(0, 0, 30, 20);
    eyeButton2.center = CGPointMake(_getVerifyBut.center.x, _againPwdTxt.center.y);
    [eyeButton2 setBackgroundImage:[UIImage imageNamed:@"eyeClose"] forState:UIControlStateNormal];
    eyeButton2.tag = 2;
    [eyeButton2 addTarget:self action:@selector(eyeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:eyeButton2];
    
    
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


#pragma mark - 眼睛按钮的响应方法
- (void)eyeBtnClick:(UIButton *)button{
    if (button.tag == 1) {
        if (self.passwordTxt.secureTextEntry) {
            [button setBackgroundImage:[UIImage imageNamed:@"eyeOpen"] forState:UIControlStateNormal];
        }else{
            [button setBackgroundImage:[UIImage imageNamed:@"eyeClose"] forState:UIControlStateNormal];
        }
        self.passwordTxt.secureTextEntry = !self.passwordTxt.secureTextEntry;
    }else{
        if (self.againPwdTxt.secureTextEntry) {
            [button setBackgroundImage:[UIImage imageNamed:@"eyeOpen"] forState:UIControlStateNormal];
        }else{
            [button setBackgroundImage:[UIImage imageNamed:@"eyeClose"] forState:UIControlStateNormal];
        }
        self.againPwdTxt.secureTextEntry = !self.againPwdTxt.secureTextEntry;
        
    }
    
}


#pragma mark - 获取验证码按钮响应方法
- (void)getVerifyButClick:(UIButton *)button{
    
    if ([self isPhoneNumber:_phoneTxt.text]) {
        button.userInteractionEnabled = NO;
        [GFHttpTool codeGetParameters:@{@"phone":_phoneTxt.text} success:^(id responseObject) {
            
            NSLog(@"－－－请求成功－－%@-",responseObject);
            if ([responseObject[@"result"] integerValue] == 1) {
                
//                [button setTitle:@"60" forState:UIControlStateNormal];
                if (_timer == nil) {
                    _time = 60;
                    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showTime) userInfo:nil repeats:YES];
                }
                
            }else{
                [self addAlertView:responseObject[@"message"]];
            }
        } failure:^(NSError *error) {
            
            NSLog(@"----请求失败--%@----",error);
            
        }];
    }else{
        [self addAlertView:@"请输入合法手机号"];
    }
    
    
}

#pragma mark - 定时器倒计时方法
- (void)showTime {
    
    if(_time != 0 ) {
        
        
        [_getVerifyBut setTitle:[NSString stringWithFormat:@"(%ld)秒", --_time] forState:UIControlStateNormal];
        
    }else {
        
        [_getVerifyBut setTitle:@"再次获取" forState:UIControlStateNormal];
        _getVerifyBut.userInteractionEnabled = YES;
        [_timer invalidate];
        _timer = nil;
    }
    
    
}



- (void)agreeButClick {


    NSLog(@"同意");
}



#pragma mark - 注册按钮的响应方法
- (void)signUpButClick {

    
//    [self addAlertView:@"注册按钮点击了"];
    
    
    
    if (_enterpriseNameTxt.text.length == 0) {
        [self addAlertView:@"请输入企业简称"];
    }else{
        if (_phoneTxt.text.length != 11) {
            [self addAlertView:@"请输入合法手机号"];
        }else{
            if (_verifyTxt.text.length != 6) {
                [self addAlertView:@"请输入正确验证码"];
            }else{
                if (_passwordTxt.text.length == 0) {
                    [self addAlertView:@"请输入密码"];
                }else{
                    if ([self isPassword:_passwordTxt.text]) {
                        if (_againPwdTxt.text.length == 0) {
                            [self addAlertView:@"请确认密码"];
                        }else{
                            if ([_passwordTxt.text isEqualToString:_againPwdTxt.text]) {
                                
                                NSDictionary *dictionary = @{@"shortname":_enterpriseNameTxt.text,@"phone":_phoneTxt.text,@"password":_passwordTxt.text,@"verifySms":_verifyTxt.text};
//                                NSLog(@"-----dictionary---%@---",dictionary);
                                [GFHttpTool postRegisterParameters:dictionary success:^(id responseObject) {
                                    NSLog(@"－－－请求成功－－%@-",responseObject[@"message"]);
                                    if ([responseObject[@"result"] integerValue] == 1) {
                                        
                                        [UIView animateWithDuration:2 animations:^{
                                            
                                            [self tipView:kHeight * 0.8 withTipmessage:@"注册成功"];                                            
                                        } completion:^(BOOL finished) {
                                            GFJoinInViewController_1 *joinVC_1 = [[GFJoinInViewController_1 alloc] init];
                                            [self.navigationController pushViewController:joinVC_1 animated:YES];
                                            
                                        }];
                                        
                                        

                                    }else{
                                        [self addAlertView:responseObject[@"message"]];
                                    }
    
                                } failure:^(NSError *error) {
                                    NSLog(@"----请求失败--%@----",error);
                                }];
                                
                            }else{
                                [self addAlertView:@"两次密码不一致"];
                            }
                        }
                        
                    }else{
                        [self addAlertView:@"密码由子母数组组成，8-18位"];
                    }  
                }
            }
        }
    }
}



#pragma mark - 有延迟回调方法的提示框
- (void)tipView:(CGFloat)tipviewY withTipmessage:(NSString *)messageStr {
    
    NSString *str = messageStr;
    NSMutableDictionary *attDic = [[NSMutableDictionary alloc] init];
    attDic[NSFontAttributeName] = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    attDic[NSForegroundColorAttributeName] = [UIColor whiteColor];
    CGRect strRect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attDic context:nil];
    
    CGFloat tipViewW = strRect.size.width + 30;
    CGFloat tipViewH = kHeight * 0.0625;
    CGFloat tipViewX = (kWidth - tipViewW) / 2.0;
    CGFloat tipViewY = tipviewY;
    UIView *tipView = [[UIView alloc] initWithFrame:CGRectMake(tipViewX, tipViewY, tipViewW, tipViewH)];
    tipView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    tipView.layer.cornerRadius = 7.5;
    [self.view addSubview:tipView];
    
    CGFloat msgLabW = tipViewW;
    CGFloat msgLabH = tipViewH;
    CGFloat msgLabX = 0;
    CGFloat msgLabY = 0;
    UILabel *msgLab = [[UILabel alloc] initWithFrame:CGRectMake(msgLabX, msgLabY, msgLabW, msgLabH)];
    msgLab.text = messageStr;
    [tipView addSubview:msgLab];
    msgLab.textAlignment = NSTextAlignmentCenter;
    msgLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    msgLab.textColor = [UIColor whiteColor];
    
}



#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
}


#pragma mark - 判断输入字符串是否是手机号
- (BOOL)isPhoneNumber:(NSString *)number{
    
    number =  [number stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:number] == YES)
        || ([regextestcm evaluateWithObject:number] == YES)
        || ([regextestct evaluateWithObject:number] == YES)
        || ([regextestcu evaluateWithObject:number] == YES))
    {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark - 判断密码是否符合要求
- (BOOL)isPassword:(NSString *)password{
    NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,18}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
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
