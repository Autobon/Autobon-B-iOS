//
//  GFAlertView.h
//  CarMap
//
//  Created by 陈光法 on 16/2/17.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFAlertView : UIView {

//    NSInteger time;
    NSTimer *timer;
    UILabel *timeLab;
}

@property (nonatomic, strong) UIButton *okBut;

- (instancetype)initWithTipName:(NSString *)tipName withTipMessage:(NSString *)tipMessageStr withButtonNameArray:(NSArray *)buttonArray;

- (instancetype)initWithTipName:(NSString *)tipName withTipMessage:(NSString *)tipMessageStr withButtonNameArray:(NSArray *)buttonArray withRightUpButtonNormalImage:(UIImage *)butNorImg withRightUpButtonHightImage:(UIImage *)butHigImg;

// 主页面警告框
- (instancetype)initWithHomeTipName:(NSString *)tipName withTipMessage:(NSString *)tipMessageStr withButtonNameArray:(NSArray *)buttonArray;

- (instancetype)initWithCebterTipName:(NSString *)tipName withTipMessage:(NSString *)tipMessageStr withButtonNameArray:(NSArray *)buttonArray withRightUpButtonNormalImage:(UIImage *)butNorImg withRightUpButtonHightImage:(UIImage *)butHigImg;

- (instancetype)initWithMiao:(NSInteger)miao;

- (instancetype)initWithHeadImageURL:(NSString *)imageURL name:(NSString *)name mark:(float )mark orderNumber:(NSInteger )orderNumber;

// 进度条
+ (instancetype)initWithJinduTiaoTipName:(NSString *)tipName;

// 延迟移除进度条
- (void)remove;

// 商户平台通知
- (instancetype)initWithTitleString:(NSString *)title withTipMessage:(NSString *)tipMessageStr withButtonNameArray:(NSArray *)buttonArray;

@end
