//
//  CLProductSelectTableViewCell.h
//  CarMapB
//
//  Created by inCarL on 2019/12/24.
//  Copyright © 2019 mll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLProductModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CLProductSelectTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *typeLabel;     //型号
@property (nonatomic, strong) UILabel *brandLabel;     //品牌
@property (nonatomic, strong) UILabel *construcationProjectLabel;     //施工项目
@property (nonatomic, strong) UILabel *constructionLocationLabel;     //施工部位
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *selectButton;



@property (nonatomic, strong) CLProductModel *productModel;


@end

NS_ASSUME_NONNULL_END
