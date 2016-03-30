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




@interface GFIndentDetialsViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    CGFloat jiange1;
    CGFloat jiange2;
    CGFloat jiange3;
    CGFloat jiange4;

    CGFloat jianjv1;
    CGFloat jianjv2;
    
    UIScrollView *_scrollView;
}

@property (nonatomic, strong) GFNavigationView *navView;

@property (nonatomic, strong) UILabel *bianhaoLab;
@property (nonatomic, strong) UILabel *tiemoLab;
@property (nonatomic, strong) UILabel *timeLab;



@end

@implementation GFIndentDetialsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    _scrollView.backgroundColor = [UIColor cyanColor];
    _scrollView.showsVerticalScrollIndicator = NO;
    
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
    
    CGFloat baseViewW = kWidth;
    CGFloat baseViewH = 500;
    CGFloat baseViewX = 0;
    CGFloat baseViewY = 64 + jiange1;
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
    baseView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:baseView];
    
    // 订单编号
    CGFloat bianhaoLabW = 0.7 * kWidth;
    CGFloat bianhaoLabH = kHeight * 0.026;
    CGFloat bianhaoLabX = jianjv1;
    CGFloat bianhaoLabY = jiange2;
    self.bianhaoLab = [[UILabel alloc] initWithFrame:CGRectMake(bianhaoLabX, bianhaoLabY, bianhaoLabW, bianhaoLabH)];
    self.bianhaoLab.text = [NSString stringWithFormat:@"订单编号%@",_model.orderNum];
    self.bianhaoLab.font = [UIFont systemFontOfSize:11 / 320.0 * kWidth];
    [baseView addSubview:self.bianhaoLab];
    
    // 汽车贴膜
    CGFloat tiemoLabW = bianhaoLabW;
    CGFloat tiemoLabH = bianhaoLabH;
    CGFloat tiemoLabX = bianhaoLabX;
    CGFloat tiemoLabY = CGRectGetMaxY(self.bianhaoLab.frame) + jiange3;
    self.tiemoLab = [[UILabel alloc] initWithFrame:CGRectMake(tiemoLabX, tiemoLabY, tiemoLabW, tiemoLabH)];
    self.tiemoLab.text = _model.orderType;
    self.tiemoLab.font = [UIFont systemFontOfSize:11 / 320.0 * kWidth];
    self.tiemoLab.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [baseView addSubview:self.tiemoLab];
    
    // 预约时间
    CGFloat timeLabW = bianhaoLabW;
    CGFloat timeLabH = bianhaoLabH;
    CGFloat timeLabX = bianhaoLabX;
    CGFloat timeLabY = CGRectGetMaxY(self.tiemoLab.frame) + jiange3;
    self.timeLab = [[UILabel alloc] initWithFrame:CGRectMake(timeLabX, timeLabY, timeLabW, timeLabH)];
    self.timeLab.text = [NSString stringWithFormat:@"预约时间：%@",_model.workTime];
    self.timeLab.font = [UIFont systemFontOfSize:11 / 320.0 * kWidth];
    self.timeLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
    [baseView addSubview:self.timeLab];
    
    // 去评价按钮
    CGFloat pingjiaButW = kWidth * 0.185;
    CGFloat pingjiaButH = kHeight * 0.042;
    CGFloat pingjiaButX = kWidth - jianjv1 - pingjiaButW;
    CGFloat pingjiaButY = bianhaoLabY + 3 / 568.0 * kHeight;
    UIButton *pingjiaBut = [UIButton buttonWithType:UIButtonTypeCustom];
    pingjiaBut.frame = CGRectMake(pingjiaButX, pingjiaButY, pingjiaButW, pingjiaButH);
    pingjiaBut.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
    pingjiaBut.layer.borderWidth = 1;
    pingjiaBut.layer.cornerRadius = 5;
    if ([_model.commentDictionary isKindOfClass:[NSNull class]]) {
        [pingjiaBut setTitle:@"去评价" forState:UIControlStateNormal];
        [pingjiaBut addTarget:self action:@selector(judgeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [pingjiaBut setTitle:@"已评价" forState:UIControlStateNormal];
    }
    [pingjiaBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
    pingjiaBut.titleLabel.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    [baseView addSubview:pingjiaBut];
    
    // 边线
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(jianjv2, CGRectGetMaxY(self.timeLab.frame) + jiange2, kWidth - jianjv2 * 2.0, 1)];
    lineView1.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [baseView addSubview:lineView1];
    
    // 订单图片
    CGFloat imgViewW = kWidth - jianjv2 * 2;
    CGFloat imgViewH = kHeight * 0.237;
    CGFloat imgViewX = jianjv2;
    CGFloat imgViewY = CGRectGetMaxY(self.timeLab.frame) + jiange1 + jiange2;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH)];
//    imgView.backgroundColor = [UIColor redColor];
    [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_model.photo]] placeholderImage:[UIImage imageNamed:@"orderImage"]];
    
    [baseView addSubview:imgView];
    
    // 边线
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(jianjv2, CGRectGetMaxY(imgView.frame) + jiange1, kWidth - jianjv2 * 2.0, 1)];
    lineView2.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [baseView addSubview:lineView2];
    
    // 备注
    CGFloat lab4W = kWidth * 0.2;
    CGFloat lab4H = kHeight * 0.026;
    CGFloat lab4X = jianjv2;
    CGFloat lab4Y = CGRectGetMaxY(lineView2.frame) + jiange4;
    UILabel *lab4 = [[UILabel alloc] initWithFrame:CGRectMake(lab4X, lab4Y, lab4W, lab4H)];
//    lab4.backgroundColor = [UIColor redColor];
    [baseView addSubview:lab4];
    lab4.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    lab4.text = @"备注: ";
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
    
    
    // 下单时间
    CGFloat lab5W = kWidth * 0.2;
    CGFloat lab5H = kHeight * 0.026;
    CGFloat lab5X = jianjv2;
    CGFloat lab5Y = CGRectGetMaxY(contLab4.frame) + jiange4 * 2;
    UILabel *lab5 = [[UILabel alloc] initWithFrame:CGRectMake(lab5X, lab5Y, lab5W, lab5H)];
//    lab5.backgroundColor = [UIColor redColor];
    [baseView addSubview:lab5];
    lab5.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    lab5.text = @"下单时间: ";
    NSString *lab5Str = _model.signinTime;
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
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(contLab5.frame) + jiange4, kWidth, 1)];
    lineView4.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [baseView addSubview:lineView4];
    
    baseView.frame = CGRectMake(0, 64, kWidth, CGRectGetMaxY(lineView4.frame));
    
    // 技师信息
    GFTitleView *jishiView = [[GFTitleView alloc] initWithY:CGRectGetMaxY(baseView.frame) + jiange1 Title:@"技师信息"];
    [_scrollView addSubview:jishiView];
    
    
    // 技师头像栏
    UIView *iconView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(jishiView.frame), kWidth, kHeight * 0.15625)];
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
    [iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_model.photo]] placeholderImage:[UIImage imageNamed:@"userHeadImage"]];
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
    
    
    NSLog(@"----_model.dic----%@---",_model.commentDictionary);
    if (![_model.secondTechDictionary isKindOfClass:[NSNull class]]) {
        [self secondConstruct:CGRectGetMaxY(iconView.frame)+1];
    }
    
    
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 700);
    
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
    [iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_model.photo]] placeholderImage:[UIImage imageNamed:@"userHeadImage"]];
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
    [self.navigationController pushViewController:evaluateView animated:YES];
    
    
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
