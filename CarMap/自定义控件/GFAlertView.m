//
//  GFAlertView.m
//  CarMap
//
//  Created by 陈光法 on 16/2/17.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFAlertView.h"
#import "UIImageView+WebCache.h"


@implementation GFAlertView


#pragma mark - 进度条
+ (instancetype)initWithJinduTiaoTipName:(NSString *)tipName {
    
    NSMutableArray *mArr = [[NSMutableArray alloc] init];
    
    CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
    
    
    GFAlertView *alertView = [[GFAlertView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    alertView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.25];
    
    
    CGFloat baseViewW = 150 / 320.0 * kWidth;
    CGFloat baseViewH = 90 / 568.0 * kHeight;
    CGFloat baseViewX = (kWidth - baseViewW) / 2.0;
    CGFloat baseViewY = (kHeight - baseViewH) / 2.0 - 50;
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
    baseView.backgroundColor = [UIColor whiteColor];
    baseView.layer.cornerRadius = 5;
    [alertView addSubview:baseView];
    
    
    
    CGFloat imgViewW = 40 / 320.0 * kWidth;
    CGFloat imgViewH = 40 / 320.0 * kWidth;
    CGFloat imgViewX = (baseViewW - 50) / 2.0;
    CGFloat imgViewY = 10;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH)];
    for(int i=1; i<9; i++) {
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", i]];
        [mArr addObject:image];
        
    }
    
    imgView.animationImages = mArr;
    
    imgView.animationDuration = 1.2;
    [imgView startAnimating];
    
    [baseView addSubview:imgView];
    
    
    CGFloat labW = baseViewW;
    CGFloat labH = 35 / 320.0 * kWidth;
    CGFloat labX = 0;
    CGFloat labY = CGRectGetMaxY(imgView.frame);
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(labX, labY, labW, labH)];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor blackColor];
    lab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
    lab.text = tipName;
    [baseView addSubview:lab];
    
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:alertView];
    
    
    return alertView;
    
}


- (instancetype)initWithTipName:(NSString *)tipName withTipMessage:(NSString *)tipMessageStr withButtonNameArray:(NSArray *)buttonArray {

    self = [super init];
    
    if(self != nil) {
        
        CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        
        // 基础View
        CGFloat baseViewW = kWidth - 2 * kWidth * 0.1;
        CGFloat baseViewH = 300;
        CGFloat baseViewX = kWidth * 0.1;
        CGFloat baseViewY = 130 / 568.0 * kHeight;
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
        baseView.backgroundColor = [UIColor whiteColor];
        [self addSubview:baseView];
        baseView.layer.cornerRadius = 7.5;
        baseView.clipsToBounds = YES;
        
        // 提示标题
        CGFloat tipLabW = baseViewW;
        CGFloat tipLabH = 40 / 568.0 * kHeight;
        CGFloat tipLabX = 0;
        CGFloat tipLabY = 0;
        UILabel *tipLab = [[UILabel alloc] initWithFrame:CGRectMake(tipLabX, tipLabY, tipLabW, tipLabH)];
        tipLab.backgroundColor = [UIColor whiteColor];
        tipLab.text = tipName;
        tipLab.textAlignment = NSTextAlignmentCenter;
        tipLab.font = [UIFont systemFontOfSize:17 / 320.0 * kWidth];
        [baseView addSubview:tipLab];
        tipLab.layer.cornerRadius = 7.5;
//        tipLab.clipsToBounds = YES;
        
        
        // 分界线
        CGFloat lineViewW = baseViewW;
        CGFloat lineViewH = 1;
        CGFloat lineViewX = 0;
        CGFloat lineViewY = CGRectGetMaxY(tipLab.frame);
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(lineViewX, lineViewY, lineViewW, lineViewH)];
        lineView.backgroundColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
        [baseView addSubview:lineView];
        
        
        // 提示文本
        NSString *fenStr = tipMessageStr;
        NSMutableDictionary *fenDic = [[NSMutableDictionary alloc] init];
        fenDic[NSFontAttributeName] = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        fenDic[NSForegroundColorAttributeName] = [UIColor blackColor];
        CGRect fenRect = [fenStr boundingRectWithSize:CGSizeMake(baseViewW - 50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fenDic context:nil];
        CGFloat msgLabW = baseViewW - 40;
        CGFloat msgLabH = fenRect.size.height + 6;
        CGFloat msgLabX = 20;
        CGFloat msgLabY = CGRectGetMaxY(tipLab.frame) + 20;
        UILabel *msgLab = [[UILabel alloc] initWithFrame:CGRectMake(msgLabX, msgLabY, msgLabW, msgLabH)];
        msgLab.numberOfLines = 0;
        msgLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        msgLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
        msgLab.textAlignment = NSTextAlignmentCenter;
        // 设置行距
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:tipMessageStr];
        NSMutableParagraphStyle *paStyle = [[NSMutableParagraphStyle alloc] init];
        paStyle.lineSpacing = 2;
        [attStr addAttribute:NSParagraphStyleAttributeName value:paStyle range:NSMakeRange(0, [tipMessageStr length])];
        msgLab.attributedText = attStr;
//        [msgLab sizeToFit]; // 这个是自适应
        [baseView addSubview:msgLab];
        
        // 下方按钮
        CGFloat okButW = baseViewW;
        CGFloat okButH = tipLabH;
        CGFloat okButX = 0;
        CGFloat okButY= CGRectGetMaxY(msgLab.frame) + 20;
        _okBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _okBut.frame = CGRectMake(okButX, okButY, okButW, okButH);
        [baseView addSubview:_okBut];
        CGFloat okLabW = 60;
        CGFloat okLabH = 30;
        CGFloat okLabX = (baseViewW - okLabW) / 2.0;
        CGFloat okLabY = (okButH - okLabH) / 2.0;
        UILabel *okLab = [[UILabel alloc] initWithFrame:CGRectMake(okLabX, okLabY, okLabW, okLabH)];
        okLab.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        okLab.textColor = [UIColor whiteColor];
        okLab.text = buttonArray[0];
        okLab.textAlignment = NSTextAlignmentCenter;
        okLab.layer.cornerRadius = 7.5;
        okLab.clipsToBounds = YES;
        [_okBut addSubview:okLab];

    
        [_okBut addTarget:self action:@selector(okButClick) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat baseViewH2 = CGRectGetMaxY(_okBut.frame);
        baseView.frame = CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH2);
        
    }

    return self;
}

#pragma mark - 商户平台通知
- (instancetype)initWithTitleString:(NSString *)title withTipMessage:(NSString *)tipMessageStr withButtonNameArray:(NSArray *)buttonArray{
    self = [super init];
    
    if(self != nil) {
        
        CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        
        // 基础View
        CGFloat baseViewW = kWidth - 2 * kWidth * 0.1;
        CGFloat baseViewH = 300;
        CGFloat baseViewX = kWidth * 0.1;
        CGFloat baseViewY = 130 / 568.0 * kHeight;
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
        baseView.backgroundColor = [UIColor whiteColor];
        [self addSubview:baseView];
        baseView.layer.cornerRadius = 7.5;
        baseView.clipsToBounds = YES;
        
        // 提示标题
        CGFloat tipLabW = baseViewW;
        CGFloat tipLabH = 40 / 568.0 * kHeight;
        CGFloat tipLabX = 0;
        CGFloat tipLabY = 10;
        CGRect tipRect = [title boundingRectWithSize:CGSizeMake(baseViewW-50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15 / 320.0 * kWidth]} context:nil];
        
        UILabel *tipLab = [[UILabel alloc] initWithFrame:CGRectMake(tipLabX+25, tipLabY, tipLabW-50, tipRect.size.height)];
        tipLab.backgroundColor = [UIColor whiteColor];
        tipLab.numberOfLines = 0;
        tipLab.text = title;
        tipLab.textAlignment = NSTextAlignmentCenter;
        tipLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        [baseView addSubview:tipLab];
        tipLab.layer.cornerRadius = 7.5;
        //        tipLab.clipsToBounds = YES;
        
        
        
        
        // 分界线
        CGFloat lineViewW = baseViewW;
        CGFloat lineViewH = 1;
        CGFloat lineViewX = 0;
        CGFloat lineViewY = CGRectGetMaxY(tipLab.frame)+10;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(lineViewX, lineViewY, lineViewW, lineViewH)];
        lineView.backgroundColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
        [baseView addSubview:lineView];
        
        
        // 提示文本
        NSString *fenStr = tipMessageStr;
        NSMutableDictionary *fenDic = [[NSMutableDictionary alloc] init];
        fenDic[NSFontAttributeName] = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
        fenDic[NSForegroundColorAttributeName] = [UIColor blackColor];
        CGRect fenRect = [fenStr boundingRectWithSize:CGSizeMake(baseViewW - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fenDic context:nil];
        CGFloat msgLabW = baseViewW - 40;
        CGFloat msgLabH = fenRect.size.height + 6;
        CGFloat msgLabX = 20;
        CGFloat msgLabY = CGRectGetMaxY(tipLab.frame) + 20;
        UILabel *msgLab = [[UILabel alloc] initWithFrame:CGRectMake(msgLabX, msgLabY, msgLabW, msgLabH)];
        msgLab.numberOfLines = 0;
        msgLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
        msgLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
        //        msgLab.textAlignment = NSTextAlignmentCenter;
        //        // 设置行距
        //        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:tipMessageStr];
        //        NSMutableParagraphStyle *paStyle = [[NSMutableParagraphStyle alloc] init];
        //        paStyle.lineSpacing = 2;
        //        [attStr addAttribute:NSParagraphStyleAttributeName value:paStyle range:NSMakeRange(0, [tipMessageStr length])];
        //        msgLab.attributedText = attStr;
        //        [msgLab sizeToFit]; // 这个是自适应
        msgLab.text = fenStr;
        [baseView addSubview:msgLab];
        
        // 下方按钮
        CGFloat okButW = baseViewW;
        CGFloat okButH = tipLabH;
        CGFloat okButX = 0;
        CGFloat okButY= CGRectGetMaxY(msgLab.frame) + 20;
        _okBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _okBut.frame = CGRectMake(okButX, okButY, okButW, okButH);
        [baseView addSubview:_okBut];
        CGFloat okLabW = 120;
        CGFloat okLabH = 30;
        CGFloat okLabX = (baseViewW - okLabW) / 2.0;
        CGFloat okLabY = (okButH - okLabH) / 2.0;
        UILabel *okLab = [[UILabel alloc] initWithFrame:CGRectMake(okLabX, okLabY, okLabW, okLabH)];
        okLab.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        okLab.textColor = [UIColor whiteColor];
        okLab.text = buttonArray[0];
        okLab.textAlignment = NSTextAlignmentCenter;
        okLab.layer.cornerRadius = 7.5;
        okLab.clipsToBounds = YES;
        [_okBut addSubview:okLab];
        
        
        [_okBut addTarget:self action:@selector(okButClick) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat baseViewH2 = CGRectGetMaxY(_okBut.frame);
        baseView.frame = CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH2);
        baseView.center = [UIApplication sharedApplication].delegate.window.center;
        
        //        UIButton *deleteBtn = [[UIButton alloc]init];
        //        deleteBtn.frame = CGRectMake(baseViewW-50, 10, 30, 30);
        //        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        //        //        deleteBtn.backgroundColor = [UIColor redColor];
        //        [deleteBtn addTarget:self action:@selector(okButClick) forControlEvents:UIControlEventTouchUpInside];
        //        [baseView addSubview:deleteBtn];
        
    }
    
    return self;
}

- (instancetype)initWithHomeTipName:(NSString *)tipName withTipMessage:(NSString *)tipMessageStr withButtonNameArray:(NSArray *)buttonArray {
    
    self = [super init];
    
    if(self != nil) {
        
        CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        
        // 基础View
        CGFloat baseViewW = kWidth - 2 * kWidth * 0.1;
        CGFloat baseViewH = 300;
        CGFloat baseViewX = kWidth * 0.1;
        CGFloat baseViewY = 130 / 568.0 * kHeight;
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
        baseView.backgroundColor = [UIColor whiteColor];
        [self addSubview:baseView];
        baseView.layer.cornerRadius = 7.5;
        baseView.clipsToBounds = YES;
        
        // 提示标题
        CGFloat tipLabW = baseViewW;
        CGFloat tipLabH = 40 / 568.0 * kHeight;
        CGFloat tipLabX = 0;
        CGFloat tipLabY = 0;
        UILabel *tipLab = [[UILabel alloc] initWithFrame:CGRectMake(tipLabX, tipLabY, tipLabW, tipLabH)];
        tipLab.backgroundColor = [UIColor whiteColor];
        tipLab.text = tipName;
        tipLab.textAlignment = NSTextAlignmentCenter;
        tipLab.font = [UIFont systemFontOfSize:17 / 320.0 * kWidth];
        [baseView addSubview:tipLab];
        tipLab.layer.cornerRadius = 7.5;
        //        tipLab.clipsToBounds = YES;
        
       
        
        
        // 分界线
        CGFloat lineViewW = baseViewW;
        CGFloat lineViewH = 1;
        CGFloat lineViewX = 0;
        CGFloat lineViewY = CGRectGetMaxY(tipLab.frame);
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(lineViewX, lineViewY, lineViewW, lineViewH)];
        lineView.backgroundColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
        [baseView addSubview:lineView];
        
        
        // 提示文本
        NSString *fenStr = tipMessageStr;
        NSMutableDictionary *fenDic = [[NSMutableDictionary alloc] init];
        fenDic[NSFontAttributeName] = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        fenDic[NSForegroundColorAttributeName] = [UIColor blackColor];
        CGRect fenRect = [fenStr boundingRectWithSize:CGSizeMake(baseViewW - 50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fenDic context:nil];
        CGFloat msgLabW = baseViewW - 40;
        CGFloat msgLabH = fenRect.size.height + 6;
        CGFloat msgLabX = 20;
        CGFloat msgLabY = CGRectGetMaxY(tipLab.frame) + 20;
        UILabel *msgLab = [[UILabel alloc] initWithFrame:CGRectMake(msgLabX, msgLabY, msgLabW, msgLabH)];
        msgLab.numberOfLines = 0;
        msgLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        msgLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
        msgLab.textAlignment = NSTextAlignmentCenter;
        // 设置行距
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:tipMessageStr];
        NSMutableParagraphStyle *paStyle = [[NSMutableParagraphStyle alloc] init];
        paStyle.lineSpacing = 2;
        [attStr addAttribute:NSParagraphStyleAttributeName value:paStyle range:NSMakeRange(0, [tipMessageStr length])];
        msgLab.attributedText = attStr;
        //        [msgLab sizeToFit]; // 这个是自适应
        [baseView addSubview:msgLab];
        
        // 下方按钮
        CGFloat okButW = baseViewW;
        CGFloat okButH = tipLabH;
        CGFloat okButX = 0;
        CGFloat okButY= CGRectGetMaxY(msgLab.frame) + 20;
        _okBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _okBut.frame = CGRectMake(okButX, okButY, okButW, okButH);
        [baseView addSubview:_okBut];
        CGFloat okLabW = 120;
        CGFloat okLabH = 30;
        CGFloat okLabX = (baseViewW - okLabW) / 2.0;
        CGFloat okLabY = (okButH - okLabH) / 2.0;
        UILabel *okLab = [[UILabel alloc] initWithFrame:CGRectMake(okLabX, okLabY, okLabW, okLabH)];
        okLab.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        okLab.textColor = [UIColor whiteColor];
        okLab.text = buttonArray[0];
        okLab.textAlignment = NSTextAlignmentCenter;
        okLab.layer.cornerRadius = 7.5;
        okLab.clipsToBounds = YES;
        [_okBut addSubview:okLab];
        
        
        [_okBut addTarget:self action:@selector(okButClick) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat baseViewH2 = CGRectGetMaxY(_okBut.frame);
        baseView.frame = CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH2);
        
        
        UIButton *deleteBtn = [[UIButton alloc]init];
        deleteBtn.frame = CGRectMake(baseViewW-50, 10, 30, 30);
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
//        deleteBtn.backgroundColor = [UIColor redColor];
        [deleteBtn addTarget:self action:@selector(okButClick) forControlEvents:UIControlEventTouchUpInside];
        [baseView addSubview:deleteBtn];
        
    }
    
    return self;
}


- (instancetype)initWithTipName:(NSString *)tipName withTipMessage:(NSString *)tipMessageStr withButtonNameArray:(NSArray *)buttonArray withRightUpButtonNormalImage:(UIImage *)butNorImg withRightUpButtonHightImage:(UIImage *)butHigImg {

    self = [super init];
    
    if(self != nil) {
        
        CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        
        // 基础View
        CGFloat baseViewW = kWidth - 2 * kWidth * 0.1;
        CGFloat baseViewH = 300;
        CGFloat baseViewX = kWidth * 0.1;
        CGFloat baseViewY = 130 / 568.0 * kHeight;
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
        baseView.backgroundColor = [UIColor whiteColor];
        [self addSubview:baseView];
        baseView.layer.cornerRadius = 7.5;
        baseView.clipsToBounds = YES;
        
        // 提示栏View
        CGFloat topViewW = baseViewW;
        CGFloat topViewH = 55 / 568.0 * kHeight;
        CGFloat topViewX = 0;
        CGFloat topViewY = 0;
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(topViewX, topViewY, topViewW, topViewH)];
        topView.backgroundColor = [UIColor whiteColor];
        [baseView addSubview:topView];
        
        // 提示标题
        CGFloat tipLabW = baseViewW - 20;
        CGFloat tipLabH = 40 / 568.0 * kHeight;
        CGFloat tipLabX = 10;
        CGFloat tipLabY = 15 / 568.0 * kHeight;
        UILabel *tipLab = [[UILabel alloc] initWithFrame:CGRectMake(tipLabX, tipLabY, tipLabW, tipLabH)];
        tipLab.backgroundColor = [UIColor whiteColor];
        tipLab.text = tipName;
        tipLab.textAlignment = NSTextAlignmentLeft;
        tipLab.font = [UIFont systemFontOfSize:17 / 320.0 * kWidth];
        [topView addSubview:tipLab];
        tipLab.layer.cornerRadius = 7.5;
//        tipLab.clipsToBounds = YES;
        
        // 右上方按钮
        CGFloat rightUpButW = topViewW - 7.5 / 568 * kHeight;
        CGFloat rightUpButH = 40 / 568.0 * kHeight;
        CGFloat rightUpButX = 0;
        CGFloat rightUpButY = 0;
        UIButton *rightUpBut = [UIButton buttonWithType:UIButtonTypeCustom];
        rightUpBut.frame = CGRectMake(rightUpButX, rightUpButY, rightUpButW, rightUpButH);
        [rightUpBut setImage:butNorImg forState:UIControlStateNormal];
        [rightUpBut setImage:butHigImg forState:UIControlStateHighlighted];
        rightUpBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [topView addSubview:rightUpBut];
        [rightUpBut addTarget:self action:@selector(okButClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        // 分界线
        CGFloat lineViewW = baseViewW;
        CGFloat lineViewH = 1;
        CGFloat lineViewX = 0;
        CGFloat lineViewY = CGRectGetMaxY(topView.frame);
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(lineViewX, lineViewY, lineViewW, lineViewH)];
        lineView.backgroundColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
        [baseView addSubview:lineView];
        
        
        // 提示文本
        NSString *fenStr = tipMessageStr;
        NSMutableDictionary *fenDic = [[NSMutableDictionary alloc] init];
        fenDic[NSFontAttributeName] = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        fenDic[NSForegroundColorAttributeName] = [UIColor blackColor];
        CGRect fenRect = [fenStr boundingRectWithSize:CGSizeMake(baseViewW - 50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fenDic context:nil];
        CGFloat msgLabW = baseViewW - 40;
        CGFloat msgLabH = fenRect.size.height + 6;
        CGFloat msgLabX = 20;
        CGFloat msgLabY = CGRectGetMaxY(tipLab.frame) + 20;
        UILabel *msgLab = [[UILabel alloc] initWithFrame:CGRectMake(msgLabX, msgLabY, msgLabW, msgLabH)];
        msgLab.numberOfLines = 0;
        msgLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        msgLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
        msgLab.textAlignment = NSTextAlignmentCenter;
        // 设置行距
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:tipMessageStr];
        NSMutableParagraphStyle *paStyle = [[NSMutableParagraphStyle alloc] init];
        paStyle.lineSpacing = 2;
        [attStr addAttribute:NSParagraphStyleAttributeName value:paStyle range:NSMakeRange(0, [tipMessageStr length])];
        msgLab.attributedText = attStr;
        //        [msgLab sizeToFit]; // 这个是自适应
        [baseView addSubview:msgLab];
        
        // 下方按钮
        NSString *nameStr = buttonArray[0];
        NSMutableDictionary *attDic = [[NSMutableDictionary alloc] init];
        attDic[NSFontAttributeName] = [UIFont systemFontOfSize:14.5 / 320.0 * kWidth];
        attDic[NSForegroundColorAttributeName] = [UIColor whiteColor];
        CGRect strRect = [nameStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attDic context:nil];
        CGFloat okButW = baseViewW;
        CGFloat okButH = tipLabH;
        CGFloat okButX = 0;
        CGFloat okButY= CGRectGetMaxY(msgLab.frame) + 20;
        _okBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _okBut.frame = CGRectMake(okButX, okButY, okButW, okButH);
        [baseView addSubview:_okBut];
        CGFloat okLabW = strRect.size.width + 20;
        CGFloat okLabH = 30;
        CGFloat okLabX = (baseViewW - okLabW) / 2.0;
        CGFloat okLabY = (okButH - okLabH) / 2.0;
        UILabel *okLab = [[UILabel alloc] initWithFrame:CGRectMake(okLabX, okLabY, okLabW, okLabH)];
        okLab.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        okLab.textColor = [UIColor whiteColor];
        okLab.text = nameStr;
        okLab.font = [UIFont systemFontOfSize:14.5 / 320.0 * kWidth];
        okLab.textAlignment = NSTextAlignmentCenter;
        okLab.layer.cornerRadius = 7.5;
        okLab.clipsToBounds = YES;
        [_okBut addSubview:okLab];
        _okBut.layer.cornerRadius = 7.5;
        
        [_okBut addTarget:self action:@selector(okButClick) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat baseViewH2 = CGRectGetMaxY(_okBut.frame);
        baseView.frame = CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH2);
        
    }
    
    return self;
}

- (instancetype)initWithCebterTipName:(NSString *)tipName withTipMessage:(NSString *)tipMessageStr withButtonNameArray:(NSArray *)buttonArray withRightUpButtonNormalImage:(UIImage *)butNorImg withRightUpButtonHightImage:(UIImage *)butHigImg {


    self = [super init];
    
    if(self != nil) {
        
        CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        
        // 基础View
        CGFloat baseViewW = kWidth - 2 * kWidth * 0.1;
        CGFloat baseViewH = 300;
        CGFloat baseViewX = kWidth * 0.1;
        CGFloat baseViewY = 130 / 568.0 * kHeight;
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
        baseView.backgroundColor = [UIColor whiteColor];
        [self addSubview:baseView];
        baseView.layer.cornerRadius = 7.5;
        baseView.clipsToBounds = YES;
        
        // 提示栏View
        CGFloat topViewW = baseViewW;
        CGFloat topViewH = 55 / 568.0 * kHeight;
        CGFloat topViewX = 0;
        CGFloat topViewY = 0;
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(topViewX, topViewY, topViewW, topViewH)];
        topView.backgroundColor = [UIColor whiteColor];
        [baseView addSubview:topView];
        
        // 提示标题
        CGFloat tipLabW = baseViewW - 20;
        CGFloat tipLabH = 40 / 568.0 * kHeight;
        CGFloat tipLabX = 10;
        CGFloat tipLabY = 15 / 568.0 * kHeight;
        UILabel *tipLab = [[UILabel alloc] initWithFrame:CGRectMake(tipLabX, tipLabY, tipLabW, tipLabH)];
        tipLab.backgroundColor = [UIColor whiteColor];
        tipLab.text = tipName;
        tipLab.textAlignment = NSTextAlignmentCenter;
        tipLab.font = [UIFont systemFontOfSize:17 / 320.0 * kWidth];
        [topView addSubview:tipLab];
        tipLab.layer.cornerRadius = 7.5;
        //        tipLab.clipsToBounds = YES;
        
        // 右上方按钮
        CGFloat rightUpButW = topViewW - 7.5 / 568 * kHeight;
        CGFloat rightUpButH = 40 / 568.0 * kHeight;
        CGFloat rightUpButX = 0;
        CGFloat rightUpButY = 0;
        UIButton *rightUpBut = [UIButton buttonWithType:UIButtonTypeCustom];
        rightUpBut.frame = CGRectMake(rightUpButX, rightUpButY, rightUpButW, rightUpButH);
        [rightUpBut setImage:butNorImg forState:UIControlStateNormal];
        [rightUpBut setImage:butHigImg forState:UIControlStateHighlighted];
        rightUpBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [topView addSubview:rightUpBut];
        [rightUpBut addTarget:self action:@selector(okButClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        // 分界线
        CGFloat lineViewW = baseViewW;
        CGFloat lineViewH = 1;
        CGFloat lineViewX = 0;
        CGFloat lineViewY = CGRectGetMaxY(topView.frame);
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(lineViewX, lineViewY, lineViewW, lineViewH)];
        lineView.backgroundColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
        [baseView addSubview:lineView];
        
        
        // 提示文本
        NSString *fenStr = tipMessageStr;
        NSMutableDictionary *fenDic = [[NSMutableDictionary alloc] init];
        fenDic[NSFontAttributeName] = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        fenDic[NSForegroundColorAttributeName] = [UIColor blackColor];
        CGRect fenRect = [fenStr boundingRectWithSize:CGSizeMake(baseViewW - 50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fenDic context:nil];
        CGFloat msgLabW = baseViewW - 40;
        CGFloat msgLabH = fenRect.size.height + 6;
        CGFloat msgLabX = 20;
        CGFloat msgLabY = CGRectGetMaxY(tipLab.frame) + 20;
        UILabel *msgLab = [[UILabel alloc] initWithFrame:CGRectMake(msgLabX, msgLabY, msgLabW, msgLabH)];
        msgLab.numberOfLines = 0;
        msgLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        msgLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
        msgLab.textAlignment = NSTextAlignmentCenter;
        // 设置行距
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:tipMessageStr];
        NSMutableParagraphStyle *paStyle = [[NSMutableParagraphStyle alloc] init];
        paStyle.lineSpacing = 2;
        [attStr addAttribute:NSParagraphStyleAttributeName value:paStyle range:NSMakeRange(0, [tipMessageStr length])];
        msgLab.attributedText = attStr;
        //        [msgLab sizeToFit]; // 这个是自适应
        [baseView addSubview:msgLab];
        
        // 下方按钮
        NSString *nameStr = buttonArray[0];
        NSMutableDictionary *attDic = [[NSMutableDictionary alloc] init];
        attDic[NSFontAttributeName] = [UIFont systemFontOfSize:14.5 / 320.0 * kWidth];
        attDic[NSForegroundColorAttributeName] = [UIColor whiteColor];
        CGRect strRect = [nameStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attDic context:nil];
        CGFloat okButW = baseViewW;
        CGFloat okButH = tipLabH;
        CGFloat okButX = 0;
        CGFloat okButY= CGRectGetMaxY(msgLab.frame) + 20;
        _okBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _okBut.frame = CGRectMake(okButX, okButY, okButW, okButH);
        [baseView addSubview:_okBut];
        CGFloat okLabW = strRect.size.width + 20;
        CGFloat okLabH = 30;
        CGFloat okLabX = (baseViewW - okLabW) / 2.0;
        CGFloat okLabY = (okButH - okLabH) / 2.0;
        UILabel *okLab = [[UILabel alloc] initWithFrame:CGRectMake(okLabX, okLabY, okLabW, okLabH)];
        okLab.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        okLab.textColor = [UIColor whiteColor];
        okLab.text = nameStr;
        okLab.font = [UIFont systemFontOfSize:14.5 / 320.0 * kWidth];
        okLab.textAlignment = NSTextAlignmentCenter;
        okLab.layer.cornerRadius = 7.5;
        okLab.clipsToBounds = YES;
        [_okBut addSubview:okLab];
        _okBut.layer.cornerRadius = 7.5;
        
        [_okBut addTarget:self action:@selector(okButClick) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat baseViewH2 = CGRectGetMaxY(_okBut.frame);
        baseView.frame = CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH2);
        
    }
    
    return self;
}


- (instancetype)initWithMiao:(NSInteger)miao {
    
    self = [super init];
    
    if(self != nil) {
        
        CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        
        // 基础View
        CGFloat baseViewW = kWidth - 2 * kWidth * 0.1;
        CGFloat baseViewH = 300;
        CGFloat baseViewX = kWidth * 0.1;
        CGFloat baseViewY = 130 / 568.0 * kHeight;
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
        baseView.backgroundColor = [UIColor whiteColor];
        [self addSubview:baseView];
        baseView.layer.cornerRadius = 7.5;
        baseView.clipsToBounds = YES;
        
        // 右上方X按钮
        CGFloat butW = kHeight * 0.06;
        CGFloat butH = butW;
        CGFloat butX = baseViewW - 20 - butW;
        CGFloat butY = 20;
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(butX, butY, butW, butH);
//        but.backgroundColor = [UIColor redColor];
        [but setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [baseView addSubview:but];
        [but addTarget:self action:@selector(okButClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        // 下单成功
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(but.frame) + 5, baseViewW, kHeight * 0.04)];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:20 / 320.0 * kWidth];
        lab.text = @" 下单成功!";
        [baseView addSubview:lab];
        
        
        // 倒计时按钮
        CGFloat timeLabW = butW * 2.0;
        CGFloat timeLabH = butH;
        CGFloat timeLabX = (baseViewW - timeLabW) / 2.0;
        CGFloat timeLabY = CGRectGetMaxY(lab.frame) + 20;
        timeLab = [[UILabel alloc] initWithFrame:CGRectMake(timeLabX, timeLabY, timeLabW, timeLabH)];
        timeLab.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        timeLab.text = [NSString stringWithFormat:@"%@",@(miao)];
        timeLab.textAlignment = NSTextAlignmentCenter;
        timeLab.textColor = [UIColor whiteColor];
        timeLab.layer.cornerRadius = 10;
        timeLab.clipsToBounds = YES;
        [baseView addSubview:timeLab];
        
        baseView.frame = CGRectMake(baseViewX, baseViewY, baseViewW, CGRectGetMaxY(timeLab.frame) + 40);
        
        
        // 计时器
//        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeForWork:) userInfo:nil repeats:YES];
        if (timer == nil) {
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeForWork) userInfo:nil repeats:YES];
        }
        
//        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeForWork) userInfo:nil repeats:YES];

    }
    
    return self;
}

- (void)timeForWork{
    NSInteger time = [timeLab.text integerValue];
    if (time == 0) {
        [self removeFromSuperview];
        [timer invalidate];
        timer = nil;
    }else{
        time = time - 1;
        timeLab.text = [NSString stringWithFormat:@"%ld",time];
    }
}


- (instancetype)initWithHeadImageURL:(NSString *)imageURL name:(NSString *)name mark:(float )mark orderNumber:(NSInteger )orderNumber{
    self = [super init];
    if (self) {
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        
        
        // 基础View
        CGFloat baseViewW = [UIScreen mainScreen].bounds.size.width - 2 * [UIScreen mainScreen].bounds.size.width * 0.1;
        CGFloat baseViewH = 150;
        CGFloat baseViewX = [UIScreen mainScreen].bounds.size.width * 0.1;
        CGFloat baseViewY = 130 / 568.0 * [UIScreen mainScreen].bounds.size.height;
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
        baseView.backgroundColor = [UIColor whiteColor];
        [self addSubview:baseView];
        baseView.layer.cornerRadius = 7.5;
        baseView.clipsToBounds = YES;
        
        
        
        CGFloat msgRightButH = 40;
        CGFloat kWidth = baseView.frame.size.width;
//        CGFloat kHeight = baseView.frame.size.height;
        CGFloat jianjv1 = kWidth * 0.028;
        CGFloat jianjv2 = kWidth * 0.042;
        
        
        // 左边头像
        CGFloat iconImgViewW = kWidth * 0.2;
        CGFloat iconImgViewH = iconImgViewW;
        CGFloat iconImgViewX = (baseViewW - iconImgViewW)/2;
        
        CGFloat iconImgViewY = (msgRightButH - iconImgViewH) / 2.0+30;
        UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(iconImgViewX, iconImgViewY, iconImgViewW, iconImgViewH)];
        
        iconImgView.layer.cornerRadius = iconImgViewW / 2.0;
        iconImgView.clipsToBounds = YES;
        iconImgView.contentMode = UIViewContentModeScaleAspectFill;
        //        iconImgView.image = [UIImage imageNamed:@"11.png"];
        [iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://121.40.157.200:12345%@",imageURL]] placeholderImage:[UIImage imageNamed:@"userHeadImage"]];
//        NSLog(@"---imageUrl---%@----",[NSString stringWithFormat:@"http://121.40.157.200:12345%@",imageURL]);
        [baseView addSubview:iconImgView];
        // 姓名
        NSString *nameStr = name;
        NSMutableDictionary *attDic = [[NSMutableDictionary alloc] init];
        attDic[NSFontAttributeName] = [UIFont systemFontOfSize:16 / 320.0 * kWidth];
        attDic[NSForegroundColorAttributeName] = [UIColor blackColor];
        CGRect strRect = [nameStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attDic context:nil];
        CGFloat nameLabW = strRect.size.width + jianjv1;
        CGFloat nameLabH = iconImgViewH / 2.0;
        CGFloat nameLabX = jianjv2;
        CGFloat nameLabY = CGRectGetMaxY(iconImgView.frame) + 2;
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX+50, nameLabY+10, nameLabW, nameLabH)];
        nameLab.center = CGPointMake(iconImgView.center.x, nameLab.center.y);
        nameLab.font = [UIFont systemFontOfSize:16.5 / 320.0 * kWidth];
        nameLab.text = nameStr;
        [baseView addSubview:nameLab];
        
        
        // 订单数
        CGFloat indentLabW = kWidth * 0.16;
        CGFloat indentLabH = nameLabH;
        CGFloat indentLabX = nameLabX;
        CGFloat indentLabY = CGRectGetMaxY(nameLab.frame);
        UILabel *indentLab = [[UILabel alloc] initWithFrame:CGRectMake(indentLabX+50, indentLabY-5, indentLabW, indentLabH)];
        indentLab.text = @"订单数";
        indentLab.font = [UIFont systemFontOfSize:14.5 / 320.0 * kWidth];
        [baseView addSubview:indentLab];
        NSString *numStr = [NSString stringWithFormat:@"%ld",orderNumber];
        NSMutableDictionary *numDic = [[NSMutableDictionary alloc] init];
        numDic[NSFontAttributeName] = [UIFont systemFontOfSize:14.5 / 320.0 * kWidth];
        numDic[NSForegroundColorAttributeName] = [UIColor blackColor];
        CGRect numRect = [numStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:numDic context:nil];
        CGFloat numLabW = numRect.size.width;
        CGFloat numLabH = indentLabH;
        CGFloat numLabX = CGRectGetMaxX(indentLab.frame) - 3;
        CGFloat numLabY = indentLabY;
        UILabel *numLab = [[UILabel alloc] initWithFrame:CGRectMake(numLabX, numLabY-5, numLabW, numLabH)];
        numLab.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        numLab.font = [UIFont systemFontOfSize:14.5 / 320.0 * kWidth];
        numLab.text = numStr;
        [baseView addSubview:numLab];
        
        
        for(int i=0; i < round(mark); i++) {
            
            CGFloat starImgViewW = strRect.size.height;
            CGFloat starImgViewH = starImgViewW;
            CGFloat starImgViewX = CGRectGetMaxX(numLab.frame) + 10 + starImgViewW * i;
//            CGFloat starImgViewY = numLabY;
            UIImageView *starImgView = [[UIImageView alloc] initWithFrame:CGRectMake(starImgViewX, numLabY, starImgViewW, starImgViewH)];
            starImgView.contentMode = UIViewContentModeScaleAspectFit;
            starImgView.image = [UIImage imageNamed:@"information.png"];
            [baseView addSubview:starImgView];
        }
        
        // 星星
        for(int i=0; i< 5-round(mark); i++) {
            
            CGFloat starImgViewW = strRect.size.height;
            CGFloat starImgViewH = starImgViewW;
            CGFloat starImgViewX = CGRectGetMaxX(numLab.frame) + 10 + starImgViewW * (i+round(mark));
//            CGFloat starImgViewY = numLabY;
            UIImageView *starImgView = [[UIImageView alloc] initWithFrame:CGRectMake(starImgViewX, numLabY, starImgViewW, starImgViewH)];
            starImgView.contentMode = UIViewContentModeScaleAspectFit;
            starImgView.image = [UIImage imageNamed:@"detailsStarDark.png"];
            [baseView addSubview:starImgView];
        }
        
        
        
        // 评分
        NSString *fenStr = [NSString stringWithFormat:@"%0.1f",mark];
//        NSLog(@"----mark---%@----",fenStr);
        
        NSMutableDictionary *fenDic = [[NSMutableDictionary alloc] init];
        fenDic[NSFontAttributeName] = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        fenDic[NSForegroundColorAttributeName] = [UIColor blackColor];
        CGRect fenRect = [fenStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fenDic context:nil];
        CGFloat fenLabW = fenRect.size.width + 10;
        CGFloat fenLabH = strRect.size.height;
        CGFloat fenLabX = CGRectGetMaxX(numLab.frame) + strRect.size.height * 5 + jianjv1 + 10;
//        CGFloat fenLabY = nameLabY + 3.5 / 568 * kHeight;
        UILabel *fenLab = [[UILabel alloc] initWithFrame:CGRectMake(fenLabX, numLabY, fenLabW, fenLabH)];
        fenLab.textColor = [UIColor whiteColor];
        fenLab.textAlignment = NSTextAlignmentCenter;
        fenLab.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        fenLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        fenLab.text = fenStr;
        fenLab.layer.cornerRadius = 7.5;
        fenLab.clipsToBounds = YES;
        [baseView addSubview:fenLab];
        
        
        
        // 右上方按钮
        
        UIButton *rightUpBut = [UIButton buttonWithType:UIButtonTypeCustom];
        rightUpBut.frame = CGRectMake(baseView.frame.size.width-40, 5, 30, 30);
        [rightUpBut setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [rightUpBut setImage:[UIImage imageNamed:@"deleteClick"] forState:UIControlStateHighlighted];
        rightUpBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [baseView addSubview:rightUpBut];
        [rightUpBut addTarget:self action:@selector(okButClick) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
    return self;
}

- (void)remove{
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
}


- (void)okButClick {

    [timer invalidate];
    timer = nil;
    [self removeFromSuperview];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
