//
//  CLAddPackageViewController.m
//  CarMapB
//
//  Created by inCarL on 2019/10/9.
//  Copyright © 2019 mll. All rights reserved.
//
#import "GFNavigationView.h"
#import "GFHttpTool.h"
#import "GFTipView.h"
#import "CLAddPackageViewController.h"
#import "GFTextField.h"


@interface CLAddPackageViewController ()

@property (nonatomic, strong) GFNavigationView *navView;
@property (nonatomic, strong) GFTextField *nameTxt;

@end

@implementation CLAddPackageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigation];
    
    [self setDetailForView];
}

- (void)setDetailForView{
    
    // 请输入套餐名
    self.nameTxt = [[GFTextField alloc] initWithY: 100 withPlaceholder:@"请输入套餐名"];
    [self.view addSubview:self.nameTxt];
    
    // 提交按钮
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(20, 200, self.view.frame.size.width - 40, 50);
    submitButton.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    submitButton.layer.cornerRadius = 5;
    [submitButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.view addSubview:submitButton];
    [submitButton addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)submitBtnClick{
    [self.view endEditing:YES];
    if (_nameTxt.text.length < 1) {
        [self addAlertView:@"请输入套餐名"];
        return;
    }
    
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
    dataDict[@"name"] = self.nameTxt.text;
    ICLog(@"----dataDict---%@---", dataDict);
    [GFHttpTool postProductOfferSetMenuCreateWithParameters:dataDict success:^(id responseObject) {
        ICLog(@"-ProductOfferSetMenuAdd--responseObject---%@-", responseObject);
        if ([responseObject[@"status"] integerValue] == 1) {
            [self addAlertView:@"添加成功"];
            if (_delegate != nil){
                [_delegate addPackageSuccess];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self addAlertView:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        ICLog(@"-ProductOfferSetMenuAdd--error---%@-", error);
    }];
}

// 添加导航
- (void)setNavigation{
    self.view.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    
    _navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"添加套餐" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [_navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view addSubview:_navView];
    
    
}
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
