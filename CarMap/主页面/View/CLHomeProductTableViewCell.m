//
//  CLHomeProductTableViewCell.m
//  CarMapB
//
//  Created by inCarL on 2019/9/27.
//  Copyright © 2019 mll. All rights reserved.
//

#import "CLHomeProductTableViewCell.h"

@implementation CLHomeProductTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        
        
        UILabel *contentTitleLabel = [[UILabel alloc]init];
        contentTitleLabel.text = @"汽车隔热膜";
        contentTitleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:contentTitleLabel];
        [contentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(25);
            make.bottom.equalTo(self.mas_centerY).offset(-3);
            
        }];
        
        UILabel *contentValueLabel = [[UILabel alloc]init];
        contentValueLabel.text = @"前挡部位 -v70s";
        contentValueLabel.font = [UIFont systemFontOfSize:12];
        contentValueLabel.alpha = 0.8;
        [self addSubview:contentValueLabel];
        [contentValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(25);
            make.top.equalTo(self.mas_centerY).offset(5);
            
        }];
        
        
        UIButton *contentButton = [[UIButton alloc]init];
        [contentButton setTitle:@"选择" forState:UIControlStateNormal];
        contentButton.titleLabel.font = [UIFont systemFontOfSize:15];
        contentButton.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        contentButton.layer.cornerRadius = 14;
        [self addSubview:contentButton];
        [contentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-25);
            make.centerY.equalTo(self);
            make.height.mas_offset(28);
            make.width.mas_offset(70);
        }];
        
    }
    return self;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
