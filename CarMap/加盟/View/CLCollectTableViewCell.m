//
//  CLCollectTableViewCell.m
//  CarMapB
//
//  Created by inCar on 17/5/19.
//  Copyright © 2017年 mll. All rights reserved.
//

#import "CLCollectTableViewCell.h"
#import "GFTitleView.h"
#import "UIImageView+WebCache.h"


@implementation CLCollectTableViewCell






- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat jiange = kWidth * 0.033;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self != nil) {
        self.backgroundColor = [UIColor whiteColor];
        // 技师头像栏
        UIView *iconView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight * 0.15625)];
        iconView.backgroundColor = [UIColor whiteColor];
        [self addSubview:iconView];
        // 边线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight * 0.15625, kWidth, 1)];
        lineView.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
        [iconView addSubview:lineView];
        
        //    _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(lineView.frame));
        
        // 头像
        CGFloat iconImgViewW = 0.181 * kWidth;
        CGFloat iconImgViewH = iconImgViewW;
        CGFloat iconImgViewX = kWidth * 0.04;
        CGFloat iconImgViewY = (kHeight * 0.15625 - iconImgViewH) / 2.0;
        UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(iconImgViewX, iconImgViewY, iconImgViewW, iconImgViewH)];
        iconImgView.layer.cornerRadius = iconImgViewW / 2.0;
        iconImgView.clipsToBounds = YES;
        iconImgView.image = [UIImage imageNamed:@"userHeadImage"];
        [iconView addSubview:iconImgView];
        
        // 姓名
        CGFloat nameLabW =60;
        CGFloat nameLabH = 20;
        CGFloat nameLabX = CGRectGetMaxX(iconImgView.frame) + kWidth * 0.0463;
        CGFloat nameLabY = kHeight * 0.04;
        UILabel *nameLab = [[UILabel alloc] init];
        nameLab.frame = CGRectMake(nameLabX, nameLabY, nameLabW, nameLabH);
        nameLab.text = @"技师姓名";
        nameLab.font = [UIFont systemFontOfSize:14];
        [iconView addSubview:nameLab];
        
        
        // 电话号码
        CGFloat phoneLabW = 200;
        CGFloat phoneLabH = nameLabH;
        CGFloat phoneLabX = CGRectGetMaxX(nameLab.frame);
        CGFloat phoneLabY = nameLabY;
        UIButton *phoneBtn = [[UIButton alloc] init];
        phoneBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [phoneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [phoneBtn setTitle:@"18672944895" forState:UIControlStateNormal];
        phoneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addSubview:phoneBtn];
        phoneBtn.frame = CGRectMake(CGRectGetMaxX(nameLab.frame)  + 10, phoneLabY, phoneLabW, phoneLabH);
        [phoneBtn setTitle:@"18672944895" forState:UIControlStateNormal];
        
        
        
        
        // 订单数
        
       
        UILabel *indentLab = [[UILabel alloc] init];
        NSString *indentStr = @"订单数:";
        indentLab.font = [UIFont systemFontOfSize:15];
        CGFloat indentLabW = 60;
        CGFloat indentLabH = 15;
        CGFloat indentLabX = nameLabX;
        CGFloat indentLabY = CGRectGetMaxY(nameLab.frame) + kHeight * 0.0303;
        indentLab.frame = CGRectMake(indentLabX, indentLabY, indentLabW, indentLabH);
        indentLab.text = indentStr;
        [iconView addSubview:indentLab];
        
        // 订单数目
        UILabel *numLab = [[UILabel alloc] init];
        [iconView addSubview:numLab];
        numLab.font = [UIFont systemFontOfSize:15];
        CGFloat numLabW = 20;
        CGFloat numLabH = indentLabH;
        CGFloat numLabX = CGRectGetMaxX(indentLab.frame) + 5 / 320.0 * kWidth;
        CGFloat numLabY = indentLabY;
        numLab.frame = CGRectMake(numLabX, numLabY, numLabW, numLabH);
        numLab.text = @"999";
        numLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        numLab.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        [numLab sizeToFit];
        
        // 橘色星星
        for(int i=0; i<3; i++) {
            
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
        for(int i=0; i < 5 - 3; i++) {
            
            CGFloat starImgViewW = nameLabH - 2;
            CGFloat starImgViewH = nameLabH - 2;
            CGFloat starImgViewX = CGRectGetMaxX(numLab.frame) + kHeight * 0.014 + starImgViewW * (i + 3);
            CGFloat starImgViewY = numLabY;
            UIImageView *starImgView = [[UIImageView alloc] initWithFrame:CGRectMake(starImgViewX, starImgViewY, starImgViewW, starImgViewH)];
            starImgView.contentMode = UIViewContentModeScaleAspectFit;
            //        starImgView.backgroundColor = [UIColor greenColor];
            starImgView.image = [UIImage imageNamed:@"detailsStarDark"];
            [iconView addSubview:starImgView];
        }
        
        
        
        
        // 移除
        UIButton *pingjiaBut = [UIButton buttonWithType:UIButtonTypeCustom];
        pingjiaBut.frame = CGRectMake(kWidth - 55, 20, 45, 25);
        pingjiaBut.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
        pingjiaBut.layer.borderWidth = 1;
        pingjiaBut.layer.cornerRadius = 5;
        [pingjiaBut setTitle:@"移除" forState:UIControlStateNormal];
        pingjiaBut.titleLabel.font = [UIFont systemFontOfSize:14];
        [pingjiaBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
        [iconView addSubview:pingjiaBut];
        
        
        
        
        
    }
    return self;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
