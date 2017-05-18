//
//  GFNoInTableViewCell.m
//  CarMapB
//
//  Created by 陈光法 on 16/11/23.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFNoInTableViewCell.h"
#import "GFNoIndentModel.h"
#import "CLAddPersonViewController.h"
#import "GFHttpTool.h"
#import "GFNoIndentViewController.h"
#import "MJRefresh.h"
#import "GFTipView.h"

@interface GFNoInTableViewCell()

@property (nonatomic, strong) UILabel *bianhaoLab;
@property (nonatomic, strong) UILabel *proLab;
@property (nonatomic, strong) UIButton *zhipaiBut;
@property (nonatomic, strong) UIButton *chedanBut;
@property (nonatomic, strong) UILabel *statusLab;

@end


@implementation GFNoInTableViewCell

- (void)setModel:(GFNoIndentModel *)model {

    _model = model;
    
    self.bianhaoLab.text = [NSString stringWithFormat:@"订单编号：%@", model.orderNum];
    self.proLab.text = model.typeName;
    self.statusLab.text = model.statusName;
    
    if([model.statusName isEqualToString:@"已接单"]) {
    
        self.statusLab.textColor = [UIColor darkGrayColor];
        self.zhipaiBut.hidden = YES;
        self.jishi = @"有";
        self.zhipian = @"无";
    }else if([model.statusName isEqualToString:@"待指派"]) {
    
        self.statusLab.textColor = [UIColor lightGrayColor];
        self.zhipaiBut.hidden = NO;
        self.jishi = @"无";
        self.zhipian = @"有";
    }else if([model.statusName isEqualToString:@"已出发"]) {
        
        self.statusLab.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        self.zhipaiBut.hidden = YES;
        self.jishi = @"有";
        self.zhipian = @"无";
    }else if([model.statusName isEqualToString:@"已签到"]) {
        
        self.statusLab.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        self.zhipaiBut.hidden = YES;
        self.jishi = @"有";
        self.zhipian = @"无";
    }else if([model.statusName isEqualToString:@"施工中"]) {
        
        self.statusLab.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        self.zhipaiBut.hidden = YES;
        self.jishi = @"有";
        self.zhipian = @"无";
    }else {
    
        self.statusLab.textColor = [UIColor lightGrayColor];
        self.zhipaiBut.hidden = YES;
        self.jishi = @"无";
        self.zhipian = @"无";
    }
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self != nil) {
        
        self.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];;
    
        UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(-1, 7, [UIScreen mainScreen].bounds.size.width + 2, 85)];
        vv.backgroundColor = [UIColor whiteColor];
        vv.layer.borderColor = [[UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1] CGColor];
        vv.layer.borderWidth = 1;
        [self.contentView addSubview:vv];
        
//        UIImageView *ii = [[UIImageView alloc] initWithFrame:CGRectMake(5, 15, 20, 20)];
//        ii.image = [UIImage imageNamed:@"tishi"];
//        [vv addSubview:ii];
        
        // 订单编号
        self.bianhaoLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 30)];
        self.bianhaoLab.text = @"我就不信这么多字还满足不了";
        self.bianhaoLab.font = [UIFont boldSystemFontOfSize:13];
        self.bianhaoLab.textColor = [UIColor darkGrayColor];
        [vv addSubview:self.bianhaoLab];
        
        
        
        // 撤单按钮
        self.chedanBut = [UIButton buttonWithType:UIButtonTypeCustom];
        self.chedanBut.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 5 - 50, self.bianhaoLab.frame.origin.y, 50, 30);
        [self.chedanBut setTitle:@"撤单" forState:UIControlStateNormal];
        self.chedanBut.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.chedanBut setTitleColor:[UIColor colorWithRed:88 / 255.0 green:88 / 255.0 blue:88 / 255.0 alpha:1] forState:UIControlStateNormal];
        self.chedanBut.layer.cornerRadius = 5;
        self.chedanBut.layer.borderWidth = 1;
        self.chedanBut.layer.borderColor = [[UIColor colorWithRed:153.0 / 255.0 green:153.0 / 255.0 blue:153.0 / 255.0 alpha:1] CGColor];;
        [vv addSubview:self.chedanBut];
        [self.chedanBut addTarget:self action:@selector(chedanButClick) forControlEvents:UIControlEventTouchUpInside];
        
        // 指定技师
        self.zhipaiBut = [UIButton buttonWithType:UIButtonTypeCustom];
        self.zhipaiBut.frame = CGRectMake(CGRectGetMinX(self.chedanBut.frame) - 5 - 60, self.bianhaoLab.frame.origin.y, 60, 30);
        self.zhipaiBut.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        [self.zhipaiBut setTitle:@"指定技师" forState:UIControlStateNormal];
        self.zhipaiBut.layer.cornerRadius = 5;
        self.zhipaiBut.titleLabel.font = [UIFont systemFontOfSize:13];
        [vv addSubview:self.zhipaiBut];
        [self.zhipaiBut addTarget:self action:@selector(zhipaiButClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // 施工项目
        self.proLab = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.bianhaoLab.frame) + 5, 250, 30)];
        self.proLab.textColor = [UIColor grayColor];
        self.proLab.font = [UIFont systemFontOfSize:12];
        self.proLab.text = @"隔热膜，隐形车衣，美容清洁，车身改色";
        [vv addSubview:self.proLab];
        
        // 订单状态
        self.statusLab = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 5 - 75, self.proLab.frame.origin.y, 75, 30)];
        self.statusLab.font = [UIFont systemFontOfSize:14];
        self.statusLab.textAlignment = NSTextAlignmentRight;
        self.statusLab.text = @"给你五个字";
        self.statusLab.textColor = [UIColor lightGrayColor];
        self.statusLab.highlightedTextColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        [vv addSubview:self.statusLab];
    }
    
    return self;
}

- (void)chedanButClick {
    
    if(![_model.statusName isEqualToString:@"已出发"] && ![_model.statusName isEqualToString:@"已签到"] && ![_model.statusName isEqualToString:@"施工中"]) {
        
        UIAlertView *aView = [[UIAlertView alloc] initWithTitle:@"注意" message:@"确定删除该订单！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [[self viewController].view addSubview:aView];
        aView.delegate = self;
        [aView show];
    }else {
    
        UIAlertView *aView = [[UIAlertView alloc] initWithTitle:@"注意" message:@"已开始施工的订单不可撤销" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [[self viewController].view addSubview:aView];
        [aView show];
    }
    

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonInde {
    
//    NSLog(@"=====++++=%ld===", buttonInde);
    if(buttonInde == 1) {
    
        [GFHttpTool postCanceledOrder:self.model.orderID Success:^(id responseObject) {
    
//            NSLog(@"==撤单返回的信息==%@", responseObject);
            
            if([responseObject[@"status"] integerValue] == 1) {
                
                GFNoIndentViewController *vc = (GFNoIndentViewController *)[self viewController];
                [vc.tableView.header beginRefreshing];
                [self tipShow:@"撤单成功"];
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"FINISHED" object:self userInfo:nil];
            }else {
                
                if([responseObject[@"message"] isKindOfClass:[NSNull class]]) {
                
                    [self tipShow:@"撤单失败！"];
                }else {
                    
                    [self tipShow:responseObject[@"message"]];
                }
            }
    
        } failure:^(NSError *error) {
            
            
        }];
    }
}

- (void)tipShow:(NSString *)string{
    
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:string withShowTimw:2.5];
    [tipView tipViewShow];
    
}

- (void)zhipaiButClick:(UIButton *)sender {
    
    CLAddPersonViewController *vc = [[CLAddPersonViewController alloc] init];
    vc.orderId = self.model.orderID;
    [[self viewController].navigationController pushViewController:vc animated:YES];
}
//获取view的controller
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
