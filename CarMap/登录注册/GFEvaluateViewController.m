//
//  GFEvaluateViewController.m
//  车邻邦客户端
//
//  Created by 陈光法 on 16/3/3.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFEvaluateViewController.h"
#import "GFNavigationView.h"
#import "GFTextField.h"
#import "GFTitleView.h"

@interface GFEvaluateViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    CGFloat jiange1;
    CGFloat jiange2;
    CGFloat jiange3;
    
    CGFloat jianjv3;
    CGFloat jianjv4;
}

@property (nonatomic, strong) GFNavigationView *navView;

@end

@implementation GFEvaluateViewController

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
    
    jiange1 = kWidth * 0.033;
    jiange2 = kWidth * 0.065;
    
    jianjv3 = kHeight * 0.02865;
    jianjv4 = kHeight * 0.02;
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"服务中心" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}

- (void)_setView {
    
    // 技师头像栏
    UIView *iconView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight * 0.15625)];
    iconView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:iconView];
    // 边线
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight * 0.15625, kWidth, 1)];
    lineView1.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [iconView addSubview:lineView1];
    // 头像
    CGFloat iconImgViewW = 0.181 * kWidth;
    CGFloat iconImgViewH = iconImgViewW;
    CGFloat iconImgViewX = kWidth * 0.088;
    CGFloat iconImgViewY = (kHeight * 0.15625 - iconImgViewH) / 2.0;
    UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(iconImgViewX, iconImgViewY, iconImgViewW, iconImgViewH)];
    iconImgView.layer.cornerRadius = iconImgViewW / 2.0;
    iconImgView.clipsToBounds = YES;
    iconImgView.backgroundColor =[UIColor redColor];
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
    nameLab.backgroundColor = [UIColor blueColor];
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
    indentLab.backgroundColor = [UIColor blueColor];
    [iconView addSubview:indentLab];
    // 灰色星星
    for(int i=0; i<5; i++) {
        
        CGFloat starImgViewW = nameLabH;
        CGFloat starImgViewH = nameLabH;
        CGFloat starImgViewX = CGRectGetMaxX(nameLab.frame) + kHeight * 0.014 + starImgViewW * i;
        CGFloat starImgViewY = nameLabY;
        UIImageView *starImgView = [[UIImageView alloc] initWithFrame:CGRectMake(starImgViewX, starImgViewY, starImgViewW, starImgViewH)];
        starImgView.contentMode = UIViewContentModeScaleAspectFit;
        starImgView.backgroundColor = [UIColor greenColor];
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
        starImgView.backgroundColor = [UIColor redColor];
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
    
    
    // 评价技师
    CGFloat baseViewW = kWidth;
    CGFloat baseViewH = 500;
    CGFloat baseViewX = 0;
    CGFloat baseViewY = CGRectGetMaxY(iconView.frame) + kHeight * 0.015625;
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView];
    // “评价技师”
    GFTitleView *pingjiaView = [[GFTitleView alloc] initWithY:0 Title:@"评价技师"];
    [baseView addSubview:pingjiaView];
    
    // 星星
    for(int i=0; i<5; i++) {
        
        CGFloat imgViewW = (kWidth - kWidth * 0.25 * 2) / 5.0;
        CGFloat imgViewH = imgViewW - 4 / 320.0 * kWidth;
        CGFloat imgViewX = kWidth * 0.21 + (imgViewW + 1 / 320.0 * kWidth) * i;
        CGFloat imgViewY = jianjv3 + CGRectGetMaxY(pingjiaView.frame);
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH)];
        [baseView addSubview:imgView];
        imgView.image = [UIImage imageNamed:@"detailsStarDark.png"];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.backgroundColor = [UIColor redColor];
    }
    
    for(int i=0; i<4; i++) {
        
        CGFloat imgViewW = (kWidth - kWidth * 0.25 * 2) / 5.0;
        CGFloat imgViewH = imgViewW - 4 / 320.0 * kWidth;
        CGFloat imgViewX = kWidth * 0.21 + (imgViewW + 1 / 320.0 * kWidth) * i;
        CGFloat imgViewY = jianjv3 + CGRectGetMaxY(pingjiaView.frame);
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH)];
        [baseView addSubview:imgView];
        imgView.image = [UIImage imageNamed:@"information.png"];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.backgroundColor = [UIColor greenColor];
    }
    
    // 准时到达
    UIView *daodaView = [self messageButView:@"准时到达" withSelected:YES withX:jiange2 withY:CGRectGetMaxY(pingjiaView.frame) + jianjv3 * 2 + jianjv4 + (kWidth - kWidth * 0.25 * 2) / 5.0 - 4 / 320.0 * kWidth];
    [baseView addSubview:daodaView];
    
    // 准时完工
    UIView *wangongView = [self messageButView:@"准时完工" withSelected:NO withX:kWidth * 0.676 withY:CGRectGetMaxY(pingjiaView.frame) + jianjv3 * 2 + jianjv4 + (kWidth - kWidth * 0.25 * 2) / 5.0 - 4 / 320.0 * kWidth];
    [baseView addSubview:wangongView];
    
    // 技术专业
    UIView *zhuanyeView = [self messageButView:@"技术专业" withSelected:YES withX:jiange2 withY:CGRectGetMaxY(wangongView.frame) + jianjv4];
    [baseView addSubview:zhuanyeView];
    
    // 着装整洁
    UIView *zhengjieView = [self messageButView:@"着装整洁" withSelected:NO withX:kWidth * 0.676 withY:CGRectGetMaxY(wangongView.frame) + jianjv4];
    [baseView addSubview:zhengjieView];
    
    // 车辆保护超级棒
    UIView *bangView = [self messageButView:@"车辆保护超级棒" withSelected:YES withX:jiange2 withY:CGRectGetMaxY(zhengjieView.frame) + jianjv4];
    [baseView addSubview:bangView];
    
    // 态度好
    UIView *haoView = [self messageButView:@"态度好" withSelected:YES withX:kWidth * 0.676 withY:CGRectGetMaxY(zhengjieView.frame) + jianjv4];
    [baseView addSubview:haoView];
    
    // 边线
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(jiange1, CGRectGetMaxY(haoView.frame) - 1 + jianjv3, kWidth - jiange1 * 2, 1)];
    lineView2.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [baseView addSubview:lineView2];
    
    // 其他意见和建议
    CGFloat otherLabW = kWidth - jiange2 * 2;
    CGFloat otherLabH = kHeight * 0.15625;
    CGFloat otherLabX = jiange2;
    CGFloat otherLabY = CGRectGetMaxY(lineView2.frame) + jianjv4;
    UITextView *otherLab = [[UITextView alloc] initWithFrame:CGRectMake(otherLabX, otherLabY, otherLabW, otherLabH)];
    otherLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    otherLab.backgroundColor = [UIColor redColor];
    [baseView addSubview:otherLab];
    
    baseView.frame = CGRectMake(baseViewX, baseViewY, baseViewW, CGRectGetMaxY(otherLab.frame) + jianjv4);
    
//    baseView.backgroundColor = [UIColor blackColor];
    // 边线
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(baseView.frame) - 1, kWidth, 1)];
    lineView3.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [self.view addSubview:lineView3];
    
    // 提交评价按钮
    // 登录按钮
    CGFloat signInButW = kWidth - (kWidth * 0.116) * 2;
    CGFloat signInButH = kHeight * 0.07;
    CGFloat signInButX = kWidth * 0.116;
    CGFloat signInButY = (kHeight - CGRectGetMaxY(baseView.frame) - signInButH) / 2.0 + CGRectGetMaxY(baseView.frame);
    UIButton *submitBut = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBut.frame = CGRectMake(signInButX, signInButY, signInButW, signInButH);
    submitBut.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    submitBut.layer.cornerRadius = 5;
    [submitBut setTitle:@"提交评价" forState:UIControlStateNormal];
    [self.view addSubview:submitBut];
    
}


- (UIView *)messageButView:(NSString *)messageStr withSelected:(BOOL)select withX:(CGFloat)x withY:(CGFloat)y{
    
    UIButton *imgBut = [UIButton buttonWithType:UIButtonTypeCustom];
    imgBut.frame = CGRectMake(0, 0, kWidth * 0.051, kWidth * 0.051);
    [imgBut setImage:[UIImage imageNamed:@"over.png"] forState:UIControlStateNormal];
    [imgBut setImage:[UIImage imageNamed:@"overClick.png"] forState:UIControlStateSelected];
    imgBut.selected = select;
    
    NSString *fenStr = messageStr;
    NSMutableDictionary *fenDic = [[NSMutableDictionary alloc] init];
    fenDic[NSFontAttributeName] = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    fenDic[NSForegroundColorAttributeName] = [UIColor blackColor];
    CGRect fenRect = [fenStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fenDic context:nil];
    CGFloat labW = fenRect.size.width;
    CGFloat labH = kWidth * 0.051;
    CGFloat labX = jiange1 / 2.0 + kWidth * 0.051;
    CGFloat labY = 0;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(labX, labY, labW, labH)];
    lab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    lab.text = messageStr;
    
    CGFloat baseViewW = labX + labW;
    CGFloat baseViewH = labH;
    CGFloat baseViewX = x;
    CGFloat baseViewY = y;
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
    
    [baseView addSubview:imgBut];
    [baseView addSubview:lab];
    
    return baseView;
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
