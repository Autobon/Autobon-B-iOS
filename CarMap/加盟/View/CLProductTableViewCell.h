//
//  CLProductTableViewCell.h
//  CarMapB
//
//  Created by inCarL on 2019/9/25.
//  Copyright © 2019 mll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLProductModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface CLProductTableViewCell : UITableViewCell


@property (nonatomic, strong) UILabel *numberLabel;     //编码
@property (nonatomic, strong) UILabel *typeLabel;     //型号
@property (nonatomic, strong) UILabel *brandLabel;     //品牌
@property (nonatomic, strong) UILabel *construcationProjectLabel;     //施工项目
@property (nonatomic, strong) UILabel *constructionLocationLabel;     //施工部位
@property (nonatomic, strong) UILabel *workHourLabel;     //工时
@property (nonatomic, strong) UILabel *warrantyPeriodLabel;     //质保期间






@property (nonatomic, strong) UIButton *detailButton;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIImageView *buttonImageView;

@property (nonatomic, strong) CLProductModel *productModel;


@end

NS_ASSUME_NONNULL_END
