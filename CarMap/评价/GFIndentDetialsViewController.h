//
//  GFIndentDetialsViewController.h
//  车邻邦客户端
//
//  Created by 陈光法 on 16/3/3.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GFIndentModel.h"



@interface GFIndentDetialsViewController : UIViewController

@property (nonatomic ,strong) GFIndentModel *model;

@property (nonatomic, copy) NSString *itemStr;

@end
