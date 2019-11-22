//
//  CLPackageProductTableViewCell.h
//  CarMapB
//
//  Created by inCarL on 2019/9/26.
//  Copyright © 2019 mll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLProductModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface CLPackageProductTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton *removeButton;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *brandValueLabel;
@property (nonatomic, strong) UILabel *constructionPositionValueLabel;
@property (nonatomic, strong) UILabel *modelValueLabel;
@property (nonatomic, strong) UILabel *codeValueLabel;
@property (nonatomic, strong) UILabel *workHourValueLabel;
@property (nonatomic, strong) UILabel *warrantyPeriodValueLabel;







@property (nonatomic, strong) CLProductModel *productModel;

@end

NS_ASSUME_NONNULL_END
