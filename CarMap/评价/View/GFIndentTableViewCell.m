//
//  GFIndentTableViewCell.m
//  CarMap
//
//  Created by 陈光法 on 16/2/25.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFIndentTableViewCell.h"
//#import "CLImageView.h"

#import "GFNewIndentModel.h"

#import "GFEvaluateViewController.h"


@implementation GFIndentTableViewCell

- (void)setModel:(GFNewIndentModel *)model {

    _model = model;
    
    self.numberLab.text = [NSString stringWithFormat:@"订单编号%@", model.orderNum];
    self.timeLab.text = [NSString stringWithFormat:@"%@", model.typeName];
    self.yuyueTimeLab.text = [NSString stringWithFormat:@"预约时间：%@",model.agreedStartTime];
    if([_model.status isEqualToString:@"FINISHED"]) {
    
        [self.pingjiaBut setTitle:@"去评价" forState:UIControlStateNormal];
        self.pingjiaBut.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
        [self.pingjiaBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
        self.pingjiaBut.enabled = YES;
    }else if([_model.status isEqualToString:@"COMMENTED"]) {
        
        [self.pingjiaBut setTitle:@"已评价" forState:UIControlStateNormal];
        self.pingjiaBut.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:0.5] CGColor];
        [self.pingjiaBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:0.5] forState:UIControlStateNormal];
        self.pingjiaBut.enabled = NO;
    }else {
        
        [self.pingjiaBut setTitle:@"已撤消" forState:UIControlStateNormal];
        self.pingjiaBut.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:0.5] CGColor];
        [self.pingjiaBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:0.5] forState:UIControlStateNormal];
        self.pingjiaBut.enabled = NO;
    }
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat jiange = kWidth * 0.033;
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    if(self != nil) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
        
        // 基础视图
        CGFloat baseViewW = kWidth;
        CGFloat baseViewH = 85;
        CGFloat baseViewX = 0;
        CGFloat baseViewY = 5;
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
        baseView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:baseView];
        
        
        CGFloat numberLabW = kWidth - jiange * 2;
        CGFloat numberLabH = 25;
        CGFloat numberLabX = jiange;
        CGFloat numberLabY = 10;
        self.numberLab = [[UILabel alloc] initWithFrame:CGRectMake(numberLabX, numberLabY-5, numberLabW, numberLabH)];
        self.numberLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
        [baseView addSubview:self.numberLab];
        
        // 工作内容
        CGFloat tipLabW = 240 / 375.0 * kWidth;
        CGFloat tipLabH = 25;
        CGFloat tipLabX = jiange;
        CGFloat tipLabY = CGRectGetMaxY(self.numberLab.frame);
        self.timeLab = [[UILabel alloc] initWithFrame:CGRectMake(tipLabX, tipLabY, tipLabW, tipLabH)];
        self.timeLab.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        self.timeLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
        [baseView addSubview:self.timeLab];
        
        // 预约时间
        CGFloat timeLabW = numberLabW;
        CGFloat timeLabH = 25;
        CGFloat timeLabX = numberLabX;
        CGFloat timeLabY = CGRectGetMaxY(self.timeLab.frame);
        UILabel *yuyueTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(timeLabX, timeLabY, timeLabW, timeLabH)];
        yuyueTimeLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
        yuyueTimeLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
        [baseView addSubview:yuyueTimeLab];
        self.yuyueTimeLab = yuyueTimeLab;
        
        
        
        // 评价按钮
        self.pingjiaBut = [UIButton buttonWithType:UIButtonTypeCustom];
        self.pingjiaBut.frame = CGRectMake(kWidth - jiange - kWidth * 0.185, 15, kWidth * 0.185, kHeight * 0.044);
        self.pingjiaBut.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
        self.pingjiaBut.layer.borderWidth = 1;
        self.pingjiaBut.layer.cornerRadius = 5;
        [self.pingjiaBut setTitle:@"已评价" forState:UIControlStateNormal];
        [self.pingjiaBut setTitle:@"去评价" forState:UIControlStateSelected];
        self.pingjiaBut.titleLabel.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
        [self.pingjiaBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
        [baseView addSubview:self.pingjiaBut];
        [self.pingjiaBut addTarget:self action:@selector(pingjiaButClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        // 边线
        UIView *upLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 1)];
        upLine.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
        [baseView addSubview:upLine];
        
        UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(0, baseView.frame.size.height - 1, kWidth, 1)];
        downLine.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
        [baseView addSubview:downLine];
        
    }
    
    return self;

}

- (void)pingjiaButClick:(UIButton *)sender {
    
//    NSLog(@"========%@", sender.titleLabel.text);
    
    if([sender.titleLabel.text isEqualToString:@"去评价"]) {
    
        GFEvaluateViewController *evaluateView = [[GFEvaluateViewController alloc]init];
        //    _indentViewButton = button;
        evaluateView.orderId = self.model.orderID;
        evaluateView.isPush = YES;
        [[self viewController].navigationController pushViewController:evaluateView animated:YES];
    }
}


//获取view的controller
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
