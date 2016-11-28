//
//  GFDetailPeoViewController.m
//  CarMapB
//
//  Created by 陈光法 on 16/11/22.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFDetailPeoViewController.h"
#import "GFNavigationView.h"
#import "CLAddPersonModel.h"
#import "UIImageView+WebCache.h"
#import "GFHttpTool.h"

@interface GFDetailPeoViewController () {
    
    CGFloat kWidth;
    CGFloat kHieght;
}

@end

@implementation GFDetailPeoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
    kWidth = [UIScreen mainScreen].bounds.size.width;
    kHieght = [UIScreen mainScreen].bounds.size.height;
    
    // 添加导航
    [self setNavigation];
    
    // 布局界面
    [self _setPeoView];
    
}


- (void)_setPeoView {
    
    // 头像
    UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 80, 80, 80)];
    iconImgView.contentMode = UIViewContentModeScaleAspectFit;
    iconImgView.layer.cornerRadius = 40;
    NSURL *imgUrl = [NSURL URLWithString:_model.avatar];
    [iconImgView sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"userHeadImage"]];
    iconImgView.clipsToBounds = YES;
    [self.view addSubview:iconImgView];
    
    // 姓名
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconImgView.frame) + 10, 75, 150, 40)];
    nameLab.font = [UIFont systemFontOfSize:20];
    nameLab.text = _model.name;
    nameLab.textColor = [UIColor darkGrayColor];
    [self.view addSubview:nameLab];
    
    // 手机号
    UIButton *phoneBut = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneBut.frame = CGRectMake(nameLab.frame.origin.x, CGRectGetMaxY(nameLab.frame) + 5, 150, 20);
    [phoneBut setImage:[UIImage imageNamed:@"iPhone"] forState:UIControlStateNormal];
    phoneBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    phoneBut.titleLabel.font = [UIFont systemFontOfSize:12];
    [phoneBut setTitle:[NSString stringWithFormat:@"  %@", _model.phone] forState:UIControlStateNormal];
    [phoneBut setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.view addSubview:phoneBut];
    
    // 距离
    UIButton *distanceBut = [UIButton buttonWithType:UIButtonTypeCustom];
    distanceBut.frame = CGRectMake(nameLab.frame.origin.x, CGRectGetMaxY(phoneBut.frame), 150, 20);
    [distanceBut setImage:[UIImage imageNamed:@"distance"] forState:UIControlStateNormal];
    distanceBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    distanceBut.titleLabel.font = [UIFont systemFontOfSize:12];
    [distanceBut setTitle:[NSString stringWithFormat:@"  %@km", _model.distance] forState:UIControlStateNormal];
    [distanceBut setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.view addSubview:distanceBut];
    
    
    // 指派按钮
    UIButton *zhipaiBut = [UIButton buttonWithType:UIButtonTypeCustom];
    zhipaiBut.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 70, 80, 60, 30);
    [zhipaiBut setTitle:@"指派" forState:UIControlStateNormal];
    zhipaiBut.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    zhipaiBut.layer.borderWidth = 1;
    zhipaiBut.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
    zhipaiBut.layer.cornerRadius = 4;
    zhipaiBut.titleLabel.font = [UIFont systemFontOfSize:16];
    [zhipaiBut addTarget:self action:@selector(zhipaiButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zhipaiBut];
    
    // 横线1
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(iconImgView.frame) + 10, [UIScreen mainScreen].bounds.size.width - 20, 1)];
    lineView1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView1];
    
    // 订单数、弃单数、好评率
    NSArray *textArr = @[_model.orderCount, _model.cancelCount, _model.evaluate];
    NSArray *labArr = @[@"订单数", @"弃单次数", @"好评率"];
    CGFloat maxY = 0;
    for(int i=0; i<3; i++) {
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 3.0 * i, CGRectGetMaxY(lineView1.frame), [UIScreen mainScreen].bounds.size.width / 3.0, 40)];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = textArr[i];
        lab.font = [UIFont systemFontOfSize:16];
        lab.textColor = [UIColor darkGrayColor];
        [self.view addSubview:lab];
        
        UILabel *downLab = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 3.0 * i, CGRectGetMaxY(lab.frame), [UIScreen mainScreen].bounds.size.width / 3.0, 10)];
        downLab.textAlignment = NSTextAlignmentCenter;
        downLab.text = labArr[i];
        downLab.font = [UIFont systemFontOfSize:10];
        downLab.textColor = [UIColor darkGrayColor];
        [self.view addSubview:downLab];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 3.0 * (i + 1), CGRectGetMaxY(lineView1.frame) + 10, 1, 40)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:lineView];
        
        maxY = CGRectGetMaxY(downLab.frame);
    }
    
    // 横线2
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, maxY + 10, [UIScreen mainScreen].bounds.size.width, 1)];
    lineView2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView2];
    
    // 横线3
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView2.frame) + 10, [UIScreen mainScreen].bounds.size.width, 1)];
    lineView3.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView3];
    
    // 隔热膜
    NSString *ss1 = [NSString stringWithFormat:@"%@年", _model.fileWorkingSeniority];
    NSInteger xx1 = [_model.filmLevel integerValue];
    UIView *gg = [self setViewWithTitle:@"隔热膜" withXingji:xx1 withNianxian:ss1 withY:CGRectGetMaxY(lineView3.frame) + 15];
    
    // 隐形车衣
    NSString *ss2 = [NSString stringWithFormat:@"%@年", _model.carCoverWorkingSeniority];
    NSInteger xx2 = [_model.carCoverLevel integerValue];
    UIView *yy = [self setViewWithTitle:@"隐形车衣" withXingji:xx2 withNianxian:ss2 withY:CGRectGetMaxY(gg.frame) + 10];
    
    // 车身改色
    NSString *ss3 = [NSString stringWithFormat:@"%@年", _model.colorModifyWorkingSeniority];
    NSInteger xx3 = [_model.colorModifyLevel integerValue];
    UIView *cc = [self setViewWithTitle:@"车身改色" withXingji:xx3 withNianxian:ss3 withY:CGRectGetMaxY(yy.frame) + 10];
    
    // 美容清洁
    NSString *ss4 = [NSString stringWithFormat:@"%@年", _model.beautyWorkingSeniority];
    NSInteger xx4 = [_model.beautyLevel integerValue];
    UIView *rr = [self setViewWithTitle:@"美容清洁" withXingji:xx4 withNianxian:ss4 withY:CGRectGetMaxY(cc.frame) + 10];
    
    // 横线4
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(rr.frame) + 20, [UIScreen mainScreen].bounds.size.width, 1)];
    lineView4.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView4];
}

- (UIView *)setViewWithTitle:(NSString *)title withXingji:(NSInteger)xingji withNianxian:(NSString *)nianxian withY:(CGFloat)y {

    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, 30)];
    [self.view addSubview:vv];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 30)];
    lab.font = [UIFont systemFontOfSize:14];
    lab.text = title;
    lab.textColor = [UIColor darkGrayColor];
    [vv addSubview:lab];
    
    for(int i=0; i<5; i++) {
    
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab.frame) + 10 + 30 * i, 1, 28, 28)];
        imgView.image = [UIImage imageNamed:@"detailsStarDark"];
        [vv addSubview:imgView];
    }
    
    for(int i=0; i<xingji; i++) {
    
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab.frame) + 9.5 + 30 * i, 0.5, 28.5, 28.5)];
        imgView.image = [UIImage imageNamed:@"detailsStar"];
        [vv addSubview:imgView];
    }
    
    UILabel *ll = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 110, 0, 100, 30)];
    ll.font = [UIFont systemFontOfSize:14];
    ll.text = nianxian;
    ll.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    ll.textAlignment = NSTextAlignmentRight;
    [vv addSubview:ll];
    
    return vv;
}


- (void)zhipaiButClick:(UIButton *)sender {
    
    NSLog(@"===%@", _model.distance);
    
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    mDic[@"orderId"] = _model.orderID;
    mDic[@"techId"] = _model.jishiID;
    
    [GFHttpTool postAppintTechForOrder:mDic Success:^(id responseObject) {
        
        NSLog(@"指派技师返回的数据＝＝＝＝%@", responseObject);
        if([responseObject[@"status"] integerValue] == 1) {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    } failure:^(NSError *error) {
        
        
    }];
}







// 添加导航
- (void)setNavigation{
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"车邻邦" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //    [navView.rightBut addTarget:navView action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navView];
    
    
}
- (void)backBtnClick{
    /*
     if (_isAdd) {
     CLHomeOrderViewController *homeOrder = self.navigationController.viewControllers[0];
     [homeOrder headRefresh];
     }
     */
    
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
