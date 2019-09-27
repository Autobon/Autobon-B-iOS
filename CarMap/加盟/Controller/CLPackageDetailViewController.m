//
//  CLPackageDetailViewController.m
//  CarMapB
//
//  Created by inCarL on 2019/9/26.
//  Copyright © 2019 mll. All rights reserved.
//
#import "GFNavigationView.h"
#import "GFHttpTool.h"
#import "GFTipView.h"
#import "CLPackageDetailViewController.h"
#import "CLPackageProductTableViewCell.h"

@interface CLPackageDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@property (nonatomic, strong) GFNavigationView *navView;
@end

@implementation CLPackageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    
    [self setDetailForView];
    
}




- (void)setDetailForView{
    
//    UIView *headerBaseView = [[UIView alloc]init];
//    headerBaseView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:headerBaseView];
//    [headerBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view).offset(0);
//        make.top.equalTo(self.navView.mas_bottom);
//        make.height.mas_offset(50);
//    }];
//
//    UILabel *titleLabel = [[UILabel alloc]init];
//    titleLabel.text = @"套餐一";
//    titleLabel.font = [UIFont boldSystemFontOfSize:17];
//    [headerBaseView addSubview:titleLabel];
//    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(headerBaseView.mas_left).offset(25);
//        make.centerY.equalTo(headerBaseView);
//    }];
    
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.navView.mas_bottom);
    }];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 50;
    //    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CLPackageProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil){
        cell = [[CLPackageProductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}




// 添加导航
- (void)setNavigation{
    self.view.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    
    _navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"套餐一" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
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
