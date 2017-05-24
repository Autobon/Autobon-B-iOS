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


@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *danshuLab;
@property (nonatomic, strong) UIButton *jvliBut;
@property (nonatomic, strong) UIImageView *jvliImgView;
@property (nonatomic, strong) UILabel *jvliLab;
@property (nonatomic, strong) UILabel *gereLab;
@property (nonatomic, strong) UILabel *gaiseLab;
@property (nonatomic, strong) UILabel *cheyiLab;
@property (nonatomic, strong) UILabel *meirongLab;

- (void)setCell2;



@end
