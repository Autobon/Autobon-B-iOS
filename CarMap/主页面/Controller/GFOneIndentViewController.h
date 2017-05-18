//
//  GFOneIndentViewController.h
//  车邻邦客户端
//
//  Created by 陈光法 on 16/3/10.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLTouchScrollView.h"

@interface GFOneIndentViewController : UIViewController


//- (void)getListUnfinished;

// 灰色提示条
@property (nonatomic, strong) UIButton *tipButton;
@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, strong) CLTouchScrollView *scrollerView;

@end
