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
#import "GFHttpTool.h"
#import "GFTipView.h"



@interface GFForgetPwdViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    CGFloat jiange1;
    CGFloat jiange2;
    CGFloat jiange3;
    
    NSTimer *_timer;
    NSInteger _time;
    
    
    UIButton *_getVerifyBut;
    
    
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
    self.phoneTxt.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.phoneTxt];
    
    // 请输入验证码
    self.verifyTxt = [[GFTextField alloc] initWithY:CGRectGetMaxY(self.phoneTxt.frame) + jiange2 withPlaceholder:@"请输入验证码"];
    self.verifyTxt.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.verifyTxt];
    // 获取验证码
    CGFloat getVerifyButW = kWidth * 0.172;
    CGFloat getVerifyButH = kHeight * 0.042;
    CGFloat getVerifyButX = kWidth - getVerifyButW - kWidth * 0.075;
    CGFloat getVerifyButY = (kHeight * 0.078 - getVerifyButH) / 2.0;
    _getVerifyBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _getVerifyBut.frame = CGRectMake(getVerifyButX, getVerifyButY + self.verifyTxt.frame.origin.y, getVerifyButW, getVerifyButH);
    _getVerifyBut.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
    _getVerifyBut.layer.borderWidth = 1;
    _getVerifyBut.layer.cornerRadius = 5;
    [_getVerifyBut setTitle:@"获取验证" forState:UIControlStateNormal];
    [_getVerifyBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
    _getVerifyBut.titleLabel.font = [UIFont systemFontOfSize:12 / 320.0 * kWidth];
    [self.view addSubview:_getVerifyBut];
    [_getVerifyBut addTarget:self action:@selector(getVerifyButClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 请输入新密码
    self.passwordTxt = [[GFTextField alloc] initWithY:CGRectGetMaxY(self.verifyTxt.frame) + jiange2 withPlaceholder:@"请输入新密码"];
    self.passwordTxt.secureTextEntry = YES;
    [self.view addSubview:self.passwordTxt];
    
    UIButton *eyeButton = [[UIButton alloc]init];
    eyeButton.frame = CGRectMake(0, 0, kWidth * 0.09, kHeight * 0.025);
    eyeButton.center = CGPointMake(_getVerifyBut.center.x, _passwordTxt.center.y);
    [eyeButton setBackgroundImage:[UIImage imageNamed:@"eyeClose"] forState:UIControlStateNormal];
    [eyeButton addTarget:self action:@selector(eyeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:eyeButton];
    
    
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
    [signInBut addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:signInBut];
    
    
    
    
    
}

#pragma mark - 找回密码确认按钮
- (void)submitBtnClick{
    [self.view endEditing:YES];
    if (_phoneTxt.text.length != 11) {
        [self addAlertView:@"请填写合法手机号"];
    }else{
        if (_verifyTxt.text.length != 6) {
            [self addAlertView:@"验证码不正确"];
        }else{
            if ([self isPassword:_passwordTxt.text]) {
                NSDictionary *dictionary = @{@"phone":_phoneTxt.text,@"password":_passwordTxt.text,@"verifySms":_verifyTxt.text};
                [GFHttpTool postForgetPwdParameters:dictionary success:^(id responseObject) {
                    NSLog(@"－－－－请求成功－－%@",responseObject);
                    
                    if ([responseObject[@"result"] integerValue] == 1) {
                        [UIView animateWithDuration:2 animations:^{
                            
                            [self tipView:kHeight * 0.8 withTipmessage:@"密码找回成功"];
                            
                        } completion:^(BOOL finished) {
                            
                            [self.navigationController popViewControllerAnimated:YES];
                            
                        }];
                    }else{
                        [self addAlertView:responseObject[@"message"]];
                    }
                    
                    
                    
                    
                    
                } failure:^(NSError *error) {
                    NSLog(@"----error--%@--",error);
                }];
                  
            }else{
                [self addAlertView:@"密码由字母数字组成，8-18位"];
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








#pragma mark - 判断密码是否符合要求
- (BOOL)isPassword:(NSString *)password{
    NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,18}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}


#pragma mark - 获取验证码按钮响应方法
- (void)getVerifyButClick:(UIButton *)button{
    
    NSLog(@"----------");
    [self.view endEditing:YES];
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
            [self addAlertView:@"请求失败"];
        }];
    }else{
        [self addAlertView:@"请输入合法手机号"];
    }
    
    
}

#pragma mark - 判断输入字符串是否是手机号
- (BOOL)isPhoneNumber:(NSString *)number{
    
    number =  [number stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$";

    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    if ([phoneTest evaluateWithObject:number])
    {
        return YES;
    }else{
        return NO;
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

#pragma mark - 眼睛按钮的响应方法
- (void)eyeBtnClick:(UIButton *)button{
        if (self.passwordTxt.secureTextEntry) {
            [button setBackgroundImage:[UIImage imageNamed:@"eyeOpen"] forState:UIControlStateNormal];
        }else{
            [button setBackgroundImage:[UIImage imageNamed:@"eyeClose"] forState:UIControlStateNormal];
        }
        self.passwordTxt.secureTextEntry = !self.passwordTxt.secureTextEntry;
}



#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
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
