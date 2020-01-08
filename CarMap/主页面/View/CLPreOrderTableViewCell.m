//
//  CLPreOrderTableViewCell.m
//  CarMapB
//
//  Created by inCarL on 2020/1/7.
//  Copyright © 2020 mll. All rights reserved.
//

#import "CLPreOrderTableViewCell.h"

@implementation CLPreOrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.backgroundColor = [UIColor clearColor];
        
        UIView *baseView = [[UIView alloc]init];
        baseView.backgroundColor = [UIColor whiteColor];
        [self addSubview:baseView];
        [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.top.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.bottom.equalTo(self);
        }];
        
        // 车架号
        UILabel *vinTitleLabel = [[UILabel alloc]init];
        vinTitleLabel.text = @"车架号：";
        vinTitleLabel.alpha = 0.8;
        vinTitleLabel.font = [UIFont systemFontOfSize:13];
        [baseView addSubview:vinTitleLabel];
        [vinTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(baseView).offset(15);
            make.top.equalTo(baseView).offset(15);
            make.height.mas_offset(20);
        }];
        
        _vinValueLabel = [[UILabel alloc]init];
        _vinValueLabel.text = @"SE123654894321";
        _vinValueLabel.alpha = 0.8;
        _vinValueLabel.font = [UIFont systemFontOfSize:13];
        [baseView addSubview:_vinValueLabel];
        [_vinValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(vinTitleLabel.mas_right).offset(5);
            make.centerY.equalTo(vinTitleLabel).offset(0);
            make.height.mas_offset(20);
        }];
        
        // 车牌号
        UILabel *licneseTitleLabel = [[UILabel alloc]init];
        licneseTitleLabel.text = @"车牌号：";
        licneseTitleLabel.alpha = 0.8;
        licneseTitleLabel.font = [UIFont systemFontOfSize:13];
        [baseView addSubview:licneseTitleLabel];
        [licneseTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(baseView).offset(15);
            make.top.equalTo(vinTitleLabel.mas_bottom).offset(10);
            make.height.mas_offset(20);
        }];
        
        _licenseValueLabel = [[UILabel alloc]init];
        _licenseValueLabel.text = @"京A123456";
        _licenseValueLabel.alpha = 0.8;
        _licenseValueLabel.font = [UIFont systemFontOfSize:13];
        [baseView addSubview:_licenseValueLabel];
        [_licenseValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(vinTitleLabel.mas_right).offset(5);
            make.centerY.equalTo(licneseTitleLabel).offset(0);
            make.height.mas_offset(20);
        }];
        
        // 车型
        UILabel *carModelTitleLabel = [[UILabel alloc]init];
        carModelTitleLabel.text = @"车    型：";
        carModelTitleLabel.alpha = 0.8;
        carModelTitleLabel.font = [UIFont systemFontOfSize:13];
        [baseView addSubview:carModelTitleLabel];
        [carModelTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(baseView).offset(15);
            make.top.equalTo(licneseTitleLabel.mas_bottom).offset(10);
            make.height.mas_offset(20);
        }];
        
        _carModelValueLabel = [[UILabel alloc]init];
        _carModelValueLabel.text = @"奥迪A6";
        _carModelValueLabel.alpha = 0.8;
        _carModelValueLabel.font = [UIFont systemFontOfSize:13];
        [baseView addSubview:_carModelValueLabel];
        [_carModelValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(vinTitleLabel.mas_right).offset(5);
            make.centerY.equalTo(carModelTitleLabel).offset(0);
            make.height.mas_offset(20);
        }];
        
        // 预约时间
        UILabel *beginTimeTitleLabel = [[UILabel alloc]init];
        beginTimeTitleLabel.text = @"预约时间：";
        beginTimeTitleLabel.alpha = 0.8;
        beginTimeTitleLabel.font = [UIFont systemFontOfSize:13];
        [baseView addSubview:beginTimeTitleLabel];
        [beginTimeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(baseView).offset(15);
            make.top.equalTo(carModelTitleLabel.mas_bottom).offset(10);
            make.height.mas_offset(20);
        }];
        
        _beginTimeValueLabel = [[UILabel alloc]init];
        _beginTimeValueLabel.text = @"2019-12-10 12:30";
        _beginTimeValueLabel.alpha = 0.8;
        _beginTimeValueLabel.font = [UIFont systemFontOfSize:13];
        [baseView addSubview:_beginTimeValueLabel];
        [_beginTimeValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(vinTitleLabel.mas_right).offset(5);
            make.centerY.equalTo(beginTimeTitleLabel).offset(0);
            make.height.mas_offset(20);
        }];
        
        _orderButton = [[UIButton alloc]init];
        _orderButton.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        [_orderButton setTitle:@"去下订单" forState:UIControlStateNormal];
        _orderButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _orderButton.layer.cornerRadius = 15;
        [baseView addSubview:_orderButton];
        [_orderButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(baseView).offset(-10);
            make.top.equalTo(beginTimeTitleLabel.mas_bottom).offset(10);
            make.height.mas_offset(30);
            make.width.mas_offset(90);
        }];
        
        _deleteButton = [[UIButton alloc]init];
        _deleteButton.backgroundColor = [UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1];
        [_deleteButton setTitle:@"删除订单" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0] forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _deleteButton.layer.cornerRadius = 15;
        [baseView addSubview:_deleteButton];
        [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_orderButton.mas_left).offset(-20);
            make.top.equalTo(beginTimeTitleLabel.mas_bottom).offset(10);
            make.height.mas_offset(30);
            make.width.mas_offset(90);
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
