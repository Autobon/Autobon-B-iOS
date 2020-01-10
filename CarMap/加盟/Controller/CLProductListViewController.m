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
#import "CLProductPackageModel.h"


@interface CLProductListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    
    NSInteger _page;
    NSInteger _pageSize;
    
    NSInteger _selectProductIndex;      //所选项目索引
}

@property (nonatomic, strong) GFNavigationView *navView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) CLTouchView *bgTouchView;
@property (nonatomic, strong) NSMutableArray *packageArray;
@property (nonatomic, strong) NSString *isMainString;

@end

@implementation CLProductListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _page = 1;
    _pageSize = 10;
    
    _isMainString = [[NSUserDefaults standardUserDefaults] objectForKey:@"userIsMain"];
    
    
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
    _pageSize = 20;
    _dataArray = [[NSMutableArray alloc] init];
    
    [self getProductList];
    
}

- (void)footRefresh {
    
    _page = _page + 1;
    _pageSize = 20;
    
    [self getProductList];
}


// 获取产品列表
- (void)getProductList {
    ICLog(@"获取产品列表");
    
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
    dataDict[@"page"] = @(_page);
    dataDict[@"pageSize"] = @(_pageSize);
    
    [GFHttpTool getProductOfferWithParameters:dataDict success:^(id responseObject) {
        ICLog(@"-getProductList--responseObject---%@-", responseObject);
        if ([responseObject[@"status"] integerValue] == 1) {
            NSDictionary *messageDictionary = responseObject[@"message"];
            NSArray *listArray = messageDictionary[@"list"];
            [listArray enumerateObjectsUsingBlock:^(NSDictionary *modelDic, NSUInteger idx, BOOL * _Nonnull stop) {
                CLProductModel *productModel = [[CLProductModel alloc]init];
                [productModel setModelForDictionary:modelDic];
                productModel.cellHeight = 125;
                [_dataArray addObject:productModel];
            }];
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

//获取产品详情
//- (void)getProductDetail{
//    [GFHttpTool getProductOfferDetailWithOrderId:@"2" success:^(id responseObject) {
//        ICLog(@"-getProductDetail--responseObject---%@-", responseObject);
//    } failure:^(NSError *error) {
//        ICLog(@"--getProductDetail-error---%@-", error);
//    }];
//}


// 获取套餐列表
- (void)getPackageList{
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
//    dataDict[@"page"] = @(1);
//    dataDict[@"pageSize"] = @(2000);
    dataDict[@"type"] = @"2";
    _packageArray = [[NSMutableArray alloc]init];
    [GFHttpTool getProductOfferMenuListWithParameters:dataDict success:^(id responseObject) {
        ICLog(@"-getProductList--responseObject---%@-", responseObject);
        if ([responseObject[@"status"] integerValue] == 1) {
//            NSDictionary *messageDictionary = responseObject[@"message"];
            NSArray *listArray = responseObject[@"message"];
            [listArray enumerateObjectsUsingBlock:^(NSDictionary *modelDic, NSUInteger idx, BOOL * _Nonnull stop) {
                CLProductPackageModel *packageModel = [[CLProductPackageModel alloc]init];
                [packageModel setModelForDictionary:modelDic];
                [_packageArray addObject:packageModel];
            }];
            
            [self showPackageListForChoose];
        }
    } failure:^(NSError *error) {
        ICLog(@"-getProductList--error---%@-", error);
    }];
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.dataArray.count > indexPath.row){
        cell.productModel = self.dataArray[indexPath.row];
    }
    
    cell.detailButton.tag = indexPath.row;
    [cell.detailButton addTarget:self action:@selector(cellDetailBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.addButton.tag = indexPath.row;
    [cell.addButton addTarget:self action:@selector(cellAddBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    CLProductModel *productModel = _dataArray[indexPath.row];
    if (productModel.cellHeight == 125){
        cell.detailButton.selected = NO;
        cell.buttonImageView.image = [UIImage imageNamed:@"sjxd_list_more"];
    }else{
        cell.detailButton.selected = YES;
        cell.buttonImageView.image = [UIImage imageNamed:@"tc_gbxq_btn"];
    }
    
    if (![self.isMainString isEqualToString:@"1"]){
        cell.priceLabel.hidden = YES;
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
    _selectProductIndex = button.tag;
    [self getPackageList];
    
    
}

- (void)showPackageListForChoose{
    if (_packageArray.count < 1){
        [self addAlertView:@"商户未添加套餐，请先添加套餐"];
        return;
    }
    
    _bgTouchView = [[CLTouchView alloc]init];
    _bgTouchView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [self.view addSubview:self.bgTouchView];
    [self.bgTouchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    
    CGFloat scrollViewHeight = 0;
    
    if (self.packageArray.count < 8){
        scrollViewHeight = 50 * self.packageArray.count;
    }else{
        scrollViewHeight = 50 * 7;
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
    
    
    for (int i = 0; i < self.packageArray.count; i++) {
        
        CLProductPackageModel *packageModel = self.packageArray[i];
        
        UIView *contentBaseView = [[UIView alloc]init];
        contentBaseView.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:contentBaseView];
        contentBaseView.frame = CGRectMake(0, 0 + i * 50, self.view.frame.size.width, 50);
        
        UIView *packageLineView = [[UIView alloc]init];
        packageLineView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:230/255.0];
        [contentBaseView addSubview:packageLineView];
        [packageLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(contentBaseView);
            make.height.mas_offset(1);
        }];
        
        UILabel *contentTitleLabel = [[UILabel alloc]init];
        //        contentTitleLabel.text = [NSString stringWithFormat:@"套餐%d", i + 1];
        contentTitleLabel.text = packageModel.name;
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
        contentButton.tag = i;
        [contentButton addTarget:self action:@selector(selectProductForPackageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [contentBaseView addSubview:contentButton];
        [contentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(contentBaseView).offset(-25);
            make.centerY.equalTo(contentBaseView);
            make.height.mas_offset(28);
            make.width.mas_offset(70);
        }];
        
    }
    
    scrollView.frame = CGRectMake(0, 50, self.view.frame.size.width, scrollViewHeight);
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 50 * self.packageArray.count);
}





- (void)selectProductForPackageBtnClick:(UIButton *)button{
    CLProductModel *productModel = self.dataArray[_selectProductIndex];
    CLProductPackageModel *packageModel = self.packageArray[button.tag];
    
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
    dataDict[@"setMenuId"] = packageModel.idString;
    dataDict[@"offerId"] = productModel.idString;
    ICLog(@"----dataDict---%@---", dataDict);
    [GFHttpTool postProductOfferSetMenuAddWithParameters:dataDict success:^(id responseObject) {
        ICLog(@"-ProductOfferSetMenuAdd--responseObject---%@-", responseObject);
        if ([responseObject[@"status"] integerValue] == 1) {
            [self addAlertView:@"添加成功"];
        }else{
            [self addAlertView:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        ICLog(@"-ProductOfferSetMenuAdd--error---%@-", error);
    }];
    
    
    
    
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
    [_navView.rightBut setTitle:@"套餐组合" forState:UIControlStateNormal];
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
