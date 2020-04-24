//
//  GFWorkerTableViewCell.m
//  车邻邦客户端
//
//  Created by 陈光法 on 16/3/4.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFWorkerTableViewCell.h"

@implementation GFWorkerTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self != nil) {
    
        CGFloat kwidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
        
        CGFloat jianjv1 = kwidth * 0.042;
        
        self.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
        
        
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kwidth, kHeight * 0.078)];
        baseView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:baseView];
        
        // 边线
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kwidth, 1)];
        lineView1.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
        [baseView addSubview:lineView1];
        
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight * 0.078 - 1, kwidth, 1)];
        lineView2.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
        [baseView addSubview:lineView2];
        
        // 左边lab
        self.leftLab = [[UILabel alloc] init];
        self.leftLab.frame = CGRectMake(jianjv1, 0, kwidth - jianjv1 * 2, kHeight * 0.078);
        self.leftLab.font = [UIFont systemFontOfSize:15 / 320.0 * kwidth];
        self.leftLab.textAlignment = NSTextAlignmentLeft;
        [baseView addSubview:self.leftLab];
        self.leftLab.text = @"左边";
        
        // 中间Lab
        self.centerLab = [[UILabel alloc] init];
        self.centerLab.frame = CGRectMake(jianjv1, 0, kwidth - jianjv1 * 2, kHeight * 0.078);
        self.centerLab.font = [UIFont systemFontOfSize:15 / 320.0 * kwidth];
        self.centerLab.textAlignment = NSTextAlignmentCenter;
        [baseView addSubview:self.centerLab];
        self.centerLab.text = @"中间";
        
        // 右边按钮
        CGFloat rightButW = kwidth * 0.139;
        CGFloat rightButH = kHeight * 0.0365;
        CGFloat rightButX = kwidth - jianjv1 - rightButW;
        CGFloat rightButY = (kHeight * 0.078 - rightButH) / 2.0;
        self.rightBut = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBut.frame = CGRectMake(rightButX, rightButY, rightButW, rightButH);
        self.rightBut.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
        self.rightBut.layer.borderWidth = 1;
        self.rightBut.layer.cornerRadius = 5;
        [self.rightBut setTitle:@"离职" forState:UIControlStateNormal];
        self.rightBut.titleLabel.font = [UIFont systemFontOfSize:14 / 320.0 * kwidth];
        [self.rightBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
        [baseView addSubview:self.rightBut];
        
        // 编辑按钮
        CGFloat bianjiButW = rightButW;
        CGFloat bianjiButH = rightButH;
        CGFloat bianjiButX = CGRectGetMinX(self.rightBut.frame) - bianjiButW - 5;
        CGFloat bianjiButY = rightButY;
        self.bianjiBut = [UIButton buttonWithType:UIButtonTypeCustom];
        self.bianjiBut.frame = CGRectMake(bianjiButX, bianjiButY, bianjiButW, bianjiButH);
        self.bianjiBut.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
        self.bianjiBut.layer.borderWidth = 1;
        self.bianjiBut.layer.cornerRadius = 5;
        [self.bianjiBut setTitle:@"编辑" forState:UIControlStateNormal];
        self.bianjiBut.titleLabel.font = [UIFont systemFontOfSize:14 / 320.0 * kwidth];
        [self.bianjiBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
        [baseView addSubview:self.bianjiBut];
        
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
