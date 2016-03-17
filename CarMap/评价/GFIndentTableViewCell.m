//
//  GFIndentTableViewCell.m
//  CarMap
//
//  Created by 陈光法 on 16/2/25.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFIndentTableViewCell.h"

@implementation GFIndentTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat jiange = kWidth * 0.033;
    CGFloat jiange1 = kWidth * 0.056;
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    if(self != nil) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
        
        // 基础视图
        CGFloat baseViewW = kWidth;
        CGFloat baseViewH = kHeight * 0.339;
        CGFloat baseViewX = 0;
        CGFloat baseViewY = kHeight * 0.0183;
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
        baseView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:baseView];
        
        
        CGFloat numberLabW = kWidth - jiange * 2;
        CGFloat numberLabH = kHeight * 0.078125;
        CGFloat numberLabX = jiange;
        CGFloat numberLabY = 0;
        self.numberLab = [[UILabel alloc] initWithFrame:CGRectMake(numberLabX, numberLabY, numberLabW, numberLabH)];
        self.numberLab.text = @"订单编号sdjfhashdfgs";
        self.numberLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
//        [baseView addSubview:self.numberLab];
        // 订单编号
        CGFloat moneyLabW = 200;
        CGFloat moneyLabH = kHeight * 0.078125 / 2.0;
        CGFloat moneyLabX = jiange;
        CGFloat moneyLabY = 3 / 568.0 * kHeight;
        self.moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(moneyLabX, moneyLabY, moneyLabW, moneyLabH)];
        self.moneyLab.text = @"￥200";
        self.moneyLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
//        self.moneyLab.textAlignment = NSTextAlignmentRight;
//        self.moneyLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
//        self.moneyLab.backgroundColor = [UIColor redColor];
        [baseView addSubview:self.moneyLab];
        
        // 工作内容
        CGFloat tipLabW = moneyLabW;
        CGFloat tipLabH = moneyLabH;
        CGFloat tipLabX = moneyLabX;
        CGFloat tipLabY = CGRectGetMaxY(self.moneyLab.frame) - 6 / 568.0 * kHeight;
        self.timeLab = [[UILabel alloc] initWithFrame:CGRectMake(tipLabX, tipLabY, tipLabW, tipLabH)];
        self.timeLab.text = @"￥20000";
        self.timeLab.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        self.timeLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
//        self.timeLab.backgroundColor = [UIColor redColor];
        [baseView addSubview:self.timeLab];
        
        
        // 评价按钮
        self.pingjiaBut = [UIButton buttonWithType:UIButtonTypeCustom];
        self.pingjiaBut.frame = CGRectMake(kWidth - jiange - kWidth * 0.185, (numberLabH - kHeight * 0.044) * 0.5 + 1, kWidth * 0.185, kHeight * 0.044);
        self.pingjiaBut.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
        self.pingjiaBut.layer.borderWidth = 1;
        self.pingjiaBut.layer.cornerRadius = 5;
        [self.pingjiaBut setTitle:@"已评价" forState:UIControlStateNormal];
        [self.pingjiaBut setTitle:@"去评价" forState:UIControlStateSelected];
        self.pingjiaBut.titleLabel.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
        [self.pingjiaBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
        [baseView addSubview:self.pingjiaBut];
        
        
        // 订单图片
        CGFloat photoImgViewW = kWidth - jiange * 2;
        CGFloat photoImgViewH = kHeight * 0.2344;
        CGFloat photoImgViewX = jiange;
        CGFloat photoImgViewY = CGRectGetMaxY(self.numberLab.frame) + kHeight * 0.013;
        self.photoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(photoImgViewX, photoImgViewY, photoImgViewW, photoImgViewH)];
        self.photoImgView.image = [UIImage imageNamed:@"orderImage.png"];
        [baseView addSubview:self.photoImgView];
        
        
        // 边线
        UIView *upLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 1)];
        upLine.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
        [baseView addSubview:upLine];
        
        UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(0, baseViewH - 1, kWidth, 1)];
        downLine.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
        [baseView addSubview:downLine];
        
        UIView *line_1 = [[UIView alloc] initWithFrame:CGRectMake(photoImgViewX, CGRectGetMaxY(self.numberLab.frame), photoImgViewW, 1)];
        line_1.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
        [baseView addSubview:line_1];
        
//        UIView *line_2 = [[UIView alloc] initWithFrame:CGRectMake(photoImgViewX, CGRectGetMinY(self.timeLab.frame), photoImgViewW, 1)];
//        line_2.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
//        [baseView addSubview:line_2];
//        
//        UIView *line_3 = [[UIView alloc] initWithFrame:CGRectMake(photoImgViewX, CGRectGetMaxY(self.timeLab.frame), photoImgViewW, 1)];
//        line_3.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
//        [baseView addSubview:line_3];
        
    }
    
    return self;

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
