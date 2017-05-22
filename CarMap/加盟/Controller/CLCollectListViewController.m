//
//  CLAddPersonViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/25.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLCollectListViewController.h"
#import "GFNavigationView.h"
#import "CLPersonTableViewCell.h"
#import "GFHttpTool.h"
#import "CLAddPersonModel.h"
#import "UIImageView+WebCache.h"
#import "GFTipView.h"
#import "MJRefresh.h"
#import "GFDetailPeoViewController.h"




@interface CLCollectListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_addPersonArray;
    UITableView *_tableView;
    
    
    
    NSInteger _page;
    NSInteger _pageSize;
    
    NSInteger _flage;
}

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CLCollectListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _page = 1;
    _pageSize = 10;
    _flage = 0;
    
    self.dataArray = [[NSMutableArray alloc] init];
    
    _addPersonArray = [[NSMutableArray alloc]init];
    
    [self setNavigation];
    
    [self setViewForAdd];
    
    self.view.backgroundColor = [UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0];
}

- (void)setViewForAdd{
    
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 添加刷新
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    [self.view addSubview:_tableView];
    
    [_tableView.header beginRefreshing];
}

- (void)getFavoriteList {
    
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    mDic[@"page"] = @(_page);
    mDic[@"pageSize"] = @(_pageSize);
    
    [GFHttpTool favoriteTechnicianGetWithParameters:mDic success:^(id responseObject) {
        
        ICLog(@"====技师列表数据====%@", responseObject);
        
            
        
            NSArray *arr = responseObject[@"list"];
            for(int i=0; i<arr.count; i++) {
                NSDictionary *dic = arr[i];
                CLAddPersonModel *model = [[CLAddPersonModel alloc] initWithDictionary:dic[@"technician"]];
                [self.dataArray addObject:model];
            }
            
            [_tableView reloadData];
        
        
        
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
        
    } failure:^(NSError *error) {
        
        
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
    }];
}




- (void)headRefresh {
    
    _page = 1;
    _pageSize = 4;
    _dataArray = [[NSMutableArray alloc] init];
    
    [self getFavoriteList];
    
}

- (void)footRefresh {
    
    _page = _page + 1;
    _pageSize = 4;
    
    [self getFavoriteList];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 125;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CLPersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[CLPersonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
        [cell.zhipaiBut setTitle:@"移除" forState:UIControlStateNormal];
        [cell.zhipaiBut removeTarget:cell action:@selector(zhipaiButClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if(self.dataArray.count > indexPath.row) {
    
        CLAddPersonModel *model = (CLAddPersonModel *)self.dataArray[indexPath.row];
        cell.model = model;
        cell.zhipaiBut.tag = indexPath.row;
        [cell.zhipaiBut addTarget:self action:@selector(removeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return cell;
}


- (void)removeBtnClick:(UIButton *)button{
    if (_dataArray.count > button.tag) {
        CLAddPersonModel *model = _dataArray[button.tag];
        
        [GFHttpTool favoriteTechnicianDeleteWithParameters:@{@"cooperatorId":model.jishiID} success:^(id responseObject) {
            ICLog(@"删除成功--%@--",responseObject);
            if ([responseObject[@"result"] integerValue] == 1) {
                [self addAlertView:@"操作成功"];
            }else{
                [self addAlertView:responseObject[@"message"]];
            }
            
        } failure:^(NSError *error) {
            ICLog(@"删除失败--%@--",error);
        }];
        
    }

}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    GFDetailPeoViewController *VC = [[GFDetailPeoViewController alloc] init];
//    VC.model = _dataArray[indexPath.row];
//    [self.navigationController pushViewController:VC animated:YES];
    
}



// 添加导航
- (void)setNavigation{
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"我的收藏" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navView];
    
    
}
- (void)backBtnClick{
   
     
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
