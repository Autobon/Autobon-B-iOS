//
//  CLPersonTableViewCell.h
//  CarMap
//
//  Created by 李孟龙 on 16/2/26.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLAddPersonModel;

@interface CLPersonTableViewCell : UITableViewCell

@property (nonatomic ,strong) UIImageView *headImage;
@property (nonatomic ,strong) UILabel *userNameLabel;
@property (nonatomic ,strong) UILabel *identityLabel;
@property (nonatomic ,strong) UIButton *button;
@property (nonatomic, strong) UIButton *zhipaiBut;
@property (nonatomic, strong) CLAddPersonModel *model;

- (void)setCell2;



@end
