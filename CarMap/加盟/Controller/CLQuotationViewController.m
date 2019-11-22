//
//  CLQuotationViewController.m
//  CarMapB
//
//  Created by inCarL on 2019/11/8.
//  Copyright © 2019 mll. All rights reserved.
//
#import "GFNavigationView.h"
#import "GFHttpTool.h"
#import "GFTipView.h"
#import "CLQuotationViewController.h"
#import "GraphView.h"


@interface CLQuotationViewController ()

@property (nonatomic, strong) GFNavigationView *navView;
@property (strong, nonatomic) GraphView *graphView;


@end

@implementation CLQuotationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigation];
    
    
    [self setViewForDetail];
    
}

- (void)setViewForDetail{
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.navView.mas_bottom).offset(0);
        make.height.mas_offset(440);
    }];
    scrollView.contentSize = CGSizeMake((self.view.frame.size.width/4)*(8), 410);
    
    _graphView = [[GraphView alloc]initWithFrame:CGRectMake(self.view.frame.size.width *0.125, 0, (self.view.frame.size.width/4)*(8-1), 410)];
//    [_graphView setBackgroundColor:[UIColor yellowColor]];
    [_graphView setSpacing:self.view.frame.size.width/4];
    [_graphView setFill:NO];
    [_graphView setStrokeColor:[UIColor redColor]];
    [_graphView setZeroLineStrokeColor:[UIColor whiteColor]];
//    [_graphView setFillColor:[UIColor orangeColor]];
    [_graphView setLineWidth:2];
    [_graphView setCurvedLines:YES];
    [scrollView addSubview:_graphView];
    
    
    
    
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:@"添加" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.frame = CGRectMake(100, 500, self.view.frame.size.width - 200, 40);
    button.backgroundColor = [UIColor blueColor];
    
    
}

- (void)btnClick{
    float low_bound = -200.00;
    float high_bound = 200.00;
    float rndValue = (((float)arc4random()/0x100000000)*(high_bound-low_bound)+low_bound);
    int intRndValue = (int)(rndValue + 0.6);
    
    [_graphView setPoint:intRndValue];
}




// 添加导航
- (void)setNavigation{
    self.view.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    
    _navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"当前行情" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
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




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
