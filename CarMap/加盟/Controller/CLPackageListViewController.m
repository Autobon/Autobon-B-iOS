//
//  CLPackageListViewController.m
//  CarMapB
//
//  Created by inCarL on 2019/9/26.
//  Copyright © 2019 mll. All rights reserved.
//

#import "GFNavigationView.h"
#import "GFHttpTool.h"
#import "GFTipView.h"
#import "MJRefresh.h"
#import "CLPackageListViewController.h"
#import "CLPackageDetailViewController.h"


@interface CLPackageListViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    UITableView *_tableView;
    
    NSInteger _page;
    NSInteger _pageSize;
    
}
@property (nonatomic, strong) GFNavigationView *navView;

@end

@implementation CLPackageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    
    [self getPackageList];
    
}

- (void)footRefresh {
    
    _page = _page + 1;
    _pageSize = 4;
    
    [self getPackageList];
}

- (void)getPackageList {
    ICLog(@"获取产品列表");
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
    [_tableView reloadData];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 50;
//    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"套餐%ld", indexPath.row + 1];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CLPackageDetailViewController *packageDetailVC = [[CLPackageDetailViewController alloc]init];
    [self.navigationController pushViewController:packageDetailVC animated:YES];
    
    
}


// 添加导航
- (void)setNavigation{
    
    _navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"我的套餐" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
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
