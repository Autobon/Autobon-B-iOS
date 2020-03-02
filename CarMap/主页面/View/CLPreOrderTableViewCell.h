//
//  CLPreOrderTableViewCell.h
//  CarMapB
//
//  Created by inCarL on 2020/1/7.
//  Copyright © 2020 mll. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLPreOrderTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *vinValueLabel;
@property (nonatomic, strong) UILabel *licenseValueLabel;
@property (nonatomic, strong) UILabel *carModelValueLabel;
@property (nonatomic, strong) UILabel *beginTimeValueLabel;
@property (nonatomic, strong) UIButton *orderButton;
@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, strong) UIButton *deleteButton;

@end

NS_ASSUME_NONNULL_END
