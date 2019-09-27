//
//  CLProductTableViewCell.m
//  CarMapB
//
//  Created by inCarL on 2019/9/25.
//  Copyright © 2019 mll. All rights reserved.
//

#import "CLProductTableViewCell.h"

@implementation CLProductTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipsToBounds = YES;
        //编码
        UILabel *numberLabel = [[UILabel alloc]init];
        numberLabel.text = @"编码：1234657899";
        numberLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:numberLabel];
        [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self).offset(5);
            make.height.mas_offset(30);
            make.right.equalTo(self.mas_centerX);
        }];
        
        //型号
        UILabel *typeLabel = [[UILabel alloc]init];
        typeLabel.text = @"型号：1234657899";
        typeLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:typeLabel];
        [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(numberLabel.mas_bottom).offset(0);
            make.height.mas_offset(30);
            make.right.equalTo(self.mas_centerX);
        }];
        
        //品牌
        UILabel *brandLabel = [[UILabel alloc]init];
        brandLabel.text = @"品牌：1234657899";
        brandLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:brandLabel];
        [brandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX).offset(15);
            make.top.equalTo(numberLabel.mas_bottom).offset(0);
            make.height.mas_offset(30);
            make.right.equalTo(self);
        }];
        
        //施工项目
        UILabel *construcationProjectLabel = [[UILabel alloc]init];
        construcationProjectLabel.text = @"施工项目：1234657899";
        construcationProjectLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:construcationProjectLabel];
        [construcationProjectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(typeLabel.mas_bottom).offset(0);
            make.height.mas_offset(30);
            make.right.equalTo(self.mas_centerX);
        }];
        
        //施工部位
        UILabel *constructionLocationLabel = [[UILabel alloc]init];
        constructionLocationLabel.text = @"施工部位：1234657899";
        constructionLocationLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:constructionLocationLabel];
        [constructionLocationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX).offset(15);
            make.top.equalTo(typeLabel.mas_bottom).offset(0);
            make.height.mas_offset(30);
            make.right.equalTo(self);
        }];
        
        //工时
        UILabel *workHourLabel = [[UILabel alloc]init];
        workHourLabel.text = @"工时：1234657899";
        workHourLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:workHourLabel];
        [workHourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(construcationProjectLabel.mas_bottom).offset(0);
            make.height.mas_offset(30);
            make.right.equalTo(self.mas_centerX);
        }];
        
        //质保期间
        UILabel *warrantyPeriodLabel = [[UILabel alloc]init];
        warrantyPeriodLabel.text = @"质保期间：1234657899";
        warrantyPeriodLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:warrantyPeriodLabel];
        [warrantyPeriodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX).offset(15);
            make.top.equalTo(construcationProjectLabel.mas_bottom).offset(0);
            make.height.mas_offset(30);
            make.right.equalTo(self);
        }];
        
        
        
        
        UIView *buttonBaseView = [[UIView alloc]init];
        buttonBaseView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        [self addSubview:buttonBaseView];
        [buttonBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self);
            make.height.mas_offset(45);
        }];
        
        _detailButton = [[UIButton alloc]init];
        [_detailButton setTitle:@"查看详情" forState:UIControlStateNormal];
        [_detailButton setTitle:@"关闭详情" forState:UIControlStateSelected];
        [_detailButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _detailButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [buttonBaseView addSubview:_detailButton];
        [_detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(buttonBaseView);
            make.right.equalTo(buttonBaseView.mas_centerX);
        }];
        
        _addButton = [[UIButton alloc]init];
        [_addButton setTitle:@"添加至我的套餐" forState:UIControlStateNormal];
        [_addButton setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
        _addButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [buttonBaseView addSubview:_addButton];
        [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(buttonBaseView);
            make.left.equalTo(buttonBaseView.mas_centerX);
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
