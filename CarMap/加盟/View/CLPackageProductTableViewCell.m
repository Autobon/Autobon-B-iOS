//
//  CLPackageProductTableViewCell.m
//  CarMapB
//
//  Created by inCarL on 2019/9/26.
//  Copyright © 2019 mll. All rights reserved.
//

#import "CLPackageProductTableViewCell.h"

@implementation CLPackageProductTableViewCell
- (void)setProductModel:(CLProductModel *)productModel{
    _productModel = productModel;
    _nameLabel.text = self.productModel.name;
    _priceLabel.text = [NSString stringWithFormat:@"¥%@",self.productModel.price];
    _brandValueLabel.text = self.productModel.brand;
    _constructionPositionValueLabel.text = self.productModel.constructionPositionName;
    _modelValueLabel.text = self.productModel.model;
    _codeValueLabel.text = self.productModel.code;
    _workHourValueLabel.text = self.productModel.workingHours;
    _warrantyPeriodValueLabel.text = self.productModel.warranty;
    
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipsToBounds = YES;
        //编码
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.text = @"汽车隔热膜";
        _nameLabel.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self).offset(5);
            make.height.mas_offset(30);
            make.right.equalTo(self.mas_centerX);
        }];
        
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.text = @"¥200";
        _priceLabel.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        _priceLabel.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.centerY.equalTo(_nameLabel);
        }];
        
        
        
        _removeButton = [[UIButton alloc]init];
        [_removeButton setImage:[UIImage imageNamed:@"clb_tc_btn_del"] forState:UIControlStateNormal];
        [self addSubview:_removeButton];
        [_removeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.nameLabel);
            make.right.equalTo(self).offset(-15);
            make.height.mas_offset(40);
            make.width.mas_offset(40);
        }];
        _removeButton.hidden = YES;
        
        
        
        
        
        
        //型号
        UILabel *brandLabel = [[UILabel alloc]init];
        brandLabel.text = @"品        牌";
        brandLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:brandLabel];
        [brandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(_nameLabel.mas_bottom).offset(0);
            make.height.mas_offset(30);
            make.width.mas_offset(65);
        }];
        
        _brandValueLabel = [[UILabel alloc]init];
        _brandValueLabel.text = @"威固";
        _brandValueLabel.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        _brandValueLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_brandValueLabel];
        [_brandValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(brandLabel.mas_right).offset(15);
            make.centerY.equalTo(brandLabel);
            make.height.mas_offset(30);
            make.right.equalTo(self.mas_centerX);
        }];
        
        
        
        
        
        //施工部位
        UILabel *constructionPositionLabel = [[UILabel alloc]init];
        constructionPositionLabel.text = @"施工部位";
        constructionPositionLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:constructionPositionLabel];
        [constructionPositionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX).offset(-30);
            make.top.equalTo(_nameLabel.mas_bottom).offset(0);
            make.height.mas_offset(30);
            make.width.mas_offset(65);
        }];
        _constructionPositionValueLabel = [[UILabel alloc]init];
        _constructionPositionValueLabel.text = @"前风挡";
        _constructionPositionValueLabel.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        _constructionPositionValueLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_constructionPositionValueLabel];
        [_constructionPositionValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(constructionPositionLabel.mas_right).offset(15);
            make.centerY.equalTo(constructionPositionLabel);
            make.height.mas_offset(30);
            make.right.equalTo(self);
        }];
        
        
        
        //品牌
        UILabel *modelLabel = [[UILabel alloc]init];
        modelLabel.text = @"型        号";
        modelLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:modelLabel];
        [modelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(brandLabel.mas_bottom).offset(0);
            make.height.mas_offset(30);
            make.width.mas_offset(65);
        }];
        
        _modelValueLabel = [[UILabel alloc]init];
        _modelValueLabel.text = @"V70";
        _modelValueLabel.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        _modelValueLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_modelValueLabel];
        [_modelValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(modelLabel.mas_right).offset(15);
            make.centerY.equalTo(modelLabel);
            make.height.mas_offset(30);
            make.right.equalTo(self.mas_centerX);
        }];
        
        
        
        //编码
        UILabel *codeTitleLabel = [[UILabel alloc]init];
        codeTitleLabel.text = @"编        码";
        codeTitleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:codeTitleLabel];
        [codeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX).offset(-30);
            make.top.equalTo(brandLabel.mas_bottom).offset(0);
            make.height.mas_offset(30);
            make.width.mas_offset(65);
        }];
        _codeValueLabel = [[UILabel alloc]init];
        _codeValueLabel.text = @"GRM-WG-V70-001";
        _codeValueLabel.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        _codeValueLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_codeValueLabel];
        [_codeValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(codeTitleLabel.mas_right).offset(15);
            make.centerY.equalTo(codeTitleLabel);
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
            make.top.equalTo(modelLabel.mas_bottom).offset(0);
            make.height.mas_offset(30);
            make.width.mas_offset(65);
        }];
        _workHourValueLabel = [[UILabel alloc]init];
        _workHourValueLabel.text = @"70";
        _workHourValueLabel.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        _workHourValueLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_workHourValueLabel];
        [_workHourValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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
            make.top.equalTo(modelLabel.mas_bottom).offset(0);
            make.height.mas_offset(30);
            make.width.mas_offset(65);
        }];
        _warrantyPeriodValueLabel = [[UILabel alloc]init];
        _warrantyPeriodValueLabel.text = @"60月";
        _warrantyPeriodValueLabel.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        _warrantyPeriodValueLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_warrantyPeriodValueLabel];
        [_warrantyPeriodValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(warrantyPeriodLabel.mas_right).offset(15);
            make.centerY.equalTo(warrantyPeriodLabel);
            make.height.mas_offset(30);
            make.right.equalTo(self);
        }];
        
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self);
            make.height.mas_offset(1);
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
