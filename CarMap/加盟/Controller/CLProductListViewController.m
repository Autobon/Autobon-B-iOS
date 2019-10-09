//
//  CLProductListViewController.m
//  CarMapB
//
//  Created by inCarL on 2019/9/25.
//  Copyright © 2019 mll. All rights reserved.
//

#import "GFNavigationView.h"
#import "GFHttpTool.h"
#import "GFTipView.h"
#import "MJRefresh.h"
#import "CLProductListViewController.h"
#import "CLProductTableViewCell.h"
#import "CLProductModel.h"
#import "CLTouchView.h"
#import "CLTouchScrollView.h"
#import "CLPackageListViewController.h"



@interface CLProductListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    
    NSInteger _page;
    NSInteger _pageSize;
    
}

@property (nonatomic, strong) GFNavigationView *navView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) CLTouchView *bgTouchView;

@end

@implementation CLProductListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _page = 1;
    _pageSize = 10;
    
    _dataArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < 50; i++) {
        CLProductModel *productModel = [[CLProductModel alloc]init];
        productModel.cellHeight = 125;
        [_dataArray addObject:productModel];
    }
    
    
    [self setNavigation];
    
    [self setViewForDetail];
    
    
}

- (void)setViewForDetail{
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 添加刷新
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(_navView.mas_bottom);
    }];
    
    [_tableView.mj_header beginRefreshing];
}

- (void)headRefresh {
    
    _page = 1;
    _pageSize = 4;
//    _dataArray = [[NSMutableArray alloc] init];
    
    [self getProductList];
    
}

- (void)footRefresh {
    
    _page = _page + 1;
    _pageSize = 4;
    
    [self getProductList];
}

- (void)getProductList {
    ICLog(@"获取产品列表");
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
    [_tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
//    return 50;
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CLProductModel *productModel = _dataArray[indexPath.row];
    return productModel.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CLProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil){
        cell = [[CLProductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.detailButton.tag = indexPath.row;
    [cell.detailButton addTarget:self action:@selector(cellDetailBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.addButton.tag = indexPath.row;
    [cell.addButton addTarget:self action:@selector(cellAddBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    CLProductModel *productModel = _dataArray[indexPath.row];
    if (productModel.cellHeight == 125){
        cell.detailButton.selected = NO;
        cell.buttonImageView.image = [UIImage imageNamed:@"right"];
    }else{
        cell.detailButton.selected = YES;
        cell.buttonImageView.image = [UIImage imageNamed:@"upImage"];
    }
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


//查看详情按钮相应方法
- (void)cellDetailBtnClick:(UIButton *)button{
    CLProductModel *productModel = _dataArray[button.tag];
    if (productModel.cellHeight == 125){
        productModel.cellHeight = 185;
//        button.selected = NO;
    }else{
        productModel.cellHeight = 125;
//        button.selected = YES;
    }
    ICLog(@"-----cellHeight----%f---", productModel.cellHeight);
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

//添加产品至套餐
- (void)cellAddBtnClick:(UIButton *)button{
    ICLog(@"添加产品至套餐");
    
    _bgTouchView = [[CLTouchView alloc]init];
    _bgTouchView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [self.view addSubview:self.bgTouchView];
    [self.bgTouchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    
    CGFloat scrollViewHeight = 0;
    
    if (button.tag < 7){
        scrollViewHeight = 45 * (button.tag + 2);
    }else{
        scrollViewHeight = 45 * 8;
    }
    
    UIView *baseView = [[UIView alloc]init];
    baseView.backgroundColor = [UIColor whiteColor];
    [_bgTouchView addSubview:baseView];
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.bgTouchView);
        make.height.mas_offset(50 + scrollViewHeight);
    }];
    
    
    
    UILabel *titleLabel = [[UILabel alloc]init];
//    titleLabel.backgroundColor = [UIColor redColor];
    titleLabel.text = @"添加至";
    [baseView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(baseView).offset(25);
        make.right.equalTo(baseView).offset(-25);
        make.height.mas_offset(50);
        make.top.equalTo(baseView);
    }];
    
    CLTouchScrollView *scrollView = [[CLTouchScrollView alloc]init];
    [baseView addSubview:scrollView];
    
    
    for (int i = 0; i < button.tag + 2; i++) {
        
        UIView *contentBaseView = [[UIView alloc]init];
        contentBaseView.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:contentBaseView];
        contentBaseView.frame = CGRectMake(0, 0 + i * 45, self.view.frame.size.width, 45);
        
        UILabel *contentTitleLabel = [[UILabel alloc]init];
        contentTitleLabel.text = [NSString stringWithFormat:@"套餐%d", i + 1];
        [contentBaseView addSubview:contentTitleLabel];
        [contentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentBaseView).offset(25);
            make.centerY.equalTo(contentBaseView);
            
        }];
        
        UIButton *contentButton = [[UIButton alloc]init];
        [contentButton setTitle:@"添加" forState:UIControlStateNormal];
        contentButton.titleLabel.font = [UIFont systemFontOfSize:15];
        contentButton.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        contentButton.layer.cornerRadius = 14;
        [contentBaseView addSubview:contentButton];
        [contentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(contentBaseView).offset(-25);
            make.centerY.equalTo(contentBaseView);
            make.height.mas_offset(28);
            make.width.mas_offset(70);
        }];
        
    }
    
    scrollView.frame = CGRectMake(0, 50, self.view.frame.size.width, scrollViewHeight);
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 45 * (button.tag + 2));
    
    
    
}



// 添加导航
- (void)setNavigation{
    
    _navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:@"" withRightImgHightName:nil withCenterTitle:@"产品列表" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [_navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat viewHeight = 64;
    if ([UIScreen mainScreen].bounds.size.height > 800) {
        viewHeight = 88;
    }
    
    _navView.rightBut.frame = CGRectMake(self.view.frame.size.width - 90, viewHeight - 44, 90, 44);
    [_navView.rightBut setTitle:@"我的套餐" forState:UIControlStateNormal];
    [_navView.rightBut addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:_navView];
    
    
}
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBtnClick{
    CLPackageListViewController *packageListVC = [[CLPackageListViewController alloc]init];
    [self.navigationController pushViewController:packageListVC animated:YES];
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
