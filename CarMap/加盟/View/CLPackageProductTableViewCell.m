//
//  CLPackageProductTableViewCell.m
//  CarMapB
//
//  Created by inCarL on 2019/9/26.
//  Copyright © 2019 mll. All rights reserved.
//

#import "CLPackageProductTableViewCell.h"

@implementation CLPackageProductTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipsToBounds = YES;
        //编码
        UILabel *numberLabel = [[UILabel alloc]init];
        numberLabel.text = @"汽车隔热膜";
        numberLabel.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:numberLabel];
        [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self).offset(5);
            make.height.mas_offset(30);
            make.right.equalTo(self.mas_centerX);
        }];
        
        //型号
        UILabel *typeLabel = [[UILabel alloc]init];
        typeLabel.text = @"品        牌";
        typeLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:typeLabel];
        [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(numberLabel.mas_bottom).offset(0);
            make.height.mas_offset(30);
            make.width.mas_offset(65);
        }];
        
        UILabel *typeValueLabel = [[UILabel alloc]init];
        typeValueLabel.text = @"威固";
        typeValueLabel.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        typeValueLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:typeValueLabel];
        [typeValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(typeLabel.mas_right).offset(15);
            make.centerY.equalTo(typeLabel);
            make.height.mas_offset(30);
            make.right.equalTo(self.mas_centerX);
        }];
        
        
        
        
        
        //施工项目
        UILabel *construcationProjectLabel = [[UILabel alloc]init];
        construcationProjectLabel.text = @"施工部位";
        construcationProjectLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:construcationProjectLabel];
        [construcationProjectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX).offset(-30);
            make.top.equalTo(numberLabel.mas_bottom).offset(0);
            make.height.mas_offset(30);
            make.width.mas_offset(65);
        }];
        UILabel *construcationProjectValueLabel = [[UILabel alloc]init];
        construcationProjectValueLabel.text = @"前风挡";
        construcationProjectValueLabel.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        construcationProjectValueLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:construcationProjectValueLabel];
        [construcationProjectValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(construcationProjectLabel.mas_right).offset(15);
            make.centerY.equalTo(construcationProjectLabel);
            make.height.mas_offset(30);
            make.right.equalTo(self);
        }];
        
        
        
        //品牌
        UILabel *brandLabel = [[UILabel alloc]init];
        brandLabel.text = @"型        号";
        brandLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:brandLabel];
        [brandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(typeLabel.mas_bottom).offset(0);
            make.height.mas_offset(30);
            make.width.mas_offset(65);
        }];
        
        UILabel *brandValueLabel = [[UILabel alloc]init];
        brandValueLabel.text = @"V70";
        brandValueLabel.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        brandValueLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:brandValueLabel];
        [brandValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(brandLabel.mas_right).offset(15);
            make.centerY.equalTo(brandLabel);
            make.height.mas_offset(30);
            make.right.equalTo(self.mas_centerX);
        }];
        
        
        
        //施工部位
        UILabel *constructionLocationLabel = [[UILabel alloc]init];
        constructionLocationLabel.text = @"编        码";
        constructionLocationLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:constructionLocationLabel];
        [constructionLocationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX).offset(-30);
            make.top.equalTo(typeLabel.mas_bottom).offset(0);
            make.height.mas_offset(30);
            make.width.mas_offset(65);
        }];
        UILabel *constructionLocationValueLabel = [[UILabel alloc]init];
        constructionLocationValueLabel.text = @"GRM-WG-V70-001";
        constructionLocationValueLabel.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        constructionLocationValueLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:constructionLocationValueLabel];
        [constructionLocationValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(constructionLocationLabel.mas_right).offset(15);
            make.centerY.equalTo(constructionLocationLabel);
            make.height.mas_offset(30);
            make.right.equalTo(self);
        }];
        
        //工时
        UILabel *workHourLabel = [[UILabel alloc]init];
        workHourLabel.text = @"工        时";
        workHourLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:workHourLabel];
        [workHourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(brandLabel.mas_bottom).offset(0);
            make.height.mas_offset(30);
            make.width.mas_offset(65);
        }];
        UILabel *workHourValueLabel = [[UILabel alloc]init];
        workHourValueLabel.text = @"70";
        workHourValueLabel.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        workHourValueLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:workHourValueLabel];
        [workHourValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(workHourLabel.mas_right).offset(15);
            make.centerY.equalTo(workHourLabel);
            make.height.mas_offset(30);
            make.right.equalTo(self.mas_centerX);
        }];
        
        //质保期间
        UILabel *warrantyPeriodLabel = [[UILabel alloc]init];
        warrantyPeriodLabel.text = @"质保期间";
        warrantyPeriodLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:warrantyPeriodLabel];
        [warrantyPeriodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX).offset(-30);
            make.top.equalTo(brandLabel.mas_bottom).offset(0);
            make.height.mas_offset(30);
            make.width.mas_offset(65);
        }];
        UILabel *warrantyPeriodValueLabel = [[UILabel alloc]init];
        warrantyPeriodValueLabel.text = @"60月";
        warrantyPeriodValueLabel.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        warrantyPeriodValueLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:warrantyPeriodValueLabel];
        [warrantyPeriodValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(warrantyPeriodLabel.mas_right).offset(15);
            make.centerY.equalTo(warrantyPeriodLabel);
            make.height.mas_offset(30);
            make.right.equalTo(self);
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
