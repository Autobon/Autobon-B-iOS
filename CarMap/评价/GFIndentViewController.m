//
//  GFIndentViewController.m
//  CarMap
//
//  Created by 陈光法 on 16/2/25.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFIndentViewController.h"
#import "GFNavigationView.h"
#import "GFTextField.h"
#import "GFHttpTool.h"

#import "GFIndentTableViewCell.h"
#import "GFIndentDetialsViewController.h"

#import "MJRefresh.h"
#import "GFIndentModel.h"
#import "UIImageView+WebCache.h"
#import "GFEvaluateViewController.h"
#import "GFTipView.h"
#import "GFNothingView.h"



//#import "GFTipView.h"

@interface GFIndentViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    NSMutableArray *_dataArray;
    BOOL _isAll;
    
    NSInteger _page;
    NSInteger _pageSize;
    
}

@property (nonatomic, strong) GFNavigationView *navView;

@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) GFNothingView *nothingView;

@end

@implementation GFIndentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isAll = YES;
    
    // 基础设置
    [self _setBase];
    
    // 界面搭建
    [self _setView];
    
    // 无数据提示页
    self.nothingView = [[GFNothingView alloc] initWithImageName:@"NoOrder" withTipString:@"暂无数据" withSubtipString:nil];
    [self.view addSubview:self.nothingView];
}

- (void)_setBase {
    
    kWidth = [UIScreen mainScreen].bounds.size.width;
    kHeight = [UIScreen mainScreen].bounds.size.height;
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"我的订单" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}

- (void)_setView {
    
    // 负责人横条
    CGFloat baseViewW = kWidth;
    CGFloat baseViewH = kHeight * 0.0651;
    CGFloat baseViewX = 0;
    CGFloat baseViewY = 64;
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView];
    // 主负责人
    UIButton *mainBut = [UIButton buttonWithType:UIButtonTypeCustom];
    mainBut.frame = CGRectMake(0, 0, baseViewW / 2.0, baseViewH);
    mainBut.titleLabel.font = [UIFont boldSystemFontOfSize:14 / 320.0 * kWidth];
    [mainBut setTitle:@"全部" forState:UIControlStateNormal];
    [mainBut setTitleColor:[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] forState:UIControlStateNormal];
    [mainBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateSelected];
    mainBut.selected = YES;
    [baseView addSubview:mainBut];
    [mainBut addTarget:self action:@selector(renButClick:) forControlEvents:UIControlEventTouchUpInside];
    mainBut.tag = 1000;
    // 次负责人
    UIButton *otherBut = [UIButton buttonWithType:UIButtonTypeCustom];
    otherBut.frame = CGRectMake(CGRectGetMaxX(mainBut.frame), 0, kWidth / 2.0, baseViewH);
    otherBut.titleLabel.font = [UIFont boldSystemFontOfSize:14 / 320.0 * kWidth];
    [otherBut setTitle:@"待评价" forState:UIControlStateNormal];
    [otherBut setTitleColor:[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] forState:UIControlStateNormal];
    [otherBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateSelected];
    [baseView addSubview:otherBut];
    [otherBut addTarget:self action:@selector(renButClick:) forControlEvents:UIControlEventTouchUpInside];
    otherBut.tag = 2000;
    //边线
    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, baseViewH - 1, kWidth, 1)];
    vv.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [baseView addSubview:vv];
    // 下划线
    NSString *proStr = @"全部";
    NSMutableDictionary *proDic = [[NSMutableDictionary alloc] init];
    proDic[NSFontAttributeName] = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    proDic[NSForegroundColorAttributeName] = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    CGRect proRect = [proStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:proDic context:nil];
    CGFloat lineViewW = proRect.size.width + 20;
    CGFloat lineViewH = 1.5;
    CGFloat lineViewX = (kWidth / 2.0 - lineViewW) / 2.0;
    CGFloat lineViewY = CGRectGetMaxY(baseView.frame) - lineViewH;
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(lineViewX, lineViewY, lineViewW, lineViewH)];
    self.lineView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [self.view addSubview:self.lineView];
    
    
    
    
    // tableView视图
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + baseViewH, kWidth, kHeight - 64 - baseViewH) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    self.tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    
    [self.tableview.header beginRefreshing];
//    [self.tableview.footer beginRefreshing];
    
}

- (void)renButClick:(UIButton *)sender {

    sender.selected = YES;
    
    if(sender.tag == 1000) {
        _isAll = YES;
        UIButton *but = (UIButton *)[self.view viewWithTag:2000];
        but.selected = NO;
        
    }else {
        _isAll = NO;
        UIButton *but = (UIButton *)[self.view viewWithTag:1000];
        but.selected = NO;
    
    }
    
    CGFloat centerX = sender.center.x;
    CGPoint oriPoint = self.lineView.center;
    oriPoint.x = centerX;
    [UIView animateWithDuration:0.5 animations:^{
        self.lineView.center = oriPoint;
    }];
    
    [self.tableview.header beginRefreshing];
    
}

- (void)headRefresh {
    
    NSLog(@"脑袋刷新");
    _dataArray = [[NSMutableArray alloc]init];
    _page = 1;
    _pageSize = 2;
    if (_isAll) {
        [self getOrder];
    }else{
        [self getListUncomment];
    }
    
    
    
}

- (void)footRefresh {
    
    NSLog(@"大脚刷新");
    _page = _page + 1;
    if (_isAll) {
        [self getOrder];
    }else{
        [self getListUncomment];
    }
    
}


#pragma mark - 获取未评论订单列表
- (void)getListUncomment{
    _tableview.userInteractionEnabled = YES;
    [GFHttpTool postListUncommentDictionary:@{@"page":@(_page),@"pageSize":@(_pageSize)} success:^(id responseObject) {
        if ([responseObject[@"result"] integerValue] == 1) {
            NSDictionary *dataDictionary = responseObject[@"data"];
            NSArray *listArray = dataDictionary[@"list"];
            if (_page > 1 && listArray.count == 0) {
                [self addAlertView:@"已加载全部"];
            }
            NSArray *typeArray = @[@"隔热层",@"隐形车衣",@"车身改色",@"美容清洁"];
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
            [listArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                GFIndentModel *model = [[GFIndentModel alloc]init];
                model.orderNum = obj[@"orderNum"];
                model.orderId = obj[@"id"];
                model.commentDictionary = obj[@"comment"];
                model.photo = obj[@"photo"];
                NSInteger type = [obj[@"orderType"] integerValue] - 1;
                model.orderType = typeArray[type];
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:[obj[@"orderTime"] floatValue]/1000];
                model.workTime = [NSString stringWithFormat:@"预约时间：%@",[formatter stringFromDate:date]];
                model.remark = obj[@"remark"];
                
                date = [NSDate dateWithTimeIntervalSince1970:[obj[@"addTime"] floatValue]/1000];
                model.signinTime = [NSString stringWithFormat:@"下单时间：%@",[formatter stringFromDate:date]];
                
                model.mainTechDictionary = obj[@"mainTech"];
                model.secondTechDictionary = obj[@"secondTech"];
                model.status = obj[@"status"];
                [_dataArray addObject:model];
                
                //                if ([obj[@"secondConstruct"]isKindOfClass:[NSNull class]]) {
                //                    NSDictionary *mainConstructDic = obj[@"mainConstruct"];
                //                    model.payment = [NSString stringWithFormat:@"%@",mainConstructDic[@"payment"]];
                //                }else{
                //                    NSDictionary *mainConstructDic = obj[@"mainConstruct"];
                //                    NSDictionary *secondConstructDic = obj[@"secondConstruct"];
                //                    NSInteger pay = [mainConstructDic[@"payment"] integerValue] + [secondConstructDic[@"payment"] integerValue];
                //                    model.payment = [NSString stringWithFormat:@"%ld",pay];
                //                }
                //                model.payment = obj[@""]
                //                model.payStatus =
                
            }];
            
            [_tableview reloadData];
            _tableview.userInteractionEnabled = YES;
            [self.tableview.header endRefreshing];
            [self.tableview.footer endRefreshing];
        }else{
            
            [self addAlertView:responseObject[@"message"]];
            [_tableview reloadData];
            _tableview.userInteractionEnabled = YES;
            [self.tableview.header endRefreshing];
            [self.tableview.footer endRefreshing];
        }
        
        if (_dataArray.count == 0) {
            _nothingView.hidden = NO;
        }else{
            _nothingView.hidden = YES;
        }
        
//        NSLog(@"--请求成功－－%@--",responseObject);
        
    } failure:^(NSError *error) {
        
//        NSLog(@"请求失败---%@--",error);
        [_tableview reloadData];
        _tableview.userInteractionEnabled = YES;
        [self.tableview.header endRefreshing];
        [self.tableview.footer endRefreshing];
        
    }];
}

#pragma mark - 获取已完成订单
- (void)getOrder{
    
    _tableview.userInteractionEnabled = NO;
    [GFHttpTool postListFinishedDictionary:@{@"page":@(_page),@"pageSize":@(_pageSize)} success:^(id responseObject) {
        
        if ([responseObject[@"result"] integerValue] == 1) {
            NSDictionary *dataDictionary = responseObject[@"data"];
            NSArray *listArray = dataDictionary[@"list"];
            if (_page > 1 && listArray.count == 0) {
                [self addAlertView:@"已加载全部"];
            }
            NSArray *typeArray = @[@"隔热层",@"隐形车衣",@"车身改色",@"美容清洁"];
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
            [listArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                NSLog(@"---obj-－－%@---",obj);
                GFIndentModel *model = [[GFIndentModel alloc]init];
                model.orderNum = obj[@"orderNum"];
                model.orderId = obj[@"id"];
                model.commentDictionary = obj[@"comment"];
                model.photo = obj[@"photo"];
                NSInteger type = [obj[@"orderType"] integerValue] - 1;
                model.orderType = typeArray[type];
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:[obj[@"orderTime"] floatValue]/1000];
                model.workTime = [formatter stringFromDate:date];
                model.remark = obj[@"remark"];
                
                date = [NSDate dateWithTimeIntervalSince1970:[obj[@"addTime"] floatValue]/1000];
                model.signinTime = [formatter stringFromDate:date];
//                NSLog(@"---time-%@---signin--%@---",obj[@"addTime"],model.signinTime);
                model.mainTechDictionary = obj[@"mainTech"];
                model.secondTechDictionary = obj[@"secondTech"];
                model.status = obj[@"status"];
                [_dataArray addObject:model];
                
//                if ([obj[@"secondConstruct"]isKindOfClass:[NSNull class]]) {
//                    NSDictionary *mainConstructDic = obj[@"mainConstruct"];
//                    model.payment = [NSString stringWithFormat:@"%@",mainConstructDic[@"payment"]];
//                }else{
//                    NSDictionary *mainConstructDic = obj[@"mainConstruct"];
//                    NSDictionary *secondConstructDic = obj[@"secondConstruct"];
//                    NSInteger pay = [mainConstructDic[@"payment"] integerValue] + [secondConstructDic[@"payment"] integerValue];
//                    model.payment = [NSString stringWithFormat:@"%ld",pay];
//                }
//                model.payment = obj[@""]
//                model.payStatus = 
                
            }];
            
            
            [_tableview reloadData];
            [self.tableview.header endRefreshing];
            [self.tableview.footer endRefreshing];
            _tableview.userInteractionEnabled = YES;
        }else{
            [self addAlertView:responseObject[@"message"]];
            [_tableview reloadData];
            
            [self.tableview.header endRefreshing];
            [self.tableview.footer endRefreshing];
            _tableview.userInteractionEnabled = YES;
        }
        
        if (_dataArray.count == 0) {
            _nothingView.hidden = NO;
        }else{
            _nothingView.hidden = YES;
        }
        
        NSLog(@"--请求成功－－%@--",responseObject);
        
    } failure:^(NSError *error) {
        [_tableview reloadData];
        _tableview.userInteractionEnabled = YES;
        [self.tableview.header endRefreshing];
        [self.tableview.footer endRefreshing];
        [self addAlertView:@"请求失败"];
        NSLog(@"请求失败---%@--",error);
        
    }];
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    GFIndentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil) {
        
        cell = [[GFIndentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (_dataArray.count > indexPath.row) {
        GFIndentModel *model = _dataArray[indexPath.row];
        cell.numberLab.text = [NSString stringWithFormat:@"订单编号%@",model.orderNum];
        cell.timeLab.text = model.orderType;
        [cell.photoImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://121.40.157.200:12345%@",model.photo]] placeholderImage:[UIImage imageNamed:@"orderImage"]];
        if ([model.commentDictionary isKindOfClass:[NSNull class]]) {
            [cell.pingjiaBut setTitle:@"去评价" forState:UIControlStateNormal];
            cell.pingjiaBut.tag = indexPath.row;
            [cell.pingjiaBut addTarget:self action:@selector(judgeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [cell.pingjiaBut setTitle:@"已评价" forState:UIControlStateNormal];
            //        [cell.pingjiaBut addTarget:self action:@selector(judgeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    return cell;
}

#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
}

#pragma mark - 去评价按钮
- (void)judgeBtnClick:(UIButton *)button{
    GFIndentModel *model = _dataArray[button.tag];
    if ([model.status isEqualToString:@"EXPIRED"]) {
        [self addAlertView:@"订单已超时"];
    }else{
        GFEvaluateViewController *evaluateView = [[GFEvaluateViewController alloc]init];
        evaluateView.orderId = model.orderId;
        evaluateView.isPush = YES;
        [self.navigationController pushViewController:evaluateView animated:YES];
    }
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return kHeight * 0.339 + kHeight * 0.0183;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
//    [GFTipView tipViewWithHeight:2 withTipViewMessage:@"gsag"];

    GFIndentModel *model = _dataArray[indexPath.row];
    if ([model.status isEqualToString:@"EXPIRED"]) {
        [self addAlertView:@"订单已超时"];
    }else{
        GFIndentDetialsViewController *indentDeVC = [[GFIndentDetialsViewController alloc] init];
        
        indentDeVC.model = model;
        [self.navigationController pushViewController:indentDeVC animated:YES];
    }
   
}

- (void)leftButClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
