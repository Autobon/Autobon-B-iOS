//
//  CLEditPackageViewController.m
//  CarMapB
//
//  Created by inCarL on 2019/12/24.
//  Copyright © 2019 mll. All rights reserved.
//

#import "CLEditPackageViewController.h"
#import "GFTextField.h"
#import "CLProductSelectTableViewCell.h"
#import "MJRefresh.h"
#import "CLProductModel.h"
#import "GFNavigationView.h"
#import "GFHttpTool.h"
#import "GFTipView.h"
#import "Commom.h"

@interface CLEditPackageViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *_tableView;
    
    NSInteger _page;
    NSInteger _pageSize;
    NSMutableArray *_offerIdArray;
}

@property (nonatomic, strong) GFNavigationView *navView;
@property (nonatomic, strong) GFTextField *nameTxt;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CLEditPackageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *offerIds = [self.packageModel.productOfferIds componentsSeparatedByString:@","];
    _offerIdArray = [[NSMutableArray alloc] initWithArray:offerIds];
    
    [self setNavigation];
    
    [self setDetailForView];
}



- (void)setDetailForView{
    
    // 请输入套餐名
    self.nameTxt = [[GFTextField alloc] initWithY: 100 withPlaceholder:@"请输入套餐名"];
    self.nameTxt.text = self.packageModel.name;
    self.nameTxt.delegate = self;
    [self.view addSubview:self.nameTxt];
    [self.nameTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.navView.mas_bottom).offset(5);
        make.height.mas_offset(45);
    }];
    
    // 提交按钮
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(20, 200, self.view.frame.size.width - 40, 50);
    submitButton.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
//    submitButton.layer.cornerRadius = 5;
    [submitButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.view addSubview:submitButton];
    [submitButton addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.mas_offset(50);
    }];
    
    
    
    _tableView = [[UITableView alloc]init];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 添加刷新
    //    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.nameTxt.mas_bottom).offset(10);
        make.bottom.equalTo(submitButton.mas_top).offset(-10);
    }];
    
    //    [_tableView.mj_header beginRefreshing];
    [self headRefresh];
    
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    //    return 50;
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CLProductModel *productModel = _dataArray[indexPath.row];
    return productModel.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CLProductSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil){
        cell = [[CLProductSelectTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.buttonBaseView.hidden = YES;
    if (self.dataArray.count > indexPath.row){
        cell.productModel = self.dataArray[indexPath.row];
        if ([_offerIdArray containsObject:cell.productModel.idString]){
            cell.selectButton.selected = YES;
        }else{
            cell.selectButton.selected = false;
        }

    }
    
    
    
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
    if (self.dataArray.count > indexPath.row){
        CLProductModel *productModel = self.dataArray[indexPath.row];
        CLProductSelectTableViewCell *cell = (CLProductSelectTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        if ([_offerIdArray containsObject:productModel.idString]){
            [_offerIdArray removeObject:productModel.idString];
            cell.selectButton.selected = NO;
        }else{
            [_offerIdArray addObject:productModel.idString];
            cell.selectButton.selected = YES;
        }
//        [tableView reloadData];
        
    }
    
}

- (void)submitBtnClick{
    [self.view endEditing:YES];
    if (_nameTxt.text.length < 1) {
        [self addAlertView:@"请输入套餐名"];
        return;
    }
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData *textFieldData = [_nameTxt.text dataUsingEncoding:enc];
    if (textFieldData.length > 32){
        [self addAlertView:@"套餐名称最长32位字符或16位汉字"];
        return;
    }
    
    NSString *offerIds = @"";
    for (int i = 0; i < _offerIdArray.count; i++) {
        NSString *offerIdString = _offerIdArray[i];
        offerIds = [NSString stringWithFormat:@"%@,%@", offerIds, offerIdString];
    }
    ICLog(@"---offerIds---%@---", offerIds);
    if (offerIds.length < 1){
        [self addAlertView:@"请选择施工项目"];
        return;
    }
    offerIds = [offerIds substringFromIndex:1];
    ICLog(@"---offerIds---%@---", offerIds);
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
    dataDict[@"name"] = self.nameTxt.text;
    dataDict[@"offerIds"] = offerIds;
    ICLog(@"----dataDict---%@---", dataDict);
    
    [GFHttpTool postUpdateMenuSetProductOfferWithParameters:dataDict success:^(id responseObject) {
        ICLog(@"-ProductOfferSetMenuAdd--responseObject---%@-", responseObject);
        if ([responseObject[@"status"] integerValue] == 1) {
            [self addAlertView:@"编辑成功"];
//            if (_delegate != nil){
//                [_delegate addPackageSuccess];
//            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self addAlertView:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        ICLog(@"-ProductOfferSetMenuAdd--error---%@-", error);
    }];
}

// 添加导航
- (void)setNavigation{
    self.view.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    
    _navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"编辑套餐" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.length == 0){
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSData *textFieldData = [textField.text dataUsingEncoding:enc];
        if (textFieldData.length == 32){
            return NO;
        }
        
        NSData *stringData = [string dataUsingEncoding:enc];
        if (textFieldData.length + stringData.length > 32){
            if (string.length > 1){
                if (32 - textFieldData.length < stringData.length){
                    NSData *data = [stringData subdataWithRange:NSMakeRange(0, 32 - textFieldData.length)];
                    
                    ICLog(@"data---%@--stringData--%@--", data, stringData);
                    NSMutableData *textData = [[NSMutableData alloc] initWithData:textFieldData];
                    [textData appendData:data];
                    NSString * str = [[NSString alloc]initWithData:textData encoding:enc];
                    if (str != nil && str.length > 1){
                        textField.text = str;
                    }
                }
            }
            
            return NO;
        }
        return [Commom validateSpecialString:string];
    }
    return YES;
    
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
