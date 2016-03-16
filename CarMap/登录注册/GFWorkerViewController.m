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



@interface GFWorkerViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    CGFloat jiange1;
    CGFloat jiange2;
    
    CGFloat jianjv1;
}

@property (nonatomic, strong) GFNavigationView *navView;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation GFWorkerViewController

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

    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil) {
        
        cell = [[GFWorkerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {


    return kHeight * 0.078 + jiange2;
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
