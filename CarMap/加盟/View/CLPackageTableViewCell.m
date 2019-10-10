//
//  CLPackageTableViewCell.m
//  CarMapB
//
//  Created by inCarL on 2019/10/9.
//  Copyright © 2019 mll. All rights reserved.
//

#import "CLPackageTableViewCell.h"

@implementation CLPackageTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _packageNameLabel = [[UILabel alloc]init];
        _packageNameLabel.font = [UIFont boldSystemFontOfSize:17];
        [self addSubview:_packageNameLabel];
        [_packageNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-60);
        }];
        
        
        _deleteButton = [[UIButton alloc]init];
        [_deleteButton setImage:[UIImage imageNamed:@"clb_tc_del"] forState:UIControlStateNormal];
        [self addSubview:_deleteButton];
        [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-15);
            make.width.mas_offset(40);
            make.height.mas_offset(40);
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
