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
#import "CLProductPackageModel.h"
#import "CLAddPackageViewController.h"
#import "CLPackageTableViewCell.h"


@interface CLPackageListViewController ()<UITableViewDelegate,UITableViewDataSource,CLAddPackageDelegate>

{
    UITableView *_tableView;
    
    NSInteger _page;
    NSInteger _pageSize;
    
}
@property (nonatomic, strong) GFNavigationView *navView;
@property (nonatomic, strong) NSMutableArray *packageArray;

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
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    _pageSize = 40;
    _packageArray = [[NSMutableArray alloc]init];
    
    [self getPackageList];
    
}

- (void)footRefresh {
    
    _page = _page + 1;
    _pageSize = 40;
    
    [self getPackageList];
}

- (void)getPackageList {
    ICLog(@"获取产品列表");
    
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
    dataDict[@"page"] = @(_page);
    dataDict[@"pageSize"] = @(_pageSize);
//    dataDict[@"type"] = @"2";
    [GFHttpTool getProductOfferSetMenuWithParameters:dataDict success:^(id responseObject) {
        ICLog(@"-getProductList--responseObject---%@-", responseObject);
        if ([responseObject[@"status"] integerValue] == 1) {
            NSDictionary *messageDictionary = responseObject[@"message"];
            if ([messageDictionary isKindOfClass:[NSDictionary class]]){
                NSArray *listArray = messageDictionary[@"list"];
                [listArray enumerateObjectsUsingBlock:^(NSDictionary *modelDic, NSUInteger idx, BOOL * _Nonnull stop) {
                    CLProductPackageModel *packageModel = [[CLProductPackageModel alloc]init];
                    [packageModel setModelForDictionary:modelDic];
                    [_packageArray addObject:packageModel];
                }];
            }
        }
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        ICLog(@"-getProductList--error---%@-", error);
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
//    return 50;
    return self.packageArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CLPackageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil){
        cell = [[CLPackageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (self.packageArray.count > indexPath.row){
        CLProductPackageModel *packageModel = self.packageArray[indexPath.row];
        cell.packageNameLabel.text = packageModel.name;
        cell.deleteButton.tag = indexPath.row;
        [cell.deleteButton addTarget:self action:@selector(deletePackageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        if ([packageModel.type isEqualToString:@"1"]){
            cell.deleteButton.hidden = YES;
        }else{
            cell.deleteButton.hidden = NO;
        }
    }
    
//    cell.textLabel.text = [NSString stringWithFormat:@"套餐%ld", indexPath.row + 1];
//    cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.packageArray.count > indexPath.row){
        CLProductPackageModel *packageModel = self.packageArray[indexPath.row];
        CLPackageDetailViewController *packageDetailVC = [[CLPackageDetailViewController alloc]init];
        packageDetailVC.packageModel = packageModel;
        [self.navigationController pushViewController:packageDetailVC animated:YES];
    }
    
}

-(void)deletePackageBtnClick:(UIButton *)button{
    
    if (self.packageArray.count > button.tag){
        CLProductPackageModel *packageModel = self.packageArray[button.tag];
        [GFHttpTool deleteProductOfferSetMenuWithOrderId:packageModel.idString success:^(id responseObject) {
            if ([responseObject[@"status"] integerValue] == 1) {
                [self addAlertView:@"移除成功"];
                [_packageArray removeObjectAtIndex:button.tag];
                [_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:button.tag inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                [self performSelector:@selector(tableViewRoload) withObject:nil afterDelay:0.3];
            }else{
                [self addAlertView:responseObject[@"message"]];
            }
        } failure:^(NSError *error) {
            ICLog(@"-ProductOfferSetMenuAdd--error---%@-", error);
        }];
    }
    
}

-(void)tableViewRoload{
    [_tableView reloadData];
}



// 添加导航
- (void)setNavigation{
    
    _navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:@"" withRightImgHightName:nil withCenterTitle:@"套餐组合" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    CGFloat viewHeight = 64;
    if ([UIScreen mainScreen].bounds.size.height > 800) {
        viewHeight = 88;
    }
    _navView.rightBut.frame = CGRectMake(self.view.frame.size.width - 90, viewHeight - 44, 90, 44);
    [_navView.rightBut setTitle:@"新增套餐" forState:UIControlStateNormal];
    [_navView.rightBut addTarget:self action:@selector(addPackageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view addSubview:_navView];
    
    
}
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

//添加套餐
- (void)addPackageBtnClick{
    CLAddPackageViewController *addPackageVC = [[CLAddPackageViewController alloc]init];
    addPackageVC.delegate = self;
    [self.navigationController pushViewController:addPackageVC animated:YES];
}

#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
}


- (void)addPackageSuccess{
    [_tableView.mj_header beginRefreshing];
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
