//
//  GFAddWorkerViewController.m
//  车邻邦客户端
//
//  Created by 陈光法 on 16/3/4.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFAddWorkerViewController.h"
#import "GFNavigationView.h"
#import "GFTextField.h"
#import "GFButton.h"


@interface GFAddWorkerViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    CGFloat jiange1;
    CGFloat jiange2;
}

@property (nonatomic, strong) GFNavigationView *navView;

@property (nonatomic, strong) GFTextField *phoneTxt;
@property (nonatomic, strong) GFTextField *nameTxt;


@end

@implementation GFAddWorkerViewController

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
    
    jiange1 = kHeight * 0.026;
    jiange2 = kHeight * 0.011;
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"新增账户" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}

- (void)_setView {
    
    // 请输入手机号
    self.phoneTxt = [[GFTextField alloc] initWithY:64 + jiange1 withPlaceholder:@"请输入手机号"];
    [self.view addSubview:self.phoneTxt];
    
    // 请输入姓名
    self.nameTxt = [[GFTextField alloc] initWithY:CGRectGetMaxY(self.phoneTxt.frame) + jiange2 withPlaceholder:@"请输入姓名"];
    [self.view addSubview:self.nameTxt];
    
    // 男、、女
    UIView *baseView1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nameTxt.frame) + jiange2, kWidth, kHeight * 0.078)];
    baseView1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView1];
    // 边线
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 1)];
    lineView1.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [baseView1 addSubview:lineView1];
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight * 0.078 - 1, kWidth, 1)];
    lineView2.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [baseView1 addSubview:lineView2];
    UIView *manView = [self messageButView:@"男" withSelected:YES withX:kWidth * 0.075 withY:(kHeight * 0.078 - kWidth * 0.051) * 0.5];
    [baseView1 addSubview:manView];
    UIView *womanView = [self messageButView:@"女" withSelected:NO withX:kWidth * 0.5 withY:(kHeight * 0.078 - kWidth * 0.051) * 0.5];
    [baseView1 addSubview:womanView];

    
//    // 业务员、、管理员
//    UIView *baseView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(baseView1.frame) + jiange2, kWidth, kHeight * 0.078)];
//    baseView2.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:baseView2];
//    // 边线
//    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 1)];
//    lineView3.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
//    [baseView2 addSubview:lineView3];
//    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight * 0.078 - 1, kWidth, 1)];
//    lineView4.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
//    [baseView2 addSubview:lineView4];
//    UIView *yewuView = [self messageButView:@"业务员" withSelected:YES withX:kWidth * 0.075 withY:(kHeight * 0.078 - kWidth * 0.051) * 0.5];
//    [baseView2 addSubview:yewuView];
//    UIView *guanliview = [self messageButView:@"管理员" withSelected:YES withX:kWidth * 0.5 withY:(kHeight * 0.078 - kWidth * 0.051) * 0.5];
//    [baseView2 addSubview:guanliview];
    
    // 确认按钮
    CGFloat signInButW = kWidth - (kWidth * 0.116) * 2;
    CGFloat signInButH = kHeight * 0.07;
    CGFloat signInButX = kWidth * 0.116;
    CGFloat signInButY = CGRectGetMaxY(baseView1.frame) + kHeight * 0.165;
    UIButton *signInBut = [UIButton buttonWithType:UIButtonTypeCustom];
    signInBut.frame = CGRectMake(signInButX, signInButY, signInButW, signInButH);
    signInBut.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    signInBut.layer.cornerRadius = 5;
    [signInBut setTitle:@"确认" forState:UIControlStateNormal];
    [signInBut addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signInBut];
    
    // 点击“提交”
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(signInBut.frame) + 15, kWidth, kHeight * 0.021)];
    lab.text = @"点击“提交”后会以短信的方式邀请该用户开通账号";
    lab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
    lab.font = [UIFont systemFontOfSize:11 / 320.0 * kWidth];
    lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab];
    
}

#pragma mark - 确认按钮的响应方法
- (void)submitBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}



- (UIView *)messageButView:(NSString *)messageStr withSelected:(BOOL)select withX:(CGFloat)x withY:(CGFloat)y{
    
    UIButton *imgBut = [UIButton buttonWithType:UIButtonTypeCustom];
    imgBut.frame = CGRectMake(0, 0, kWidth * 0.051, kWidth * 0.051);
    [imgBut setImage:[UIImage imageNamed:@"over"] forState:UIControlStateNormal];
    [imgBut setImage:[UIImage imageNamed:@"overClick"] forState:UIControlStateSelected];
    imgBut.selected = select;
    imgBut.tag = select +1;
    [imgBut addTarget:self action:@selector(imgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    imgBut.backgroundColor = [UIColor redColor];
    
    NSString *fenStr = messageStr;
    NSMutableDictionary *fenDic = [[NSMutableDictionary alloc] init];
    fenDic[NSFontAttributeName] = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    fenDic[NSForegroundColorAttributeName] = [UIColor blackColor];
    CGRect fenRect = [fenStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fenDic context:nil];
    CGFloat labW = fenRect.size.width;
    CGFloat labH = kWidth * 0.051;
    CGFloat labX = jiange1 / 2.0 + kWidth * 0.051;
    CGFloat labY = 0;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(labX, labY, labW, labH)];
    lab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    lab.text = messageStr;
    
    CGFloat baseViewW = labX + labW;
    CGFloat baseViewH = labH;
    CGFloat baseViewX = x;
    CGFloat baseViewY = y;
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
    
    [baseView addSubview:imgBut];
    [baseView addSubview:lab];
    
    return baseView;
}


#pragma mark - 男女性别选择按钮
- (void)imgBtnClick:(UIButton *)button{
    button.selected = YES;
    if (button.tag == 1) {
        UIButton *otherBtn = (UIButton *)[self.view viewWithTag:2];
        otherBtn.selected = NO;
    }else{
        UIButton *otherBtn = (UIButton *)[self.view viewWithTag:1];
        otherBtn.selected = NO;
    }
    
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
