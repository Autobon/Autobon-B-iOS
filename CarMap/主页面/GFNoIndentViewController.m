//
//  GFNoIndentViewController.m
//  车邻邦客户端
//
//  Created by 陈光法 on 16/3/10.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFNoIndentViewController.h"
#import "GFNavigationView.h"
#import "GFTextField.h"

#import "GFNoIndentTableViewCell.h"
#import "CLIndentModel.h"
#import "MJRefresh.h"
#import "GFHttpTool.h"
#import "CLIndentModel.h"
#import "UIImageView+WebCache.h"
#import "GFAlertView.h"
#import "GFTipView.h"
#import "GFOneIndentViewController.h"



@interface GFNoIndentViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    NSInteger _page;
    NSInteger _pageSize;
    
}

@property (nonatomic, strong) GFNavigationView *navView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) CGFloat cellHhh;

@end

@implementation GFNoIndentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 基础设置
    [self _setBase];
    
    // 界面搭建
    [self _setView];
}

- (void)_setBase {
    
    kWidth = [UIScreen mainScreen].bounds.size.width;
    kHeight = [UIScreen mainScreen].bounds.size.height;
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"未完成订单" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}

- (void)_setView {
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    
    
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    [_tableView.header beginRefreshing];
    _page = 1;
    _pageSize = 2;
    
}

#pragma mark - 头刷新
- (void)headRefresh{
    
    _page = 1;
    
    _modelMutableArray = [[NSMutableArray alloc]init];
    [self getListUnfinished];
    

}

#pragma mark - 尾刷新
- (void)footRefresh{
    
    _page = _page+1;
    
    [self getListUnfinished];
    
//    NSLog(@"-------");
}

#pragma mark - 获取商户未完成订单
- (void)getListUnfinished{
    
    _tableView.userInteractionEnabled = NO;
    
    [GFHttpTool postListUnfinishedDictionary:@{@"page":@(_page),@"pageSize":@(_pageSize)} success:^(id responseObject) {
//        NSLog(@"－－请求成功－－%@--",responseObject);
        if ([responseObject[@"result"] integerValue] == 1) {
            NSDictionary *dataDictionary = responseObject[@"data"];
            NSArray *listArray = dataDictionary[@"list"];
            NSArray *typeArray = @[@"隔热层",@"隐形车衣",@"车身改色",@"美容清洁"];
            
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
            
            if (listArray.count == 0) {
                [self addAlertView:@"已加载全部"];
            }
            
            GFOneIndentViewController *oneIndentView = self.navigationController.viewControllers[0];
            [oneIndentView.tipButton setTitle:[NSString stringWithFormat:@"有%@个未完成订单",dataDictionary[@"totalElements"]] forState:UIControlStateNormal];
            
            
            [listArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                CLIndentModel *model = [[CLIndentModel alloc]init];
                model.orderId = obj[@"id"];
//                NSLog(@"-------id-----%@--",model.orderId);
                model.orderNum = [NSString stringWithFormat:@"订单编号：%@",obj[@"orderNum"]];
                //                model.status = obj[@"status"];
                NSInteger type = [obj[@"orderType"] integerValue] - 1;
                model.orderType = typeArray[type];
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:[obj[@"orderTime"] floatValue]/1000];
                model.orderTime = [NSString stringWithFormat:@"预约时间：%@",[formatter stringFromDate:date]];
                model.photo = obj[@"photo"];
                model.remark = obj[@"remark"];
                
                date = [NSDate dateWithTimeIntervalSince1970:[obj[@"addTime"] floatValue]/1000];
                model.addTime = [NSString stringWithFormat:@"下单时间：%@",[formatter stringFromDate:date]];
                [_modelMutableArray addObject:model];
                
                if ([obj[@"mainTech"] isKindOfClass:[NSNull class]]) {
                    model.workName = @"";
                    model.status = @"未接单";
                }else{
                    NSDictionary *mainDictionary = obj[@"mainTech"];
                    model.workName = mainDictionary[@"name"];
                    model.status = @"已接单";
                }
                
                
            }];
            [self.tableView.header endRefreshing];
            [self.tableView.footer endRefreshing];
            [self.tableView reloadData];
            _tableView.userInteractionEnabled = YES;
        }
        
    } failure:^(NSError *error) {
        _tableView.userInteractionEnabled = YES;
//        NSLog(@"----shibaile---%@---",error);
    }];
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    return _modelMutableArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    GFNoIndentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil) {
        cell = [[GFNoIndentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    CLIndentModel *model = _modelMutableArray[indexPath.row];
    
    
//    NSLog(@"---num--%@--",model.orderNum);
    
    cell.orderNum = model.orderNum;
    cell.orderType = model.status;
    cell.beizhu = model.remark;
    cell.workCon = model.orderType;
    cell.workTime = model.orderTime;
    cell.xiadanTime = model.addTime;
    [cell.indentImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://121.40.157.200:12345%@",model.photo]] placeholderImage:[UIImage imageNamed:@"orderImage"]];
    [cell.workerBut setTitle:model.workName forState:UIControlStateNormal];
    [cell.workerBut addTarget:self action:@selector(workerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.workerBut.tag = indexPath.row;
    [cell setMessage];
    
    self.cellHhh = cell.cellHeight;
    
    
    return cell;

}

- (void)workerBtnClick:(UIButton *)button{
    
//    NSLog(@"查看技师信息");
//    NSLog(@"有人邀请");
//    NSDictionary *dictionary = Notification.userInfo[@"owner"];
//    NSDictionary *orderDictionary = Notification.userInfo[@"order"];
//    NSArray *skillArray = @[@"隔热膜",@"隐形车衣",@"车身改色",@"美容清洁"];
//    NSString *orderDetail = [NSString stringWithFormat:@"邀请你参与%@的订单，订单号%@",skillArray[[orderDictionary[@"orderType"] integerValue] - 1],orderDictionary[@"orderNum"]];
//    GFAlertView *alertView = [[GFAlertView alloc]initWithHeadImageURL:dictionary[@"avatar"] name:dictionary[@"name"] mark:[dictionary[@"starRate"] floatValue] orderNumber:[dictionary[@"unpaidOrders"] integerValue] goodNumber:1.0 order:orderDetail];
//    [alertView.okBut addTarget:self action:@selector(OrderDetailBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    CLIndentModel *model = _modelMutableArray[button.tag];
//    NSLog(@"order--%@---",model.orderId);
    [GFHttpTool GetTechnicianParameters:@{@"orderId":model.orderId} success:^(id responseObject) {
        
//        NSLog(@"－－－－%@----",responseObject);
        if ([responseObject[@"result"] integerValue] == 1) {
            NSDictionary *dataDictionary = responseObject[@"data"];
            NSDictionary *technicianDictionary = dataDictionary[@"technician"];
            GFAlertView *alertView = [[GFAlertView alloc]initWithHeadImageURL:technicianDictionary[@"avatar"] name:technicianDictionary[@"name"] mark:[dataDictionary[@"starRate"] floatValue] orderNumber:[dataDictionary[@"totalOrders"] integerValue]];
            
            [self.view addSubview:alertView];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    return self.cellHhh;
}



- (void)leftButClick {
//    GFOneIndentViewController *oneIndent = self.navigationController.viewControllers[0];
//    [oneIndent getListUnfinished];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
