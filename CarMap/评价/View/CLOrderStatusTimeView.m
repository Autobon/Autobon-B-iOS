//
//  CLOrderStatusTimeView.m
//  CarMapB
//
//  Created by inCar on 2018/6/15.
//  Copyright © 2018年 mll. All rights reserved.
//

#import "CLOrderStatusTimeView.h"
#import "Masonry.h"
#import "CLOrderStatusTimeModel.h"


@implementation CLOrderStatusTimeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)setDetailForOrderStatusWithDataArray:(NSArray *)dataArray{
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    
    UIView *baseView = [[UIView alloc]init];
    baseView.backgroundColor = [UIColor whiteColor];
    baseView.layer.cornerRadius = 15;
    baseView.layer.borderWidth = 0.5;
    baseView.layer.borderColor = [UIColor blackColor].CGColor;
    [self addSubview:baseView];
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_offset(280);
        make.height.mas_offset(360);
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"订单施工时间详情";
    titleLabel.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [baseView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(baseView);
        make.top.equalTo(baseView).offset(15);
        make.height.mas_offset(20);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor darkTextColor];
    [baseView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(50);
        make.left.equalTo(baseView).offset(49);
        make.width.mas_offset(1);
        make.height.mas_offset(240);
    }];
    
    UIView *lineView2 = [[UIView alloc]init];
    lineView2.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [baseView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(50);
        make.left.equalTo(baseView).offset(49);
        make.width.mas_offset(1);
        if (dataArray.count > 6){
            make.height.mas_offset(50 * 5);
        }else if (dataArray.count == 0){
            make.height.mas_offset(50 * 0);
        }else{
            make.height.mas_offset(50 * (dataArray.count - 1));
        }
        
        ICLog(@"--height--%ld----",50 * (dataArray.count - 1));
        
    }];
    
    
    
    NSArray *titleArray = @[@"未接单",@"已接单",@"已出发",@"已签到",@"施工中",@"已完成"];
    for (int i = 0; i < 6; i++) {
        UILabel *label = [[UILabel alloc]init];
        label.text = titleArray[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        label.backgroundColor = [UIColor whiteColor];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(baseView).offset(25);
            make.top.equalTo(titleLabel.mas_bottom).offset(30 + i * 50);
            make.width.mas_offset(50);
            make.height.mas_offset(20);
        }];
        
        if(i < dataArray.count){
            label.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        }
    }
    
    for (int i = 0; i < 5; i++) {
        UILabel *label = [[UILabel alloc]init];
        label.text = [NSString stringWithFormat:@"用时 00时 00钟 00秒"];
        label.font = [UIFont systemFontOfSize:14];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(baseView).offset(80);
            make.top.equalTo(titleLabel.mas_bottom).offset(30 + i*50 + 25);
            make.width.mas_offset(200);
            make.height.mas_offset(20);
        }];
        
        if(i + 1 < dataArray.count){
            CLOrderStatusTimeModel *firstModel = dataArray[i];
            CLOrderStatusTimeModel *secondModel = dataArray[i + 1];
            NSInteger time = secondModel.recordTime - firstModel.recordTime;
            label.text = [NSString stringWithFormat:@"用时 %02ld时 %02ld钟 %02ld秒",time/3600,(time%3600)/60,(time%3600)%60];
            
        }
        
    }
    
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}


@end
