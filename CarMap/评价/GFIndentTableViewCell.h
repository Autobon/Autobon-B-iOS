//
//  GFIndentTableViewCell.h
//  CarMap
//
//  Created by 陈光法 on 16/2/25.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GFNewIndentModel;


@interface GFIndentTableViewCell : UITableViewCell


@property (nonatomic, strong) UILabel *numberLab;
@property (nonatomic, strong) UIImageView *photoImgView;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UIButton *pingjiaBut;
@property (nonatomic, strong) UILabel *yuyueTimeLab;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong) GFNewIndentModel *model;


@end
