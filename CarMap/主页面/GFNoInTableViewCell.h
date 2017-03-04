//
//  GFNoInTableViewCell.h
//  CarMapB
//
//  Created by 陈光法 on 16/11/23.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GFNoIndentModel;
@interface GFNoInTableViewCell : UITableViewCell


@property (nonatomic, strong) GFNoIndentModel *model;




@property (nonatomic, copy) NSString *jishi;
@property (nonatomic, copy) NSString *zhipian;


@end
