//
//  CLSearchOrderViewController.m
//  CarMapB
//
//  Created by inCar on 2018/6/14.
//  Copyright © 2018年 mll. All rights reserved.
//

#import "CLSearchOrderViewController.h"
#import "GFNavigationView.h"
#import "CLLineTextFieldView.h"


@interface CLSearchOrderViewController ()<UITextFieldDelegate>
{
    CGFloat kWidth;
    CGFloat kHeight;
    
    
    
}


@property (nonatomic, strong) GFNavigationView *navView;

@end

@implementation CLSearchOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _setBase];
    
    [self setViewUI];
    
}


- (void)setViewUI{
    CLLineTextFieldView *statusTextFieldView = [[CLLineTextFieldView alloc]initWithTitle:@"状态" width:100];
    statusTextFieldView.backgroundColor = [UIColor clearColor];
    statusTextFieldView.titleLabel.textColor = [UIColor blackColor];
    statusTextFieldView.textField.delegate = self;
    statusTextFieldView.textField.tag = 1;
    [self.view addSubview:statusTextFieldView];
    [statusTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom).offset(7);
        make.left.equalTo(self.view).offset(0);
        make.height.mas_offset(45);
        make.right.equalTo(self.view).offset(0);
    }];
    
    CLLineTextFieldView *timeTextFieldView = [[CLLineTextFieldView alloc]initWithTitle:@"预约施工时间" width:100];
    timeTextFieldView.backgroundColor = [UIColor clearColor];
    timeTextFieldView.titleLabel.textColor = [UIColor blackColor];
    timeTextFieldView.textField.delegate = self;
    timeTextFieldView.textField.tag = 2;
    [self.view addSubview:timeTextFieldView];
    [timeTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(statusTextFieldView.mas_bottom).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.height.mas_offset(45);
        make.right.equalTo(self.view).offset(0);
    }];
    
    CLLineTextFieldView *carJiaHaoTextFieldView = [[CLLineTextFieldView alloc]initWithTitle:@"车架号" width:100];
    carJiaHaoTextFieldView.backgroundColor = [UIColor clearColor];
    carJiaHaoTextFieldView.titleLabel.textColor = [UIColor blackColor];
    carJiaHaoTextFieldView.textField.keyboardType = UIKeyboardTypeNumberPad;
    carJiaHaoTextFieldView.textField.delegate = self;
    carJiaHaoTextFieldView.textField.tag = 3;
    [self.view addSubview:carJiaHaoTextFieldView];
    [carJiaHaoTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeTextFieldView.mas_bottom).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.height.mas_offset(45);
        make.right.equalTo(self.view).offset(0);
    }];
    
    CLLineTextFieldView *phoneTextFieldView = [[CLLineTextFieldView alloc]initWithTitle:@"下单人手机号" width:100];
    phoneTextFieldView.backgroundColor = [UIColor clearColor];
    phoneTextFieldView.titleLabel.textColor = [UIColor blackColor];
    carJiaHaoTextFieldView.textField.keyboardType = UIKeyboardTypeNumberPad;
    phoneTextFieldView.textField.delegate = self;
    phoneTextFieldView.textField.tag = 4;
    [self.view addSubview:phoneTextFieldView];
    [phoneTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(carJiaHaoTextFieldView.mas_bottom).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.height.mas_offset(45);
        make.right.equalTo(self.view).offset(0);
    }];
    
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    searchButton.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    searchButton.layer.cornerRadius = 5;
    [searchButton setTitle:@"查询" forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:searchButton];
    [searchButton addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(phoneTextFieldView.mas_bottom).offset(30);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_offset(40);
    }];
    
    
}


- (void)searchBtnClick{
    
    ICLog(@"search button click");
    
    
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if(textField.tag == 1){
        
        return NO;
    }else if(textField.tag == 2){
        
        return NO;
    }
    return YES;
}



- (void)setSelectViewWithTitle:(NSString *)titleString titleArray:(NSArray *)titleArray{
    
}


- (void)_setBase {
    
    kWidth = [UIScreen mainScreen].bounds.size.width;
    kHeight = [UIScreen mainScreen].bounds.size.height;
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"订单查询" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}



- (void)leftButClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
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
