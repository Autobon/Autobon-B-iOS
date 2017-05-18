//
//  GFNoIndentViewController.h
//  车邻邦客户端
//
//  Created by 陈光法 on 16/3/10.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFNoIndentViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic ,strong) NSMutableArray *modelMutableArray;
@property (nonatomic, strong) UITableView *tableView;

- (void)httpWork;
@end
