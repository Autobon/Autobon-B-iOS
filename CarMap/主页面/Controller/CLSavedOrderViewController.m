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
#import "Commom.h"

@interface CLSavedOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat kWidth;
    CGFloat kHeight;
    UITableView *_tableView;
    NSInteger _page;
    NSInteger _pageSize;
    NSMutableArray *_dataArray;
    
    UIView *_lineView;
    UIButton *_productLeftButton;
    UIButton *_productRightButton;
    UIScrollView *_selectProductScrollView;
    UIScrollView *_selectPackageScrollView;
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
        preCell.orderButton.tag = indexPath.row;
        [preCell.orderButton addTarget:self action:@selector(orderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        preCell.deleteButton.tag = indexPath.row;
        [preCell.deleteButton addTarget:self action:@selector(deleteOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        preCell.editButton.tag = indexPath.row;
        [preCell.editButton addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
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

- (void)deleteOrderForNewBtnClick:(UIButton *)button{
    ICLog(@"删除订单");
    if (button.tag < _dataArray.count){
        CLPreOrderModel *preOrderModel = _dataArray[button.tag];
        [GFHttpTool deleteCoopMerchantOrderPreWithParameters:@{@"orderPreIds": preOrderModel.idString} success:^(id responseObject) {
            ICLog(@"删除成功---%@--", responseObject);
            [_dataArray removeObjectAtIndex:button.tag];
            [_tableView reloadData];
        } failure:^(NSError *error) {
            ICLog(@"删除失败---%@--", error);
        }];
        
    }
}


- (void)editBtnClick:(UIButton *)button{
    if (button.tag < _dataArray.count){
        CLPreOrderModel *preOrderModel = _dataArray[button.tag];
        [_delegate selectSaveOrderModel:preOrderModel];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)orderBtnClick:(UIButton *)button{
    if (button.tag < _dataArray.count){
        CLPreOrderModel *preOrderModel = _dataArray[button.tag];
        ICLog(@"一键下单");
        
        
        if(preOrderModel.vin.length < 1){
            [self addAlertView:@"请填写车架号"];
            return;
        }else if(preOrderModel.vin.length < 7){
            [self addAlertView:@"车架号只能为后七位"];
            return;
        }else if(![Commom validateLetterInt:preOrderModel.vin]){
            [self addAlertView:@"车架号只能由数字和字母组成"];
            return;
        }else if(preOrderModel.license.length > 0){
            if(![Commom validateCarLicense:[preOrderModel.license uppercaseString]]){
                [self addAlertView:@"请检查车牌号"];
                return;
            }
        }
        
        if (preOrderModel.vehicleModel.length < 1 || [preOrderModel.vehicleModel isEqualToString:@""]){
            [self addAlertView:@"请填写车型"];
            return;
        }else if (preOrderModel.vehicleModel.length < 1 || [preOrderModel.vehicleModel isEqualToString:@""]){
            [self addAlertView:@"请选择预约开始时间"];
            return;
        }
        
        if (preOrderModel.productOffers.count < 1 && preOrderModel.productOfferSetMenus.count < 1){
            [self addAlertView:@"请选择施工项目或套餐"];
            return;
        }
        
        
        NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
        NSString *offerIdString = @"";
        for (int i = 0; i < preOrderModel.productOffers.count; i++) {
            NSDictionary *productDict = preOrderModel.productOffers[i];
            if (i == 0){
                offerIdString = [NSString stringWithFormat:@"%@", productDict[@"id"]];
            }else{
                offerIdString = [NSString stringWithFormat:@"%@,%@", offerIdString, productDict[@"id"]];
            }
        }
        dataDict[@"offerIds"] = offerIdString;      //施工项目
        
        NSString *menuIdString = @"";
        for (int i = 0; i < preOrderModel.productOfferSetMenus.count; i++) {
            NSDictionary *productMenusDict = preOrderModel.productOfferSetMenus[i];
            if (i == 0){
                menuIdString = [NSString stringWithFormat:@"%@", productMenusDict[@"id"]];
            }else{
                menuIdString = [NSString stringWithFormat:@"%@,%@", menuIdString, productMenusDict[@"id"]];
            }
        }
        dataDict[@"setMenuIds"] = menuIdString;     //套餐
        dataDict[@"vin"] = preOrderModel.vin;
        if (preOrderModel.license.length > 1){
            dataDict[@"license"] = [preOrderModel.license uppercaseString];
        }
        dataDict[@"vehicleModel"] = preOrderModel.vehicleModel;
        dataDict[@"agreedStartTime"] = preOrderModel.agreedStartTime;
        NSDate *startTimeDate = [Commom stringHHMMToDateWithDate:preOrderModel.agreedStartTime];
        NSInteger time = (NSInteger)[startTimeDate timeIntervalSince1970] + 3 * 60 * 60;
        NSDate *endTimeDate = [Commom timeIntervalToDateWithTimeInterval:time];
        NSString *endTimeString = [Commom dateToHHMMStringWithDate:endTimeDate];
        dataDict[@"agreedEndTime"] = endTimeString;
        dataDict[@"remark"] = preOrderModel.remark;
        
        ICLog(@"------dataDict-----%@----", dataDict);
        
        
        [GFHttpTool postCoopMerchantDataOrderWithParameters:dataDict success:^(id responseObject) {
            ICLog(@"---下单成功---%@---", responseObject);
            if ([responseObject[@"status"] integerValue] == 1){
                [self addAlertView:@"下单完成"];
                
                [self deleteOrderForNewBtnClick:button];
            }else{
                [self addAlertView:responseObject[@"message"]];
            }
        } failure:^(NSError *error) {
            ICLog(@"---error---%@---", error);
        }];
        
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
    
// 标题
    UIView *titleBaseView = [[UIView alloc]init];
    titleBaseView.backgroundColor = [UIColor whiteColor];
    [baseView addSubview:titleBaseView];
    [titleBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(baseView);
        make.top.equalTo(orderDetailView.mas_bottom).offset(5);
        make.height.mas_offset(40);
    }];
    
    _productLeftButton = [[UIButton alloc]init];
    [_productLeftButton setTitle:@"已选项目" forState:UIControlStateNormal];
    [_productLeftButton setTitleColor:[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] forState:UIControlStateNormal];
    [_productLeftButton setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateSelected];
    _productLeftButton.selected = YES;
    _productLeftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_productLeftButton addTarget:self action:@selector(selectProductLeftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [titleBaseView addSubview:_productLeftButton];
    [_productLeftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleBaseView).offset(15);
        make.right.equalTo(titleBaseView.mas_centerX).offset(-15);
        make.top.equalTo(titleBaseView);
        make.bottom.equalTo(titleBaseView);
    }];
    
    
    _productRightButton = [[UIButton alloc]init];
    [_productRightButton setTitle:@"已选套餐" forState:UIControlStateNormal];
    [_productRightButton setTitleColor:[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] forState:UIControlStateNormal];
    [_productRightButton setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateSelected];
    _productRightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_productRightButton addTarget:self action:@selector(selectProductRightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [titleBaseView addSubview:_productRightButton];
    [_productRightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(titleBaseView).offset(-15);
        make.left.equalTo(titleBaseView.mas_centerX).offset(15);
        make.top.equalTo(titleBaseView);
        make.bottom.equalTo(titleBaseView);
    }];
    
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [titleBaseView addSubview:_lineView];
    _lineView.frame = CGRectMake(kWidth / 4.0 - 30, 38, 60, 1.5);
    
    //        已选项目
    _selectProductScrollView = [[UIScrollView alloc]init];
    _selectProductScrollView.backgroundColor = [UIColor whiteColor];
    [baseView addSubview:_selectProductScrollView];
    [_selectProductScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(baseView);
        make.top.equalTo(titleBaseView.mas_bottom).offset(15);
    }];
    
    if (preOrderModel.productOffers){     //项目
        for (int i = 0; i < preOrderModel.productOffers.count; i++) {
            NSDictionary *productDict = preOrderModel.productOffers[i];
            //型号
            UILabel *codeLabel = [[UILabel alloc]init];
            codeLabel.text = [NSString stringWithFormat:@"型号：%@", productDict[@"model"]];
            codeLabel.font = [UIFont systemFontOfSize:14];
            codeLabel.alpha = 0.8;
            [_selectProductScrollView addSubview:codeLabel];
            codeLabel.frame = CGRectMake(20, 10 + 40 * i, self.view.frame.size.width/2 - 40, 35);
            
            //施工部位
            UILabel *positionLabel = [[UILabel alloc]init];
            positionLabel.text = [NSString stringWithFormat:@"部位：%@", productDict[@"constructionPositionName"]];
            positionLabel.font = [UIFont systemFontOfSize:14];
            positionLabel.alpha = 0.8;
            [_selectProductScrollView addSubview:positionLabel];
            positionLabel.frame = CGRectMake(self.view.frame.size.width/2 + 10, 10 + 40 * i, self.view.frame.size.width/2 - 40, 35);
            
            if (i < preOrderModel.productOffers.count - 1){
                UIView *lineView = [[UIView alloc]init];
                lineView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
                [_selectProductScrollView addSubview:lineView];
                lineView.frame = CGRectMake(20, 10 + 40 * i, self.view.frame.size.width - 40, 0.5);
            }
        }
        _selectProductScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 40 * preOrderModel.productOffers.count);
    }
    
    
    //        已选套餐
    _selectPackageScrollView = [[UIScrollView alloc]init];
    _selectPackageScrollView.backgroundColor = [UIColor whiteColor];
    [baseView addSubview:_selectPackageScrollView];
    [_selectPackageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(baseView);
        make.top.equalTo(titleBaseView.mas_bottom).offset(15);
    }];
    if (preOrderModel.productOfferSetMenus){    //套餐
        for (int i = 0; i < preOrderModel.productOfferSetMenus.count; i++) {
            NSDictionary *menuDict = preOrderModel.productOfferSetMenus[i];
            UILabel *nameLabel = [[UILabel alloc]init];
            nameLabel.text = [NSString stringWithFormat:@"%@", menuDict[@"name"]];
            nameLabel.font = [UIFont systemFontOfSize:14];
            nameLabel.alpha = 0.8;
            [_selectPackageScrollView addSubview:nameLabel];
            nameLabel.frame = CGRectMake(20, 10 + 40 * i, self.view.frame.size.width - 40, 35);
            
            if (i < preOrderModel.productOfferSetMenus.count - 1){
                UIView *lineView = [[UIView alloc]init];
                lineView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
                [_selectPackageScrollView addSubview:lineView];
                [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(nameLabel);
                    make.height.mas_offset(0.5);
                    make.top.equalTo(nameLabel.mas_bottom).offset(5);
                }];
            }
        }
        _selectPackageScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 40 * preOrderModel.productOfferSetMenus.count);
    }
    
    _selectPackageScrollView.contentOffset = CGPointMake(0, -100);
    _selectPackageScrollView.hidden = YES;
    
    
    return;
    
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


// 已选项目
-(void)selectProductLeftBtnClick{
    _lineView.frame = CGRectMake(kWidth / 4.0 - 30, 38, 60, 1.5);
    _productLeftButton.selected = YES;
    _productRightButton.selected = NO;
    _selectPackageScrollView.hidden = YES;
    _selectProductScrollView.hidden = NO;
}

// 已选套餐
-(void)selectProductRightBtnClick{
    _lineView.frame = CGRectMake(kWidth / 4.0 - 30 + kWidth / 2.0 , 38, 60, 1.5);
    _productLeftButton.selected = NO;
    _productRightButton.selected = YES;
    _selectPackageScrollView.hidden = NO;
    _selectProductScrollView.hidden = YES;
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
