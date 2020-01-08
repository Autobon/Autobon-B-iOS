//
//  CLSavedOrderViewController.m
//  CarMapB
//
//  Created by inCarL on 2020/1/7.
//  Copyright © 2020 mll. All rights reserved.
//

#import "CLSavedOrderViewController.h"
#import "GFNavigationView.h"
#import "GFHttpTool.h"
#import "CLPreOrderTableViewCell.h"
#import "MJRefresh.h"
#import "GFTipView.h"

@interface CLSavedOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat kWidth;
    CGFloat kHeight;
    UITableView *_tableView;
    NSInteger _page;
    NSInteger _pageSize;
    NSMutableArray *_dataArray;
}

@property (nonatomic, strong) GFNavigationView *navView;
@property (nonatomic, strong) UIView *detailBaseView;
@end

@implementation CLSavedOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    kWidth = [UIScreen mainScreen].bounds.size.width;
    kHeight = [UIScreen mainScreen].bounds.size.height;
    self.view.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"已存订单" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
    
    
    
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    // 添加刷新
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    [_tableView.mj_header beginRefreshing];
    
    
}

- (void)headRefresh {
    
    _page = 1;
    _pageSize = 20;
    _dataArray = [[NSMutableArray alloc] init];
    
    [self getList];
    
}

- (void)footRefresh {
    
    _page = _page + 1;
    _pageSize = 20;
    
    [self getList];
}

- (void)getList{
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
    dataDict[@"page"] = @(_page);
    dataDict[@"pageSize"] = @(_pageSize);
    [GFHttpTool getCoopMerchantOrderPreWithParameters:dataDict success:^(id responseObject) {
        ICLog(@"getList---%@--", responseObject);
        if ([responseObject[@"status"] integerValue] == 1) {
            NSDictionary *messageDict = responseObject[@"message"];
            NSArray *listArray = messageDict[@"list"];
            for (int i = 0; i < listArray.count; i++) {
                NSDictionary *modelDict = listArray[i];
                CLPreOrderModel *preOrderModel = [[CLPreOrderModel alloc]init];
                [preOrderModel setModelForData:modelDict];
                [_dataArray addObject:preOrderModel];
            }
        }
        
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        ICLog(@"getError--%@--", error);
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLPreOrderTableViewCell *preCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (preCell == nil){
        preCell = [[CLPreOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.row < _dataArray.count){
        CLPreOrderModel *preOrderModel = _dataArray[indexPath.row];
        preCell.vinValueLabel.text = preOrderModel.vin;
        preCell.licenseValueLabel.text = preOrderModel.license;
        preCell.carModelValueLabel.text = preOrderModel.vehicleModel;
        preCell.beginTimeValueLabel.text = preOrderModel.agreedStartTime;
        preCell.deleteButton.tag = indexPath.row;
        [preCell.deleteButton addTarget:self action:@selector(deleteOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        preCell.orderButton.tag = indexPath.row;
        [preCell.orderButton addTarget:self action:@selector(orderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return preCell;
}

- (void)deleteOrderBtnClick:(UIButton *)button{
    ICLog(@"删除订单");
    if (button.tag < _dataArray.count){
        CLPreOrderModel *preOrderModel = _dataArray[button.tag];
        [GFHttpTool deleteCoopMerchantOrderPreWithParameters:@{@"orderPreIds": preOrderModel.idString} success:^(id responseObject) {
            ICLog(@"删除成功---%@--", responseObject);
            [_dataArray removeObjectAtIndex:button.tag];
            [_tableView reloadData];
            [self addAlertView:@"删除成功"];
        } failure:^(NSError *error) {
            ICLog(@"删除失败---%@--", error);
        }];
        
    }
}

- (void)orderBtnClick:(UIButton *)button{
    if (button.tag < _dataArray.count){
        CLPreOrderModel *preOrderModel = _dataArray[button.tag];
        [_delegate selectSaveOrderModel:preOrderModel];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 190;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < _dataArray.count){
        CLPreOrderModel *preOrderModel = _dataArray[indexPath.row];
        [self showDetailViewFor:preOrderModel];
    }
}


- (void)showDetailViewFor:(CLPreOrderModel *)preOrderModel{
    _detailBaseView = [[UIView alloc]init];
    _detailBaseView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [self.view addSubview:_detailBaseView];
    [_detailBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    
    UIView *baseView = [[UIView alloc]init];
    baseView.backgroundColor = [UIColor whiteColor];
    [_detailBaseView addSubview:baseView];
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_centerY).offset(-100);
    }];
    
    UIButton *removeButton = [[UIButton alloc]init];
    [_detailBaseView addSubview:removeButton];
    [removeButton addTarget:self action:@selector(removeDetailBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [removeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(_detailBaseView);
        make.bottom.equalTo(baseView.mas_top);
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"详情";
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [baseView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(baseView).offset(15);
        make.top.equalTo(baseView).offset(15);
        make.height.mas_offset(20);
    }];
    
    UIView *orderDetailView = [[UIView alloc]init];
    orderDetailView.backgroundColor = [UIColor whiteColor];
    [baseView addSubview:orderDetailView];
    orderDetailView.layer.cornerRadius = 5;
    orderDetailView.layer.shadowColor = [UIColor blackColor].CGColor;
    orderDetailView.layer.shadowOffset = CGSizeMake(0,0);
    orderDetailView.layer.masksToBounds = NO;
    orderDetailView.layer.shadowOpacity = 0.5;
    [orderDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(baseView).offset(15);
        make.right.equalTo(baseView).offset(-15);
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.height.mas_offset(140);
    }];
    
    // 车架号
    UILabel *vinTitleLabel = [[UILabel alloc]init];
    vinTitleLabel.text = @"车架号：";
    vinTitleLabel.alpha = 0.8;
    vinTitleLabel.font = [UIFont systemFontOfSize:13];
    [baseView addSubview:vinTitleLabel];
    [vinTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(orderDetailView).offset(15);
        make.top.equalTo(orderDetailView).offset(15);
        make.height.mas_offset(20);
    }];
    
    UILabel *vinValueLabel = [[UILabel alloc]init];
    vinValueLabel.text = preOrderModel.vin;
    vinValueLabel.alpha = 0.8;
    vinValueLabel.font = [UIFont systemFontOfSize:13];
    [baseView addSubview:vinValueLabel];
    [vinValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vinTitleLabel.mas_right).offset(5);
        make.centerY.equalTo(vinTitleLabel).offset(0);
        make.height.mas_offset(20);
    }];
    
    // 车牌号
    UILabel *licneseTitleLabel = [[UILabel alloc]init];
    licneseTitleLabel.text = @"车牌号：";
    licneseTitleLabel.alpha = 0.8;
    licneseTitleLabel.font = [UIFont systemFontOfSize:13];
    [baseView addSubview:licneseTitleLabel];
    [licneseTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(orderDetailView).offset(15);
        make.top.equalTo(vinTitleLabel.mas_bottom).offset(10);
        make.height.mas_offset(20);
    }];
    
    UILabel *licenseValueLabel = [[UILabel alloc]init];
    licenseValueLabel.text = preOrderModel.license;
    licenseValueLabel.alpha = 0.8;
    licenseValueLabel.font = [UIFont systemFontOfSize:13];
    [baseView addSubview:licenseValueLabel];
    [licenseValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vinTitleLabel.mas_right).offset(5);
        make.centerY.equalTo(licneseTitleLabel).offset(0);
        make.height.mas_offset(20);
    }];
    
    // 车型
    UILabel *carModelTitleLabel = [[UILabel alloc]init];
    carModelTitleLabel.text = @"车    型：";
    carModelTitleLabel.alpha = 0.8;
    carModelTitleLabel.font = [UIFont systemFontOfSize:13];
    [baseView addSubview:carModelTitleLabel];
    [carModelTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(orderDetailView).offset(15);
        make.top.equalTo(licneseTitleLabel.mas_bottom).offset(10);
        make.height.mas_offset(20);
    }];
    
    UILabel *carModelValueLabel = [[UILabel alloc]init];
    carModelValueLabel.text = preOrderModel.vehicleModel;
    carModelValueLabel.alpha = 0.8;
    carModelValueLabel.font = [UIFont systemFontOfSize:13];
    [baseView addSubview:carModelValueLabel];
    [carModelValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vinTitleLabel.mas_right).offset(5);
        make.centerY.equalTo(carModelTitleLabel).offset(0);
        make.height.mas_offset(20);
    }];
    
    // 预约时间
    UILabel *beginTimeTitleLabel = [[UILabel alloc]init];
    beginTimeTitleLabel.text = @"预约时间：";
    beginTimeTitleLabel.alpha = 0.8;
    beginTimeTitleLabel.font = [UIFont systemFontOfSize:13];
    [baseView addSubview:beginTimeTitleLabel];
    [beginTimeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(orderDetailView).offset(15);
        make.top.equalTo(carModelTitleLabel.mas_bottom).offset(10);
        make.height.mas_offset(20);
    }];
    
    UILabel *beginTimeValueLabel = [[UILabel alloc]init];
    beginTimeValueLabel.text = preOrderModel.agreedStartTime;
    beginTimeValueLabel.alpha = 0.8;
    beginTimeValueLabel.font = [UIFont systemFontOfSize:13];
    [baseView addSubview:beginTimeValueLabel];
    [beginTimeValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vinTitleLabel.mas_right).offset(5);
        make.centerY.equalTo(beginTimeTitleLabel).offset(0);
        make.height.mas_offset(20);
    }];
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    [baseView addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(baseView);
        make.top.equalTo(orderDetailView.mas_bottom).offset(20);
    }];
    if (preOrderModel.productOfferSetMenus){    //套餐
        for (int i = 0; i < preOrderModel.productOfferSetMenus.count; i++) {
            NSDictionary *menuDict = preOrderModel.productOfferSetMenus[i];
            UILabel *nameLabel = [[UILabel alloc]init];
            nameLabel.text = [NSString stringWithFormat:@"%@", menuDict[@"name"]];
            nameLabel.font = [UIFont systemFontOfSize:14];
            nameLabel.alpha = 0.8;
            [scrollView addSubview:nameLabel];
            nameLabel.frame = CGRectMake(20, 10 + 40 * i, self.view.frame.size.width - 40, 35);
          
            if (i < preOrderModel.productOfferSetMenus.count - 1){
                UIView *lineView = [[UIView alloc]init];
                lineView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
                [scrollView addSubview:lineView];
                [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(nameLabel);
                    make.height.mas_offset(0.5);
                    make.top.equalTo(nameLabel.mas_bottom).offset(5);
                }];
            }
        }
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 40 * preOrderModel.productOfferSetMenus.count);
    }else if (preOrderModel.productOffers){     //项目
        for (int i = 0; i < preOrderModel.productOffers.count; i++) {
            NSDictionary *productDict = preOrderModel.productOffers[i];
            //型号
            UILabel *codeLabel = [[UILabel alloc]init];
            codeLabel.text = [NSString stringWithFormat:@"型号：%@", productDict[@"model"]];
            codeLabel.font = [UIFont systemFontOfSize:14];
            codeLabel.alpha = 0.8;
            [scrollView addSubview:codeLabel];
            codeLabel.frame = CGRectMake(20, 10 + 40 * i, self.view.frame.size.width/2 - 40, 35);
            
            //施工部位
            UILabel *positionLabel = [[UILabel alloc]init];
            positionLabel.text = [NSString stringWithFormat:@"部位：%@", productDict[@"constructionPositionName"]];
            positionLabel.font = [UIFont systemFontOfSize:14];
            positionLabel.alpha = 0.8;
            [scrollView addSubview:positionLabel];
            positionLabel.frame = CGRectMake(self.view.frame.size.width/2 + 10, 10 + 40 * i, self.view.frame.size.width/2 - 40, 35);
            
            if (i < preOrderModel.productOffers.count - 1){
                UIView *lineView = [[UIView alloc]init];
                lineView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
                [scrollView addSubview:lineView];
                lineView.frame = CGRectMake(20, 10 + 40 * i, self.view.frame.size.width - 40, 0.5);
            }
        }
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 40 * preOrderModel.productOffers.count);
    }
    
    
    
}

- (void)removeDetailBtnClick{
    [_detailBaseView removeFromSuperview];
    _detailBaseView = nil;
}


- (void)leftButClick {
    
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
