//
//  GFWorkerViewController.m
//  车邻邦客户端
//
//  Created by 陈光法 on 16/3/4.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFWorkerViewController.h"
#import "GFNavigationView.h"
#import "GFTextField.h"
#import "GFWorkerTableViewCell.h"
#import "GFAddWorkerViewController.h"
#import "GFHttpTool.h"
#import "GFTipView.h"
#import "CLWorkerModel.h"

#import "GFBianjiViewController.h"

@interface GFWorkerViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    CGFloat jiange1;
    CGFloat jiange2;
    
    CGFloat jianjv1;
    
    
    
}

@property (nonatomic, strong) GFNavigationView *navView;



@end

@implementation GFWorkerViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.workerArray = [[NSMutableArray alloc] init];
    
    // 基础设置
    [self _setBase];
    
    [GFHttpTool postGetSaleListSuccess:^(id responseObject) {
//        NSLog(@"---查询业务员1－－%@--",responseObject);
        if ([responseObject[@"result"] integerValue] == 1) {
        
            NSArray *array = responseObject[@"data"];
            [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                
                CLWorkerModel *worker = [[CLWorkerModel alloc]init];
                worker.name = obj[@"name"];
                worker.workerId = obj[@"id"];
                worker.fired = [obj[@"fired"] integerValue];
                worker.phone = obj[@"phone"];
                worker.sex = obj[@"gender"];
                if ([obj[@"main"] integerValue] == 0) {
                    
                    worker.mainString = @"业务员";
                }else{
                    
                    worker.mainString = @"管理员";
                    worker.name = obj[@"shortname"];
                }
                
                [self.workerArray addObject:worker];
            }];

//            NSLog(@"------------%@", _workerArray);
            // 界面搭建
            [self _setView];
            
//            [self.tableView reloadData];
            
        }else{
            [self addAlertView:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
//        [self addAlertView:@"请求失败"];
    }];
    
    
}

- (void)httpWork {

    self.workerArray = [[NSMutableArray alloc] init];
    
    [GFHttpTool postGetSaleListSuccess:^(id responseObject) {
//        NSLog(@"---查询业务员2－－%@--",responseObject);
        if ([responseObject[@"result"] integerValue] == 1) {
            
            NSArray *array = responseObject[@"data"];
            [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                
                CLWorkerModel *worker = [[CLWorkerModel alloc]init];
                worker.name = obj[@"name"];
                worker.workerId = obj[@"id"];
                worker.fired = [obj[@"fired"] integerValue];
                worker.phone = obj[@"phone"];
                worker.sex = obj[@"gender"];
                if ([obj[@"main"] integerValue] == 0) {
                    
                    worker.mainString = @"业务员";
                }else{
                    
                    worker.mainString = @"管理员";
                    worker.name = obj[@"shortname"];
                }
                
                [self.workerArray addObject:worker];
            }];
            
//            NSLog(@"------------%@", _workerArray);
            
            [self.tableView reloadData];
            
        }else{
            [self addAlertView:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
//        [self addAlertView:@"请求失败"];
    }];

}

- (void)_setBase {
    
    kWidth = [UIScreen mainScreen].bounds.size.width;
    kHeight = [UIScreen mainScreen].bounds.size.height;
    
    jiange1 = kHeight * 0.026;
    jiange2 = kHeight * 0.011;
    
    jianjv1 = kWidth * 0.042;
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"业务员管理" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
    
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 60, 22, 40, 44)];
    [addButton setTitle:@"增加" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addWorker) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:addButton];
    
    
    
    
}


#pragma mark - 增加业务员的按钮响应方法
- (void)addWorker{
    
    GFAddWorkerViewController *addWorker = [[GFAddWorkerViewController alloc]init];

    [self.navigationController pushViewController:addWorker animated:YES];
    
}

- (void)_setView {
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + jiange1, kWidth, kHeight - 64 - jiange1) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    
    
    
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    return _workerArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *ID = @"cell";
    GFWorkerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil) {
        
        cell = [[GFWorkerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    CLWorkerModel *worker = _workerArray[indexPath.row];
    cell.leftLab.text = worker.name;
    cell.centerLab.text = worker.mainString;
    if (indexPath.row == 0) {
        cell.rightBut.hidden = YES;
        cell.bianjiBut.hidden = YES;
    }else{

        cell.rightBut.hidden = NO;
        cell.bianjiBut.hidden = NO;

        if (worker.fired) {
            cell.rightBut.userInteractionEnabled = NO;
            cell.rightBut.alpha = 0.3;
            cell.bianjiBut.userInteractionEnabled = NO;
            cell.bianjiBut.alpha = 0.3;
        }else{
            cell.rightBut.alpha = 1.0;
            cell.rightBut.tag = indexPath.row;
            cell.rightBut.userInteractionEnabled = YES;
            [cell.rightBut addTarget:self action:@selector(moveWorker:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.bianjiBut.alpha = 1.0;
            cell.bianjiBut.tag = indexPath.row + 100000;
            cell.bianjiBut.userInteractionEnabled = YES;
            [cell.bianjiBut addTarget:self action:@selector(bianjiButClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {


    return kHeight * 0.078 + jiange2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)setGFViewWithY:(CGFloat)y withLeftText:(NSString *)leftStr withCenterText:(NSString *)centerStr withRightBut:(UIButton *)righntBut {

    CGFloat baseViewW = kWidth;
    CGFloat baseViewH = kHeight * 0.078;
    CGFloat baseViewX = 0;
    CGFloat baseViewY = y;
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView];
    
    UILabel *leftLab = [[UILabel alloc] initWithFrame:CGRectMake(jianjv1, 0, kWidth, baseViewH)];
    leftLab.text = leftStr;
    leftLab.textAlignment = NSTextAlignmentLeft;
    leftLab.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    [baseView addSubview:leftLab];
    
}

#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
}

#pragma mark - 编辑按钮
- (void)bianjiButClick:(UIButton *)sender {

    CLWorkerModel *worker = _workerArray[sender.tag - 100000];
    GFBianjiViewController *bianjiVC = [[GFBianjiViewController alloc] init];
    bianjiVC.model = worker;
//    NSLog(@"传递过去的编辑模型%@,,,%@", bianjiVC.model.name, bianjiVC.model.phone);
    [self.navigationController pushViewController:bianjiVC animated:YES];
    
//    NSLog(@"编辑员工信息====%ld", sender.tag);
//
//    NSLog(@"111111111111111%@", self);
}

#pragma mark - 移除业务员按钮
- (void)moveWorker:(UIButton *)button{
//    NSLog(@"移除业务员");
    CLWorkerModel *worker = _workerArray[button.tag];
    [GFHttpTool postSaleFiredDictionary:@{@"coopAccountId":worker.workerId} success:^(id responseObject) {
//        NSLog(@"----responseObject---%@--",responseObject);
        if ([responseObject[@"result"] integerValue] == 1) {
//            [_workerArray removeObject:worker];
            worker.fired = YES;
            [_tableView reloadData];
        }else{
            [self addAlertView:responseObject[@"message"]];
        }
        
    } failure:^(NSError *error) {
//        [self addAlertView:@"请求失败"];
    }];
    
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
