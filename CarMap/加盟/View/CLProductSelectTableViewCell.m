//
//  CLProductSelectTableViewCell.m
//  CarMapB
//
//  Created by inCarL on 2019/12/24.
//  Copyright © 2019 mll. All rights reserved.
//

#import "CLProductSelectTableViewCell.h"

@implementation CLProductSelectTableViewCell



- (void)setProductModel:(CLProductModel *)productModel{
    _productModel = productModel;
    _priceLabel.text = [NSString stringWithFormat:@"¥%@(元)",self.productModel.price];
    self.typeLabel.text = [NSString stringWithFormat:@"型号：%@", self.productModel.model];
    self.brandLabel.text = [NSString stringWithFormat:@"品牌：%@", self.productModel.brand];
    self.construcationProjectLabel.text = [NSString stringWithFormat:@"施工项目：%@", self.productModel.typeName];
    self.constructionLocationLabel.text = [NSString stringWithFormat:@"施工部位：%@", self.productModel.constructionPositionName];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.clipsToBounds = YES;
        
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        _priceLabel.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.top.equalTo(self).offset(5);
            make.height.mas_offset(30);
        }];
        
        //施工项目
        _construcationProjectLabel = [[UILabel alloc] init];
        //        _construcationProjectLabel.text = @"施工项目：1234657899";
        _construcationProjectLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_construcationProjectLabel];
        [_construcationProjectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(120);
            make.height.mas_offset(30);
            make.top.equalTo(self).offset(5);
        }];
        
        //施工部位
        _constructionLocationLabel = [[UILabel alloc] init];
        //        _constructionLocationLabel.text = @"施工部位：1234657899";
        _constructionLocationLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_constructionLocationLabel];
        [_constructionLocationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(120);
            make.height.mas_offset(30);
            make.top.equalTo(_construcationProjectLabel.mas_bottom).offset(0);
        }];
        
        //型号
        _typeLabel = [[UILabel alloc] init];
        //        _typeLabel.text = @"型号：1234657899";
        _typeLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_typeLabel];
        [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(120);
            make.height.mas_offset(30);
            make.top.equalTo(_constructionLocationLabel.mas_bottom).offset(0);
        }];
        
        //品牌
        _brandLabel = [[UILabel alloc] init];
        //        _brandLabel.text = @"品牌：1234657899";
        _brandLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_brandLabel];
        [_brandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(120);
            make.height.mas_offset(30);
            make.top.equalTo(_typeLabel.mas_bottom).offset(0);
        }];
        
        
        
        _selectButton = [[UIButton alloc]init];
        [_selectButton setImage:[UIImage imageNamed:@"over"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"overClick"] forState:UIControlStateSelected];
        _selectButton.userInteractionEnabled = NO;
        [self addSubview:_selectButton];
        [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-20);
            make.centerY.equalTo(self);
            make.width.mas_offset(40);
            make.height.mas_offset(40);
        }];
        
        
        NSString *isMainString = [[NSUserDefaults standardUserDefaults] objectForKey:@"userIsMain"];
        if (![isMainString isEqualToString:@"1"]){
            _priceLabel.hidden = YES;
        }
        
        
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
