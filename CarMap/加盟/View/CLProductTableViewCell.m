//
//  CLProductTableViewCell.m
//  CarMapB
//
//  Created by inCarL on 2019/9/25.
//  Copyright © 2019 mll. All rights reserved.
//

#import "CLProductTableViewCell.h"

@implementation CLProductTableViewCell



- (void)setProductModel:(CLProductModel *)productModel{
    _productModel = productModel;
//    self.numberLabel.text = [NSString stringWithFormat:@"编码：%@", self.productModel.code];
//    _priceLabel.text = [NSString stringWithFormat:@"¥%@元",self.productModel.price];
//    self.typeLabel.text = [NSString stringWithFormat:@"型号：%@", self.productModel.model];
//    self.brandLabel.text = [NSString stringWithFormat:@"品牌：%@", self.productModel.brand];
//    self.construcationProjectLabel.text = [NSString stringWithFormat:@"施工项目：%@", self.productModel.typeName];
//    self.constructionLocationLabel.text = [NSString stringWithFormat:@"施工部位：%@", self.productModel.constructionPositionName];
//    self.workHourLabel.text = [NSString stringWithFormat:@"工时：%@", self.productModel.workingHours];
//    self.warrantyPeriodLabel.text = [NSString stringWithFormat:@"质保期间：%@月", self.productModel.warranty];
    
    
    
    self.numberLabel.text = [NSString stringWithFormat:@"型号：%@", self.productModel.model];
    _priceLabel.text = [NSString stringWithFormat:@"¥%@(元)",self.productModel.price];
    self.typeLabel.text = [NSString stringWithFormat:@"施工项目：%@", self.productModel.typeName];
    self.brandLabel.text = [NSString stringWithFormat:@"施工部位：%@", self.productModel.constructionPositionName];
    self.construcationProjectLabel.text = [NSString stringWithFormat:@"品牌：%@", self.productModel.brand];
    self.constructionLocationLabel.text = [NSString stringWithFormat:@"工时：%@", self.productModel.workingHours];
    self.workHourLabel.text = [NSString stringWithFormat:@"质保期间：%@月", self.productModel.warranty];
//    self.warrantyPeriodLabel.text = [NSString stringWithFormat:@"质保期间：%@月", self.productModel.warranty];
    self.warrantyPeriodLabel.hidden = YES;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.clipsToBounds = YES;
        //编码
        _numberLabel = [[UILabel alloc]init];
//        _numberLabel.text = @"编码：1234657899";
        _numberLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_numberLabel];
        [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self).offset(5);
            make.height.mas_offset(30);
            make.right.equalTo(self).offset(-100);
        }];
        
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.text = @"¥200";
        _priceLabel.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        _priceLabel.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.centerY.equalTo(_numberLabel);
        }];
        
        //型号
        _typeLabel = [[UILabel alloc]init];
//        _typeLabel.text = @"型号：1234657899";
        _typeLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_typeLabel];
        [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(_numberLabel.mas_bottom).offset(0);
            make.height.mas_offset(30);
            make.right.equalTo(self.mas_centerX);
        }];
        
        //品牌
        _brandLabel = [[UILabel alloc]init];
//        _brandLabel.text = @"品牌：1234657899";
        _brandLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_brandLabel];
        [_brandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX).offset(15);
            make.top.equalTo(_numberLabel.mas_bottom).offset(0);
            make.height.mas_offset(30);
            make.right.equalTo(self);
        }];
        
        //施工项目
        _construcationProjectLabel = [[UILabel alloc]init];
//        _construcationProjectLabel.text = @"施工项目：1234657899";
        _construcationProjectLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_construcationProjectLabel];
        [_construcationProjectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(_typeLabel.mas_bottom).offset(0);
            make.height.mas_offset(30);
            make.right.equalTo(self.mas_centerX);
        }];
        
        //施工部位
        _constructionLocationLabel = [[UILabel alloc]init];
//        _constructionLocationLabel.text = @"施工部位：1234657899";
        _constructionLocationLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_constructionLocationLabel];
        [_constructionLocationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX).offset(15);
            make.top.equalTo(_typeLabel.mas_bottom).offset(0);
            make.height.mas_offset(30);
            make.right.equalTo(self);
        }];
        
        //工时
        _workHourLabel = [[UILabel alloc]init];
//        _workHourLabel.text = @"工时：1234657899";
        _workHourLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_workHourLabel];
        [_workHourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(_construcationProjectLabel.mas_bottom).offset(0);
            make.height.mas_offset(30);
            make.right.equalTo(self.mas_centerX);
        }];
        
        //质保期间
        _warrantyPeriodLabel = [[UILabel alloc]init];
//        _warrantyPeriodLabel.text = @"质保期间：1234657899";
        _warrantyPeriodLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_warrantyPeriodLabel];
        [_warrantyPeriodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX).offset(15);
            make.top.equalTo(_construcationProjectLabel.mas_bottom).offset(0);
            make.height.mas_offset(30);
            make.right.equalTo(self);
        }];
        
        
        
        
        _buttonBaseView = [[UIView alloc]init];
        _buttonBaseView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
        [self addSubview:_buttonBaseView];
        [_buttonBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self);
            make.height.mas_offset(60);
        }];
        
        _detailButton = [[UIButton alloc]init];
        [_detailButton setTitle:@"查看详情" forState:UIControlStateNormal];
        [_detailButton setTitle:@"关闭详情" forState:UIControlStateSelected];
        _detailButton.imageEdgeInsets = UIEdgeInsetsMake(0, 100, 0, 0);
        _detailButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_detailButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _detailButton.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
        [_buttonBaseView addSubview:_detailButton];
        [_detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.buttonBaseView);
            make.right.equalTo(self.buttonBaseView.mas_centerX);
            make.height.mas_offset(45);
        }];
        
        
        _buttonImageView = [[UIImageView alloc]init];
        _buttonImageView.image = [UIImage imageNamed:@"tc_gbxq_btn"];
        [_detailButton addSubview:_buttonImageView];
        [_buttonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_detailButton);
            make.left.equalTo(_detailButton.mas_centerX).offset(50);
            make.width.mas_offset(11);
            make.height.mas_offset(11);
        }];
        
        
        
        
        
        
        
        _addButton = [[UIButton alloc]init];
        [_addButton setTitle:@"添加至我的套餐" forState:UIControlStateNormal];
        _addButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_addButton setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
        _addButton.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
        [_buttonBaseView addSubview:_addButton];
        [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.equalTo(self.buttonBaseView);
            make.left.equalTo(self.buttonBaseView.mas_centerX);
            make.height.mas_offset(45);
        }];
        
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
        [_buttonBaseView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.buttonBaseView);
            make.top.equalTo(self.buttonBaseView);
            make.width.mas_offset(1);
            make.height.mas_offset(45);
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
