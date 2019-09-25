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
    
    self.numberLab.text = [NSString stringWithFormat:@"车牌号：%@", model.license];
    self.vinLab.text = [NSString stringWithFormat:@"车架号：%@", model.vin];
    self.timeLab.text = [NSString stringWithFormat:@"%@", model.typeName];
    self.yuyueTimeLab.text = [NSString stringWithFormat:@"预约施工时间：%@",model.agreedStartTime];
    self.contactPhoneLab.text = [NSString stringWithFormat:@"下单人手机号：%@",model.contactPhone];
    
    if([model.status isEqualToString:@"CREATED_TO_APPOINT"]) {
        self.appointButton.hidden = NO;
        self.removeOrderButton.hidden = NO;
        self.pingjiaBut.hidden = YES;
        self.statusLabel.text = @"待指派";
    }else if([model.status isEqualToString:@"NEWLY_CREATED"]) {
        self.appointButton.hidden = NO;
        self.removeOrderButton.hidden = NO;
        self.pingjiaBut.hidden = YES;
        self.statusLabel.text = @"未接单";
    }else if([model.status isEqualToString:@"TAKEN_UP"]) {
        self.appointButton.hidden = YES;
        self.removeOrderButton.hidden = YES;
        self.pingjiaBut.hidden = YES;
        self.statusLabel.text = @"已接单";
    }else if([model.status isEqualToString:@"IN_PROGRESS"]) {
        self.appointButton.hidden = YES;
        self.removeOrderButton.hidden = YES;
        self.pingjiaBut.hidden = YES;
        self.statusLabel.text = @"已出发";
    }else if([model.status isEqualToString:@"SIGNED_IN"]) {
        self.appointButton.hidden = YES;
        self.removeOrderButton.hidden = YES;
        self.pingjiaBut.hidden = YES;
        self.statusLabel.text = @"已签到";
    }else if([model.status isEqualToString:@"AT_WORK"]) {
        self.appointButton.hidden = YES;
        self.removeOrderButton.hidden = YES;
        self.pingjiaBut.hidden = YES;
        self.statusLabel.text = @"施工中";
    }else if([_model.status isEqualToString:@"FINISHED"]) {
        self.appointButton.hidden = YES;
        self.removeOrderButton.hidden = YES;
        self.pingjiaBut.hidden = NO;
        self.statusLabel.text = @" ";
        [self.pingjiaBut setTitle:@"去评价" forState:UIControlStateNormal];
        self.pingjiaBut.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
        [self.pingjiaBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
        self.pingjiaBut.enabled = YES;
    }else if([_model.status isEqualToString:@"COMMENTED"]) {
        self.statusLabel.text = @" ";
        self.appointButton.hidden = YES;
        self.removeOrderButton.hidden = YES;
        self.pingjiaBut.hidden = NO;
        [self.pingjiaBut setTitle:@"已评价" forState:UIControlStateNormal];
        self.pingjiaBut.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:0.5] CGColor];
        [self.pingjiaBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:0.5] forState:UIControlStateNormal];
        self.pingjiaBut.enabled = NO;
    }else {
        self.appointButton.hidden = YES;
        self.removeOrderButton.hidden = YES;
        self.pingjiaBut.hidden = NO;
        self.statusLabel.text = @" ";
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
        CGFloat baseViewH = 110;
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
        
        
        self.vinLab = [[UILabel alloc] initWithFrame:CGRectMake(numberLabX, CGRectGetMaxY(self.numberLab.frame) + 5, numberLabW, numberLabH)];
        self.vinLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
        [baseView addSubview:self.vinLab];
        
        
        // 工作内容
        CGFloat tipLabW = 240 / 375.0 * kWidth;
        CGFloat tipLabH = 25;
        CGFloat tipLabX = jiange;
        CGFloat tipLabY = CGRectGetMaxY(self.vinLab.frame);
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
        
        
        // 下单人联系方式
        CGFloat contactPhoneLabW = numberLabW;
        CGFloat contactPhoneLabH = 25;
        CGFloat contactPhoneLabX = numberLabX;
        CGFloat contactPhoneLabY = CGRectGetMaxY(self.yuyueTimeLab.frame);
        UILabel *contactPhoneLab = [[UILabel alloc] initWithFrame:CGRectMake(contactPhoneLabX, contactPhoneLabY, contactPhoneLabW, contactPhoneLabH)];
        contactPhoneLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
        contactPhoneLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
        [baseView addSubview:contactPhoneLab];
        self.contactPhoneLab = contactPhoneLab;
        
        
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
        
        
        
        
        // 撤单
        _removeOrderButton = [[UIButton alloc]init];
        _removeOrderButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 60, CGRectGetMidY(_numberLab.frame)-kHeight * 0.016, 50, 25);
        [_removeOrderButton setTitle:@"撤单" forState:UIControlStateNormal];
        [_removeOrderButton setTitleColor:[UIColor colorWithRed:88 / 255.0 green:88 / 255.0 blue:88 / 255.0 alpha:1] forState:UIControlStateNormal];
        _removeOrderButton.layer.cornerRadius = 5;
        _removeOrderButton.layer.borderWidth = 1.0;
        _removeOrderButton.layer.borderColor = [[UIColor colorWithRed:153.0 / 255.0 green:153.0 / 255.0 blue:153.0 / 255.0 alpha:1] CGColor];
        _removeOrderButton.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [baseView addSubview:_removeOrderButton];
        
        
        // 指定技师
        _appointButton = [[UIButton alloc]init];
        _appointButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 60-80, CGRectGetMidY(_numberLab.frame)-kHeight * 0.016, 70, 25);
        [_appointButton setTitle:@"指定技师" forState:UIControlStateNormal];
        [_appointButton setTitleColor:[UIColor colorWithRed:217/255.0 green:105/255.0 blue:42/255.0 alpha:1.0] forState:UIControlStateNormal];
        _appointButton.layer.cornerRadius = 5;
        _appointButton.layer.borderWidth = 1.0;
        _appointButton.layer.borderColor = [[UIColor colorWithRed:217/255.0 green:105/255.0 blue:42/255.0 alpha:1.0]CGColor];
        _appointButton.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [baseView addSubview:_appointButton];
        
        
        
        
        
        _statusLabel = [[UILabel alloc]init];
        _statusLabel.font = [UIFont systemFontOfSize:14];
        _statusLabel.alpha = 0.5;
        _statusLabel.text = @"待指派";
        _statusLabel.textAlignment = NSTextAlignmentRight;
        [baseView addSubview:_statusLabel];
        _statusLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 60, CGRectGetMaxY(_numberLab.frame) + 15, 50, 20);
        
        
        
        
        
        
        
        
        
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
