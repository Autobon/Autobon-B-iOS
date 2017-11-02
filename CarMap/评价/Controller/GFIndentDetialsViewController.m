//
//  GFIndentDetialsViewController.m
//  车邻邦客户端
//
//  Created by 陈光法 on 16/3/3.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFIndentDetialsViewController.h"
#import "GFNavigationView.h"
#import "GFTextField.h"
#import "GFTitleView.h"
#import "GFEvaluateViewController.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "GFHttpTool.h"
#import "GFTipView.h"
#import "ACETelPrompt.h"

#import "HZPhotoBrowser.h"

#import "CLImageView.h"
#import "MYImageView.h"



@interface GFIndentDetialsViewController () <HZPhotoBrowserDelegate> {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    CGFloat jiange1;
    CGFloat jiange2;
    CGFloat jiange3;
    CGFloat jiange4;

    CGFloat jianjv1;
    CGFloat jianjv2;
    
    UIScrollView *_scrollView;
    
    
    CGFloat beMaxY;
    CGFloat afMaxY;
    
    NSMutableArray *_beforeImageArray;
    NSMutableArray *_afterImageArray;
    
    NSString *_phoneString;
}

@property (nonatomic, strong) GFNavigationView *navView;

@property (nonatomic, strong) UILabel *bianhaoLab;
@property (nonatomic, strong) UILabel *tiemoLab;
@property (nonatomic, strong) UILabel *timeLab;

@property (nonatomic, strong) NSMutableArray *photoMarr;
@property (nonatomic, strong) NSArray *curPhotoArr;

@end

@implementation GFIndentDetialsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height)];
    _scrollView.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(0, 1000);
    
    [self.view addSubview:_scrollView];
    
    // 基础设置
    [self _setBase];
    
    // 界面搭建
    [self _setView];
    
    
    
}

- (void)_setBase {
    
    kWidth = [UIScreen mainScreen].bounds.size.width;
    kHeight = [UIScreen mainScreen].bounds.size.height;
    
    jiange1 = kHeight * 0.015625;   // 30
    jiange2 = kHeight * 0.0182;     // 35
    jiange3 = kHeight * 0.01;       // 20
    jiange4 = kHeight * 0.021;

    jianjv1 = kWidth * 0.0417;
    jianjv2 = kWidth * 0.037;
    
   
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"订单详情" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}

- (void)_setView {
    
    NSArray *arr1 = [self.model.photo componentsSeparatedByString:@","];
    NSArray *arr2 = [self.model.beforePhotos componentsSeparatedByString:@","];
    NSArray *arr3 = [self.model.afterPhotos componentsSeparatedByString:@","];
    self.photoMarr = [[NSMutableArray alloc] init];
    [self.photoMarr addObject:arr1];
    [self.photoMarr addObject:arr2];
    [self.photoMarr addObject:arr3];
    self.curPhotoArr = self.photoMarr[0];
    
    
    
    CGFloat baseViewW = kWidth;
    CGFloat baseViewH = 500;
    CGFloat baseViewX = 0;
//    CGFloat baseViewY = jiange1;
    CGFloat baseViewY = 0;
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
    baseView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:baseView];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(_navView.mas_bottom);
    }];
    
    // 订单编号
    CGFloat bianhaoLabW = 0.7 * kWidth;
    CGFloat bianhaoLabH = kHeight * 0.026;
    CGFloat bianhaoLabX = jianjv1;
    CGFloat bianhaoLabY = jiange2;
    self.bianhaoLab = [[UILabel alloc] initWithFrame:CGRectMake(bianhaoLabX, bianhaoLabY, bianhaoLabW, bianhaoLabH)];
    self.bianhaoLab.text = [NSString stringWithFormat:@"订单编号：%@",_model.orderNum];
    self.bianhaoLab.font = [UIFont systemFontOfSize:11 / 320.0 * kWidth];
    [baseView addSubview:self.bianhaoLab];
    
    // 订单类型
    CGFloat tiemoLabW = bianhaoLabW;
    CGFloat tiemoLabH = bianhaoLabH;
    CGFloat tiemoLabX = bianhaoLabX;
    CGFloat tiemoLabY = CGRectGetMaxY(self.bianhaoLab.frame);
    self.tiemoLab = [[UILabel alloc] initWithFrame:CGRectMake(tiemoLabX, tiemoLabY, tiemoLabW, tiemoLabH)];
    self.tiemoLab.text = _model.typeName;
    self.tiemoLab.font = [UIFont systemFontOfSize:11 / 320.0 * kWidth];
    self.tiemoLab.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [baseView addSubview:self.tiemoLab];
    
    
    
//    self.bianhaoLab.frame = CGRectMake(bianhaoLabX, CGRectGetMaxY(self.tiemoLab.frame) + jiange3, bianhaoLabW, bianhaoLabH);
    
    
    
    // 预约时间
    CGFloat timeLabW = bianhaoLabW;
    CGFloat timeLabH = bianhaoLabH;
    CGFloat timeLabX = bianhaoLabX;
    CGFloat timeLabY = CGRectGetMaxY(self.tiemoLab.frame);
    self.timeLab = [[UILabel alloc] initWithFrame:CGRectMake(timeLabX, timeLabY, timeLabW, timeLabH)];
    self.timeLab.text = [NSString stringWithFormat:@"预约施工时间：%@",_model.agreedStartTime];
    self.timeLab.font = [UIFont systemFontOfSize:11 / 320.0 * kWidth];
    self.timeLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
    [baseView addSubview:self.timeLab];
    
    // 去评价按钮
    CGFloat pingjiaButW = kWidth * 0.185;
    CGFloat pingjiaButH = kHeight * 0.042;
    CGFloat pingjiaButX = kWidth - jianjv1 - pingjiaButW;
    CGFloat pingjiaButY = CGRectGetMinY(self.bianhaoLab.frame) + jiange3 + 3 / 568.0 * kHeight;
    UIButton *pingjiaBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [pingjiaBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
    pingjiaBut.frame = CGRectMake(pingjiaButX, pingjiaButY, pingjiaButW, pingjiaButH);
    pingjiaBut.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
    pingjiaBut.layer.borderWidth = 1;
    pingjiaBut.layer.cornerRadius = 5;
    [pingjiaBut addTarget:self action:@selector(pingjiaButClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if([_model.status isEqualToString:@"FINISHED"]) {
        
        [pingjiaBut setTitle:@"去评价" forState:UIControlStateNormal];
        [pingjiaBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];pingjiaBut.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
        pingjiaBut.enabled = YES;
    }else if([_model.status isEqualToString:@"COMMENTED"]) {
        
        [pingjiaBut setTitle:@"已评价" forState:UIControlStateNormal];
        [pingjiaBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:0.5] forState:UIControlStateNormal];
        pingjiaBut.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:0.5] CGColor];
        pingjiaBut.enabled = NO;
    }else {
        
        [pingjiaBut setTitle:@"已撤消" forState:UIControlStateNormal];
        pingjiaBut.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:0.5] CGColor];
        [pingjiaBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:0.5] forState:UIControlStateNormal];
        pingjiaBut.enabled = NO;
    }
    
//    if([_model.status isEqualToString:@"FINISHED"]) {
//    
////        if ([_model.commentDictionary isKindOfClass:[NSNull class]]) {
////            [pingjiaBut setTitle:@"去评价" forState:UIControlStateNormal];
////            [pingjiaBut addTarget:self action:@selector(judgeBtnClick) forControlEvents:UIControlEventTouchUpInside];
////        }else{
////            [pingjiaBut setTitle:@"已评价" forState:UIControlStateNormal];
////        }
//    }else {
//    
//        [pingjiaBut setTitle:@"去评价" forState:UIControlStateNormal];
//        pingjiaBut.userInteractionEnabled = NO;
//        pingjiaBut.alpha = 0.3;
//    }
    
    
//    [pingjiaBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
    pingjiaBut.titleLabel.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    [baseView addSubview:pingjiaBut];
    
    // 边线
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(jianjv2, CGRectGetMaxY(self.timeLab.frame) + jiange2, kWidth - jianjv2 * 2.0, 1)];
    lineView1.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [baseView addSubview:lineView1];
    
    // 订单图片
    CGFloat imgViewW = (kWidth - 40) / 3.0;
    CGFloat imgViewH = (kWidth - 40) / 3.0;
    CGFloat imgViewY = CGRectGetMaxY(self.timeLab.frame) + jiange1 + jiange2;
    NSInteger sum = self.model.photoArr.count;
    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    for(int i=0; i<sum; i++) {
    
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake((i % 3) * (imgViewW + 10) + 10 , imgViewY + (i / 3) * (imgViewH + 10), imgViewW, imgViewH);
        but.tag = i + 1;
        [but setBackgroundImage:[UIImage imageNamed:@"orderImage"] forState:UIControlStateNormal];
        NSString *ss = [NSString stringWithFormat:@"%@%@",BaseHttp ,self.model.photoArr[i]];
        [but sd_setImageWithURL:[NSURL URLWithString: ss] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"orderImage"]];
        [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
        [baseView addSubview:but];
        
        [but setTitle:@"订单" forState:UIControlStateNormal];
        
        if(i == sum - 1) {
        
            but1 = but;
        }
    }
    
//    UIButton *imgView = [UIButton buttonWithType:UIButtonTypeCustom];
//    imgView.frame = CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH);
////    imgView.backgroundColor = [UIColor redColor];
//    imgView.contentMode = UIViewContentModeScaleAspectFit;
//    extern NSString* const URLHOST;
//    [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URLHOST,_model.photo]] placeholderImage:[UIImage imageNamed:@"orderImage"]];
    
//    [baseView addSubview:imgView];
    
    // 边线
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(jianjv2, CGRectGetMaxY(but1.frame) + jiange1, kWidth - jianjv2 * 2.0, 1)];
    lineView2.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [baseView addSubview:lineView2];
    
    // 下单备注
    CGFloat lab4W = kWidth * 0.2;
    CGFloat lab4H = kHeight * 0.026;
    CGFloat lab4X = jianjv2;
    CGFloat lab4Y = CGRectGetMaxY(lineView2.frame) + jiange4;
    UILabel *lab4 = [[UILabel alloc] initWithFrame:CGRectMake(lab4X, lab4Y, lab4W, lab4H)];
//    lab4.backgroundColor = [UIColor redColor];
    [baseView addSubview:lab4];
    lab4.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    lab4.text = @"下单备注: ";
    NSString *lab4Str = _model.remark;
    NSMutableDictionary *lab4Dic = [[NSMutableDictionary alloc] init];
    lab4Dic[NSFontAttributeName] = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    lab4Dic[NSForegroundColorAttributeName] = [UIColor blackColor];
    CGRect fenRect4 = [lab4Str boundingRectWithSize:CGSizeMake(kWidth - lab4W - lab4X * 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:lab4Dic context:nil];
    CGFloat contLab4W = kWidth - lab4W - lab4X * 2;
    CGFloat contLab4H = fenRect4.size.height;
    CGFloat contLab4X = CGRectGetMaxX(lab4.frame);
    CGFloat contLab4Y = lab4Y;
    UILabel *contLab4 = [[UILabel alloc] initWithFrame:CGRectMake(contLab4X, contLab4Y, contLab4W, contLab4H)];
    contLab4.numberOfLines = 0;
    contLab4.text = lab4Str;
    contLab4.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    [baseView addSubview:contLab4];
    
    // 边线
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(jianjv2, CGRectGetMaxY(contLab4.frame) + jiange4, kWidth - jianjv2 * 2.0, 1)];
    lineView3.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [baseView addSubview:lineView3];
    
    
    // 订单创建时间
    CGFloat lab5W = kWidth * 0.3;
    CGFloat lab5H = kHeight * 0.026;
    CGFloat lab5X = jianjv2;
    CGFloat lab5Y = CGRectGetMaxY(contLab4.frame) + jiange4 * 2;
    UILabel *lab5 = [[UILabel alloc] initWithFrame:CGRectMake(lab5X, lab5Y, lab5W, lab5H)];
//    lab5.backgroundColor = [UIColor redColor];
    [baseView addSubview:lab5];
//    lab5.backgroundColor = [UIColor redColor];
    lab5.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    lab5.text = @"订单创建时间: ";
    NSString *lab5Str = _model.createTime;
    NSMutableDictionary *lab5Dic = [[NSMutableDictionary alloc] init];
    lab5Dic[NSFontAttributeName] = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    lab5Dic[NSForegroundColorAttributeName] = [UIColor blackColor];
    CGRect fenRect5 = [lab5Str boundingRectWithSize:CGSizeMake(kWidth - lab5W - lab5X * 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:lab5Dic context:nil];
    CGFloat contLab5W = kWidth - lab5W - lab5X * 2;
    CGFloat contLab5H = fenRect5.size.height;
    CGFloat contLab5X = CGRectGetMaxX(lab5.frame);
    CGFloat contLab5Y = lab5Y;
    UILabel *contLab5 = [[UILabel alloc] initWithFrame:CGRectMake(contLab5X, contLab5Y, contLab5W, contLab5H)];
    contLab5.numberOfLines = 0;
    contLab5.text = lab5Str;
    contLab5.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    [baseView addSubview:contLab5];
    
    
    // 边线
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(jianjv2, CGRectGetMaxY(contLab5.frame) + jiange4, kWidth - jianjv2 * 2.0, 1)];
    lineView4.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [baseView addSubview:lineView4];
    
    
    // 订单创建时间
    CGFloat lab55W = kWidth * 0.3;
    CGFloat lab55H = kHeight * 0.026;
    CGFloat lab55X = jianjv2;
    CGFloat lab55Y = CGRectGetMaxY(contLab5.frame) + jiange4 * 2;
    UILabel *lab55 = [[UILabel alloc] initWithFrame:CGRectMake(lab55X, lab55Y, lab55W, lab55H)];
    //    lab5.backgroundColor = [UIColor redColor];
    [baseView addSubview:lab55];
    //    lab5.backgroundColor = [UIColor redColor];
    lab55.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    lab55.text = @"施工开始时间: ";
    NSString *lab55Str = _model.startTime;
    NSMutableDictionary *lab55Dic = [[NSMutableDictionary alloc] init];
    lab55Dic[NSFontAttributeName] = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    lab55Dic[NSForegroundColorAttributeName] = [UIColor blackColor];
    CGRect fenRect55 = [lab55Str boundingRectWithSize:CGSizeMake(kWidth - lab55W - lab55X * 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:lab55Dic context:nil];
    CGFloat contLab55W = kWidth - lab55W - lab55X * 2;
    CGFloat contLab55H = fenRect55.size.height;
    CGFloat contLab55X = CGRectGetMaxX(lab55.frame);
    CGFloat contLab55Y = lab55Y;
    UILabel *contLab55 = [[UILabel alloc] initWithFrame:CGRectMake(contLab55X, contLab55Y, contLab55W, contLab55H)];
    contLab55.numberOfLines = 0;
    contLab55.text = lab55Str;
    contLab55.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    [baseView addSubview:contLab55];
    
    
    // 边线
    UIView *lineView444 = [[UIView alloc] initWithFrame:CGRectMake(jianjv2, CGRectGetMaxY(contLab55.frame) + jiange4, kWidth - jianjv2 * 2.0, 1)];
    lineView444.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [baseView addSubview:lineView444];
    
    
    // 施工结束时间
    CGFloat lab56W = kWidth * 0.3;
    CGFloat lab56H = kHeight * 0.026;
    CGFloat lab56X = jianjv2;
    CGFloat lab56Y = CGRectGetMaxY(contLab55.frame) + jiange4 * 2;
    UILabel *lab56 = [[UILabel alloc] initWithFrame:CGRectMake(lab56X, lab56Y, lab56W, lab56H)];
    //    lab5.backgroundColor = [UIColor redColor];
    [baseView addSubview:lab56];
    lab56.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    lab56.text = @"施工结束时间: ";
    NSString *lab56Str = _model.endTime;
    NSMutableDictionary *lab56Dic = [[NSMutableDictionary alloc] init];
    lab56Dic[NSFontAttributeName] = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    lab56Dic[NSForegroundColorAttributeName] = [UIColor blackColor];
    CGRect fenRect56 = [lab56Str boundingRectWithSize:CGSizeMake(kWidth - lab56W - lab56X * 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:lab56Dic context:nil];
    CGFloat contLab56W = kWidth - lab56W - lab56X * 2;
    CGFloat contLab56H = fenRect56.size.height;
    CGFloat contLab56X = CGRectGetMaxX(lab56.frame);
    CGFloat contLab56Y = lab56Y;
    UILabel *contLab56 = [[UILabel alloc] initWithFrame:CGRectMake(contLab56X, contLab56Y, contLab56W, contLab56H)];
    contLab56.numberOfLines = 0;
    contLab56.text = lab56Str;
    contLab56.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    [baseView addSubview:contLab56];
    
    // 边线
    UIView *lineView44 = [[UIView alloc] initWithFrame:CGRectMake(jianjv2, CGRectGetMaxY(contLab56.frame) + jiange4, kWidth - jianjv2 * 2.0, 1)];
    lineView44.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [baseView addSubview:lineView44];
    
    
    // 最迟交车时间
    CGFloat lab6W = kWidth * 0.3;
    CGFloat lab6H = kHeight * 0.026;
    CGFloat lab6X = jianjv2;
    CGFloat lab6Y = CGRectGetMaxY(lineView44.frame) + jiange4;
    UILabel *lab6 = [[UILabel alloc] initWithFrame:CGRectMake(lab6X, lab6Y, lab6W, lab6H)];
    [baseView addSubview:lab6];
    lab6.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    // 获取项目
    lab6.text = @"最迟交车时间:";
//    NSString *lab6Str = self.itemStr;
    NSString *lab6Str = self.model.agreedEndTime;
    NSMutableDictionary *lab6Dic = [[NSMutableDictionary alloc] init];
    lab6Dic[NSFontAttributeName] = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    lab6Dic[NSForegroundColorAttributeName] = [UIColor blackColor];
    CGRect fenRect6 = [lab6Str boundingRectWithSize:CGSizeMake(kWidth - lab6W - lab6X * 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:lab6Dic context:nil];
    CGFloat contLab6W = kWidth - lab6W - lab6X * 2;
    CGFloat contLab6H = fenRect6.size.height;
    CGFloat contLab6X = CGRectGetMaxX(lab6.frame);
    CGFloat contLab6Y = lab6Y;
    UILabel *contLab6 = [[UILabel alloc] initWithFrame:CGRectMake(contLab6X, contLab6Y, contLab6W, contLab6H)];
    contLab6.numberOfLines = 0;
    contLab6.text = lab6Str;
    contLab6.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    [baseView addSubview:contLab6];
    
    // 边线
    UIView *lineView10 = [[UIView alloc] initWithFrame:CGRectMake(jianjv2, CGRectGetMaxY(contLab6.frame) + jiange4, kWidth - jianjv2 * 2.0, 1)];
    lineView10.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [baseView addSubview:lineView10];
    
    // 施工人员
    CGFloat lab7W = kWidth * 0.2;
    CGFloat lab7H = kHeight * 0.026;
    CGFloat lab7X = jianjv2;
    CGFloat lab7Y = CGRectGetMaxY(lineView10.frame) + jiange4;
    UILabel *lab7 = [[UILabel alloc] initWithFrame:CGRectMake(lab7X, lab7Y, lab7W, lab7H)];
    [baseView addSubview:lab7];
    lab7.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    lab7.text = @"施工人员: ";
//    NSString *workers = @"";
//    NSLog(@"施工人员数组＝＝＝＝＝＝＝＝%@", self.model.workerArr);
//    for(NSString *str in self.model.techName) {
//        
//        if([workers isEqualToString:@""]) {
//            
//            workers = [NSString stringWithFormat:@"%@", str];
//        }else {
//            
//            workers = [NSString stringWithFormat:@"%@,%@", workers, str];
//        }
//        
//    }
    NSString *lab7Str = self.model.techName;
    NSMutableDictionary *lab7Dic = [[NSMutableDictionary alloc] init];
    lab7Dic[NSFontAttributeName] = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    lab7Dic[NSForegroundColorAttributeName] = [UIColor blackColor];
    CGRect fenRect7 = [lab7Str boundingRectWithSize:CGSizeMake(kWidth - lab7W - lab7X * 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:lab7Dic context:nil];
    CGFloat contLab7W = kWidth - lab7W - lab7X * 2;
    CGFloat contLab7H = fenRect7.size.height;
    CGFloat contLab7X = CGRectGetMaxX(lab7.frame);
    CGFloat contLab7Y = lab7Y;
    UILabel *contLab7 = [[UILabel alloc] initWithFrame:CGRectMake(contLab7X, contLab7Y, contLab7W, contLab7H)];
    contLab7.numberOfLines = 0;
    contLab7.text = lab7Str;
    if(lab7Str.length == 0) {
    
        contLab7.text = @"无";
    }
    contLab7.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    [baseView addSubview:contLab7];
    
    // 边线
    UIView *lineView11 = [[UIView alloc] initWithFrame:CGRectMake(jianjv2, CGRectGetMaxY(contLab7.frame) + jiange4, kWidth - jianjv2 * 2.0, 1)];
    lineView11.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [baseView addSubview:lineView11];
    
    // 下边线的Y值
    CGFloat lineYY = 0;
    CGFloat lineY = 0;
    
    // 施工前照片
    CGFloat beforeLabW = kWidth - jianjv2 * 2.0;
    CGFloat beforeLabH = kHeight * 0.026;
    CGFloat beforeLabX = jianjv2;
    CGFloat beforeLabY = CGRectGetMaxY(lineView11.frame) + jiange4;
    UILabel *beforeLab = [[UILabel alloc] initWithFrame:CGRectMake(beforeLabX, beforeLabY, beforeLabW, beforeLabH)];
    beforeLab.text = @"施工前照片";
    beforeLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
    [baseView addSubview:beforeLab];
    // 照片
    NSString *bePhotoStr = self.model.beforePhotos;
    
    if([bePhotoStr isEqualToString:@"无"]) {
        
        beMaxY = CGRectGetMaxY(beforeLab.frame) + jiange4;
        beforeLab.text = @"施工前照片：该订单未完成，暂无照片";
        
        lineYY = beMaxY;
    }else {
        
//        NSArray *bePhotoArr = [bePhotoStr componentsSeparatedByString:@","];
//        NSInteger num = bePhotoArr.count;
//        extern NSString* const URLHOST;
//        _beforeImageArray = [[NSMutableArray alloc]init];
//        for(int i=0; i<num; i++) {
//            
//            [self addBeforImgView:[NSString stringWithFormat:@"%@%@", URLHOST, bePhotoArr[i]] withPhotoIndex:i + 1 withFirstY:CGRectGetMaxY(beforeLab.frame) + jiange4 showInView:baseView];
//        }
        
        
        NSInteger sum = self.model.beforePhotosArr.count;
        UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        for(int i=0; i<sum; i++) {
            
            UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
            but.frame = CGRectMake((i % 3) * (imgViewW + 10) + 10 , CGRectGetMaxY(beforeLab.frame) + jiange4 + (i / 3) * (imgViewH + 10), imgViewW, imgViewH);
            but.tag = i + 1;
            [but setBackgroundImage:[UIImage imageNamed:@"orderImage"] forState:UIControlStateNormal];
            NSString *ss = [NSString stringWithFormat:@"%@%@",BaseHttp, self.model.beforePhotosArr[i]];
            [but sd_setImageWithURL:[NSURL URLWithString: ss] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"orderImage"]];
            [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
            [baseView addSubview:but];
            
            [but setTitle:@"施工前" forState:UIControlStateNormal];
            
            if(i == sum - 1) {
                
                but1 = but;
            }
        }
        
        
        lineYY = CGRectGetMaxY(but1.frame) + jianjv1;
    }
    
    
    
    // 边线
    UIView *lineView12 = [[UIView alloc] initWithFrame:CGRectMake(jianjv2, lineYY, kWidth - jianjv2 * 2.0, 1)];

    lineView12.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [baseView addSubview:lineView12];
    
    
    // 施工后照片
    CGFloat afPhotoLabW = beforeLabW;
    CGFloat afPhotoLabH = beforeLabH;
    CGFloat afPhotoLabX = beforeLabX;
    CGFloat afPhotoLabY = CGRectGetMaxY(lineView12.frame) + jiange4;
    UILabel *afPhotoLab = [[UILabel alloc] initWithFrame:CGRectMake(afPhotoLabX, afPhotoLabY, afPhotoLabW, afPhotoLabH)];
    afPhotoLab.text = @"施工后照片";
    afPhotoLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
    [baseView addSubview:afPhotoLab];
    //照片
    NSString *afPhotoStr = self.model.afterPhotos;
//    NSLog(@"+++++---+++++%@", afPhotoStr);
    if([afPhotoStr isEqualToString:@"无"]) {
    
        afMaxY = CGRectGetMaxY(afPhotoLab.frame) + jiange4;
        afPhotoLab.text = @"施工后照片：该订单未完成，暂无照片";
        lineY = afMaxY;

    }else {
    
//        NSArray *afPhotoArr = [afPhotoStr componentsSeparatedByString:@","];
//        NSInteger sum = afPhotoArr.count;
//        extern NSString* const URLHOST;
//        _afterImageArray = [[NSMutableArray alloc]init];
//        for(int i=0; i<sum; i++) {
//            
//            [self addAfterImgView:[NSString stringWithFormat:@"%@%@", URLHOST, afPhotoArr[i]] withPhotoIndex:i + 1 withFirstY:CGRectGetMaxY(afPhotoLab.frame) + jiange4 showInView:baseView];
//        }
        
        
        NSInteger sum = self.model.afterPhotosArr.count;
        UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        for(int i=0; i<sum; i++) {
            
            UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
            but.frame = CGRectMake((i % 3) * (imgViewW + 10) + 10 , CGRectGetMaxY(afPhotoLab.frame) + jiange4 + (i / 3) * (imgViewH + 10), imgViewW, imgViewH);
            but.tag = i + 1;
            [but setBackgroundImage:[UIImage imageNamed:@"orderImage"] forState:UIControlStateNormal];
            NSString *ss = [NSString stringWithFormat:@"%@%@",BaseHttp, self.model.afterPhotosArr[i]];
            [but sd_setImageWithURL:[NSURL URLWithString: ss] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"orderImage"]];
            [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
            [baseView addSubview:but];
            
            [but setTitle:@"施工后" forState:UIControlStateNormal];
            
            if(i == sum - 1) {
                
                but1 = but;
            }
        }
        
        
        lineY = CGRectGetMaxY(but1.frame) + jianjv1;
    }
    
    
   
    
//    NSLog(@"=======%f======%f", afMaxY, beMaxY);
    
    
    // 边线
    UIView *lineView13 = [[UIView alloc] initWithFrame:CGRectMake(0, lineY, kWidth, 1)];
    lineView13.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [baseView addSubview:lineView13];
    
    
    baseView.frame = CGRectMake(0, 0, kWidth, CGRectGetMaxY(lineView13.frame));
    
    
    
    
    
    // 技师信息
    GFTitleView *jishiView = [[GFTitleView alloc] initWithY:CGRectGetMaxY(baseView.frame) + jiange1 Title:@"技师信息"];
    [baseView addSubview:jishiView];
    
    
    UIButton *collectButton = [[UIButton alloc]init];
    [collectButton setTitle:@"收藏" forState:UIControlStateNormal];
    
    collectButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_scrollView addSubview:collectButton];
    
    collectButton.frame = CGRectMake(self.view.frame.size.width - 65, CGRectGetMinY(jishiView.frame) + 10, 50, 25);
    [collectButton addTarget:self action:@selector(collectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [collectButton setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
    collectButton.layer.borderWidth = 1;
    collectButton.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
    collectButton.layer.cornerRadius = 3;
    
    
    // 技师头像栏
    UIView *iconView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(jishiView.frame), kWidth, kHeight * 0.15625)];
    iconView.backgroundColor = [UIColor whiteColor];
    [baseView addSubview:iconView];
    // 边线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight * 0.15625, kWidth, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [iconView addSubview:lineView];
    
//    _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(lineView.frame));
    
    // 头像
    CGFloat iconImgViewW = 0.181 * kWidth;
    CGFloat iconImgViewH = iconImgViewW;
    CGFloat iconImgViewX = kWidth * 0.088;
    CGFloat iconImgViewY = (kHeight * 0.15625 - iconImgViewH) / 2.0;
    UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(iconImgViewX, iconImgViewY, iconImgViewW, iconImgViewH)];
    iconImgView.layer.cornerRadius = iconImgViewW / 2.0;
    iconImgView.clipsToBounds = YES;
    [iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseHttp ,_model.techAvatar]] placeholderImage:[UIImage imageNamed:@"userHeadImage"]];
//    iconImgView.image = [UIImage imageNamed:@"userHeadImage"];
    [iconView addSubview:iconImgView];
    // 姓名
    NSString *nameStr = @"无技师接单";
    if([_model.techName isEqualToString:@"无"]) {
        nameStr = @"无技师接单";
    }else {
        
        nameStr = _model.techName;
    }
    
    NSMutableDictionary *nameDic = [[NSMutableDictionary alloc] init];
    nameDic[NSFontAttributeName] = [UIFont systemFontOfSize:16 / 320.0 * kWidth];
    nameDic[NSForegroundColorAttributeName] = [UIColor blackColor];
//    CGRect nameRect = [nameStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:nameDic context:nil];
    CGFloat nameLabW =100;
    CGFloat nameLabH = 20;
    CGFloat nameLabX = CGRectGetMaxX(iconImgView.frame) + kWidth * 0.0463;
    CGFloat nameLabY = kHeight * 0.04;
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, nameLabY, nameLabW, nameLabH)];
    nameLab.text = nameStr;
    nameLab.font = [UIFont systemFontOfSize:16 / 320.0 * kWidth];
//    nameLab.backgroundColor = [UIColor blueColor];
    [iconView addSubview:nameLab];
    // 电话号码
    CGFloat phoneLabW = 200;
    CGFloat phoneLabH = nameLabH;
    CGFloat phoneLabX = CGRectGetMaxX(nameLab.frame);
    CGFloat phoneLabY = nameLabY;
    UIButton *phoneBtn = [[UIButton alloc] init];
    [phoneBtn addTarget:self action:@selector(cellTech) forControlEvents:UIControlEventTouchUpInside];
    phoneBtn.titleLabel.font = [UIFont systemFontOfSize:16 / 320.0 * kWidth];
    [phoneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [phoneBtn setTitle:_model.techPhone forState:UIControlStateNormal];
    phoneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_scrollView addSubview:phoneBtn];

    
    // 订单数
    NSString *indentStr = @"无技师信息";
    NSMutableDictionary *indentDic = [[NSMutableDictionary alloc] init];
    indentDic[NSFontAttributeName] = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    indentDic[NSForegroundColorAttributeName] = [UIColor blackColor];
    CGRect indentRect = [indentStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:indentDic context:nil];
    CGFloat indentLabW = indentRect.size.width;
    CGFloat indentLabH = indentRect.size.height;
    CGFloat indentLabX = nameLabX;
    CGFloat indentLabY = CGRectGetMaxY(nameLab.frame) + kHeight * 0.0183;
    UILabel *indentLab = [[UILabel alloc] initWithFrame:CGRectMake(indentLabX, indentLabY, indentLabW, indentLabH)];
    indentLab.text = indentStr;
    indentLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
//    indentLab.backgroundColor = [UIColor blueColor];
    [iconView addSubview:indentLab];
    
    // 订单数目
    CGFloat numLabW = 30;
    CGFloat numLabH = indentLabH;
    CGFloat numLabX = CGRectGetMaxX(indentLab.frame) + 5 / 320.0 * kWidth;
    CGFloat numLabY = indentLabY;
    UILabel *numLab = [[UILabel alloc] initWithFrame:CGRectMake(numLabX, numLabY, numLabW, numLabH)];
//    numLab.text = @"200";
    numLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    numLab.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [iconView addSubview:numLab];
    
//    // 菊花圈
//    //创建一个活动指示器的对象，并初始化它的样式
//    UIActivityIndicatorView *fengHuoLun = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    fengHuoLun.frame = CGRectMake(0, CGRectGetMaxY(jishiView.frame), 0, 0);
//    fengHuoLun.center = CGPointMake(kWidth / 2.0, CGRectGetMaxY(jishiView.frame));
//    // 开始风火轮
//    [fengHuoLun startAnimating];
//    // 设置风火轮停止之后是否隐藏
//    fengHuoLun.hidesWhenStopped = YES;
//    [_scrollView addSubview:fengHuoLun];
    //5秒之后调用stopAnimating方法
//    [fengHuoLun performSelector:@selector(stopAnimating) withObject:fengHuoLun afterDelay:25];

    
//    [GFHttpTool GetTechnicianParameters:@{@"orderId":_model.orderID} success:^(id responseObject) {
//        NSLog(@"请求成功－－－%@---",responseObject);
        if (![_model.techPhone isEqualToString:@"无"]) {
    

            // 菊花圈停止转动并消失
//            [fengHuoLun stopAnimating];
            

            
//            NSDictionary *dataDictionary = responseObject[@"data"];
//            if([dataDictionary isKindOfClass:[NSNull class]]) {
//                
//                _scrollView.contentSize = CGSizeMake(0, afMaxY);
//            }
//            NSDictionary *technicianDictionary = dataDictionary[@"technician"];
            [iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseHttp ,_model.techAvatar]] placeholderImage:[UIImage imageNamed:@"userHeadImage"]];
            
            
            NSString *nameStr2 = [[NSString alloc] init];
            nameStr2 = [NSString stringWithFormat:@"%@   ", _model.techName];
            NSMutableDictionary *nameDic2 = [[NSMutableDictionary alloc] init];
            nameDic2[NSFontAttributeName] = [UIFont systemFontOfSize:16 / 320.0 * kWidth];
            nameDic2[NSForegroundColorAttributeName] = [UIColor blackColor];
            CGRect nameRect = [nameStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:nameDic2 context:nil];
            nameLab.text = nameStr2;
            nameLab.frame = CGRectMake(nameLabX, nameLabY, nameRect.size.width, nameLabH);
            
            NSString *indentStr2 = @"订单数:";
            NSMutableDictionary *indentDic2 = [[NSMutableDictionary alloc] init];
            indentDic2[NSFontAttributeName] = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
            indentDic2[NSForegroundColorAttributeName] = [UIColor blackColor];
            CGRect indentRect2 = [indentStr2 boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:indentDic2 context:nil];
            CGFloat indentLab2W = indentRect2.size.width;
            CGFloat indentLab2H = indentRect2.size.height;
            CGFloat indentLab2X = nameLabX;
            CGFloat indentLab2Y = CGRectGetMaxY(nameLab.frame) + kHeight * 0.0183;
            indentLab.frame = CGRectMake(indentLab2X, indentLab2Y, indentLab2W, indentLab2H);
            indentLab.text = indentStr2;
            
            // 电话号码
            phoneBtn.frame = CGRectMake(CGRectGetMaxX(nameLab.frame)  + 10, phoneLabY+CGRectGetMaxY(jishiView.frame), phoneLabW, phoneLabH);
            [phoneBtn setTitle:_model.techPhone forState:UIControlStateNormal];
            _phoneString = _model.techPhone;
//            phoneBtn.backgroundColor = [UIColor cyanColor];
            
            
            
            // 订单数目
            NSString *numStr = [[NSString alloc] init];
            numStr = [NSString stringWithFormat:@"%@", _model.orderCount];
            NSMutableDictionary *numDic = [[NSMutableDictionary alloc] init];
            numDic[NSFontAttributeName] = [UIFont systemFontOfSize:16 / 320.0 * kWidth];
            numDic[NSForegroundColorAttributeName] = [UIColor blackColor];
            CGRect numRect = [numStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:numDic context:nil];
            CGFloat numLabW = numRect.size.width + 5;
            CGFloat numLabH = indentLabH;
            CGFloat numLabX = CGRectGetMaxX(indentLab.frame) + 5 / 320.0 * kWidth;
            CGFloat numLabY = indentLabY;
            numLab.frame = CGRectMake(numLabX, numLabY, numLabW, numLabH);
            numLab.text = numStr;
//            numLab.text = @"999";
//            numLab.backgroundColor = [UIColor redColor];
            
            
            // 橘色星星
            for(int i=0; i<[_model.evaluate integerValue]; i++) {
                
                CGFloat starImgViewW = nameLabH - 2;
                CGFloat starImgViewH = nameLabH - 2;
                CGFloat starImgViewX = CGRectGetMaxX(numLab.frame) + kHeight * 0.014 + starImgViewW * i;
                CGFloat starImgViewY = numLabY;
                UIImageView *starImgView = [[UIImageView alloc] initWithFrame:CGRectMake(starImgViewX, starImgViewY, starImgViewW, starImgViewH)];
                starImgView.contentMode = UIViewContentModeScaleAspectFit;
                //        starImgView.backgroundColor = [UIColor redColor];
                starImgView.image = [UIImage imageNamed:@"information"];
                [iconView addSubview:starImgView];
            }
            
            
            
            // 灰色星星
            for(int i=0; i < 5 - [_model.evaluate integerValue]; i++) {
                
                CGFloat starImgViewW = nameLabH - 2;
                CGFloat starImgViewH = nameLabH - 2;
                CGFloat starImgViewX = CGRectGetMaxX(numLab.frame) + kHeight * 0.014 + starImgViewW * (i + [_model.evaluate integerValue]);
                CGFloat starImgViewY = numLabY;
                UIImageView *starImgView = [[UIImageView alloc] initWithFrame:CGRectMake(starImgViewX, starImgViewY, starImgViewW, starImgViewH)];
                starImgView.contentMode = UIViewContentModeScaleAspectFit;
                //        starImgView.backgroundColor = [UIColor greenColor];
                starImgView.image = [UIImage imageNamed:@"detailsStarDark"];
                [iconView addSubview:starImgView];
            }
            
            
            _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(iconView.frame) + 64);

            
        }else {

//            [fengHuoLun stopAnimating];
            _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(iconView.frame) + 64);
        }
        
        
//        
//    } failure:^(NSError *error) {
////        NSLog(@"请求失败－－－%@---",error);
////        [self addAlertView:@"请求失败"];
//    }];
    
    
    
//    NSLog(@"----_model.dic----%@---",_model.commentDictionary);
//    if (![_model.secondTechDictionary isKindOfClass:[NSNull class]]) {
//        [self secondConstruct:CGRectGetMaxY(iconView.frame)+1];
//    }
    
    
//    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 700);
    
}

- (void)collectBtnClick{
    [GFHttpTool favoriteTechnicianPostWithParameters:@{@"techId":_model.techId} success:^(id responseObject) {
        ICLog(@"收藏成功--%@--",responseObject);
        if ([responseObject[@"result"] integerValue] == 1) {
            [self addAlertView:@"收藏技师成功"];
        }else{
            [self addAlertView:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        ICLog(@"收藏失败--%@--",error);
        
    }];
}

- (void)butClick:(UIButton *)sender {
    
    if([sender.titleLabel.text isEqualToString:@"订单"]) {
        
        self.curPhotoArr = self.photoMarr[0];
    }else if([sender.titleLabel.text isEqualToString:@"施工前"]) {
        
        self.curPhotoArr = self.photoMarr[1];
    }else {
        
        self.curPhotoArr = self.photoMarr[2];
    }
    
    
    HZPhotoBrowser *browser = [[HZPhotoBrowser alloc] init];
    
    browser.sourceImagesContainerView = sender.superview;
    
    browser.imageCount = self.curPhotoArr.count;
    
    browser.currentImageIndex = sender.tag - 1;
    
    browser.delegate = self;
    
    [browser show]; // 展示图片浏览器
}

- (void)pingjiaButClick:(UIButton *)sender {
    
//    NSLog(@"========%@", sender.titleLabel.text);
    
    if([sender.titleLabel.text isEqualToString:@"去评价"]) {
        
        GFEvaluateViewController *evaluateView = [[GFEvaluateViewController alloc]init];
        //    _indentViewButton = button;
        evaluateView.orderId = self.model.orderID;
        evaluateView.isPush = YES;
        [self.navigationController pushViewController:evaluateView animated:YES];
    }
}


- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    
    UIImage *img = [UIImage imageNamed:@"orderImage"];
    
    return img;
}
- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseHttp, self.curPhotoArr[index]]];
    
    return url;
}


// 添加前照片
- (void)addBeforImgView:(NSString *)imgUrl withPhotoIndex:(NSInteger)index withFirstY:(CGFloat)Y showInView:(UIView *)showView{
    
    NSInteger hang = (index - 1) / 3;
    NSInteger lie = index % 3;
    
    if(lie == 0) {
        lie = 3;
    }
    
    CGFloat beforImgViewW = (kWidth - jianjv1 * 4) / 3.0;
    CGFloat beforImgViewH = beforImgViewW;
    CGFloat beforImgViewX = jianjv1 * lie + beforImgViewW * (lie - 1);
    CGFloat beforImgViewY = Y + beforImgViewH * hang + jianjv1 * hang;
    MYImageView *beforImgView = [[MYImageView alloc] init];
    beforImgView.frame = CGRectMake(beforImgViewX, beforImgViewY, beforImgViewW, beforImgViewH);
    
    //    beforImgView.backgroundColor = [UIColor redColor];
    [showView addSubview:beforImgView];
    
    beforImgView.tag = _beforeImageArray.count;
    beforImgView.imageArray = _beforeImageArray;
    [_beforeImageArray addObject:beforImgView];
    
    
    NSURL *imgURL = [NSURL URLWithString:imgUrl];
    [beforImgView sd_setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:@"orderImage.png"]];
    
    beMaxY = CGRectGetMaxY(beforImgView.frame);
    
    beforImgView.contentMode = UIViewContentModeScaleAspectFill;
    beforImgView.clipsToBounds = YES;
}
// 添加后照片
- (void)addAfterImgView:(NSString *)imgUrl withPhotoIndex:(NSInteger)index withFirstY:(CGFloat)Y showInView:(UIView *)showView{
    
    NSInteger hang = (index - 1) / 3;
    NSInteger lie = index % 3;
    
    if(lie == 0) {
        lie = 3;
    }
    
    CGFloat beforImgViewW = (kWidth - jianjv1 * 4) / 3.0;
    CGFloat beforImgViewH = beforImgViewW;
    CGFloat beforImgViewX = jianjv1 * lie + beforImgViewW * (lie - 1);
    CGFloat beforImgViewY = Y + beforImgViewH * hang + jianjv1 * hang;
    MYImageView *beforImgView = [[MYImageView alloc] init];
    beforImgView.frame = CGRectMake(beforImgViewX, beforImgViewY, beforImgViewW, beforImgViewH);
    beforImgView.tag = _afterImageArray.count;
    beforImgView.imageArray = _afterImageArray;
    [_afterImageArray addObject:beforImgView];
    
    //    beforImgView.backgroundColor = [UIColor redColor];
    [showView addSubview:beforImgView];
    
    NSURL *imgURL = [NSURL URLWithString:imgUrl];
    [beforImgView sd_setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:@"orderImage.png"]];
    
    afMaxY = CGRectGetMaxY(beforImgView.frame);
    
    beforImgView.contentMode = UIViewContentModeScaleAspectFill;
    beforImgView.clipsToBounds = YES;
}

#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
}

- (void)secondConstruct:(float)MaxY{
    
    // 技师头像栏
    UIView *iconView = [[UIView alloc] initWithFrame:CGRectMake(0, MaxY, kWidth, kHeight * 0.15625)];
    iconView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:iconView];
    // 边线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight * 0.15625, kWidth, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [iconView addSubview:lineView];
    // 头像
    CGFloat iconImgViewW = 0.181 * kWidth;
    CGFloat iconImgViewH = iconImgViewW;
    CGFloat iconImgViewX = kWidth * 0.088;
    CGFloat iconImgViewY = (kHeight * 0.15625 - iconImgViewH) / 2.0;
    UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(iconImgViewX, iconImgViewY, iconImgViewW, iconImgViewH)];
    iconImgView.layer.cornerRadius = iconImgViewW / 2.0;
    iconImgView.clipsToBounds = YES;
    //    iconImgView.backgroundColor =[UIColor redColor];
    [iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseHttp,_model.techAvatar]] placeholderImage:[UIImage imageNamed:@"userHeadImage"]];
    [iconView addSubview:iconImgView];
    // 姓名
    NSString *nameStr = @"陈光法";
    NSMutableDictionary *nameDic = [[NSMutableDictionary alloc] init];
    nameDic[NSFontAttributeName] = [UIFont systemFontOfSize:16 / 320.0 * kWidth];
    nameDic[NSForegroundColorAttributeName] = [UIColor blackColor];
    CGRect nameRect = [nameStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:nameDic context:nil];
    CGFloat nameLabW = nameRect.size.width;
    CGFloat nameLabH = nameRect.size.height;
    CGFloat nameLabX = CGRectGetMaxX(iconImgView.frame) + kWidth * 0.0463;
    CGFloat nameLabY = kHeight * 0.04;
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, nameLabY, nameLabW, nameLabH)];
    nameLab.text = nameStr;
    nameLab.font = [UIFont systemFontOfSize:16 / 320.0 * kWidth];
    //    nameLab.backgroundColor = [UIColor blueColor];
    [iconView addSubview:nameLab];
    // 订单数
    NSString *indentStr = @"订单数";
    NSMutableDictionary *indentDic = [[NSMutableDictionary alloc] init];
    indentDic[NSFontAttributeName] = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    indentDic[NSForegroundColorAttributeName] = [UIColor blackColor];
    CGRect indentRect = [indentStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:indentDic context:nil];
    CGFloat indentLabW = indentRect.size.width;
    CGFloat indentLabH = indentRect.size.height;
    CGFloat indentLabX = nameLabX;
    CGFloat indentLabY = CGRectGetMaxY(nameLab.frame) + kHeight * 0.0183;
    UILabel *indentLab = [[UILabel alloc] initWithFrame:CGRectMake(indentLabX, indentLabY, indentLabW, indentLabH)];
    indentLab.text = indentStr;
    indentLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    //    indentLab.backgroundColor = [UIColor blueColor];
    [iconView addSubview:indentLab];
    // 灰色星星
    for(int i=0; i<5; i++) {
        
        CGFloat starImgViewW = nameLabH;
        CGFloat starImgViewH = nameLabH;
        CGFloat starImgViewX = CGRectGetMaxX(nameLab.frame) + kHeight * 0.014 + starImgViewW * i;
        CGFloat starImgViewY = nameLabY;
        UIImageView *starImgView = [[UIImageView alloc] initWithFrame:CGRectMake(starImgViewX, starImgViewY, starImgViewW, starImgViewH)];
        starImgView.contentMode = UIViewContentModeScaleAspectFit;
        //        starImgView.backgroundColor = [UIColor greenColor];
        starImgView.image = [UIImage imageNamed:@"detailsStarDark"];
        [iconView addSubview:starImgView];
    }
    // 橘色星星
    for(int i=0; i<3; i++) {
        
        CGFloat starImgViewW = nameLabH;
        CGFloat starImgViewH = nameLabH;
        CGFloat starImgViewX = CGRectGetMaxX(nameLab.frame) + kHeight * 0.014 + starImgViewW * i;
        CGFloat starImgViewY = nameLabY;
        UIImageView *starImgView = [[UIImageView alloc] initWithFrame:CGRectMake(starImgViewX, starImgViewY, starImgViewW, starImgViewH)];
        starImgView.contentMode = UIViewContentModeScaleAspectFit;
        //        starImgView.backgroundColor = [UIColor redColor];
        starImgView.image = [UIImage imageNamed:@"information"];
        [iconView addSubview:starImgView];
    }
    // 订单数目
    CGFloat numLabW = 100;
    CGFloat numLabH = indentLabH;
    CGFloat numLabX = CGRectGetMaxX(indentLab.frame) + 5 / 320.0 * kWidth;
    CGFloat numLabY = indentLabY;
    UILabel *numLab = [[UILabel alloc] initWithFrame:CGRectMake(numLabX, numLabY, numLabW, numLabH)];
    numLab.text = @"200";
    numLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    numLab.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [iconView addSubview:numLab];
    
}


#pragma mark - 去评价按钮的响应方法
- (void)judgeBtnClick{
    GFEvaluateViewController *evaluateView = [[GFEvaluateViewController alloc]init];
    
    evaluateView.orderId = _model.orderID;
    evaluateView.isPush = YES;
    [self.navigationController pushViewController:evaluateView animated:YES];
    
    
}


- (void)leftButClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cellTech{
    
//    NSLog(@"方法调用了");
    
    [ACETelPrompt callPhoneNumber:_phoneString call:^(NSTimeInterval duration) {
        //         NSLog(@"User made a call of %.1f seconds", duration);
    } cancel:^{
        //          NSLog(@"User cancelled the call");
    }];
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
