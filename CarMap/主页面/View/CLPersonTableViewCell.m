//
//  CLPersonTableViewCell.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/26.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLPersonTableViewCell.h"
#import "CLAddPersonModel.h"
#import "GFHttpTool.h"

@interface CLPersonTableViewCell() {
    
//    UILabel *_nameLab;
//    UILabel *_danshuLab;
//    UIButton *_zhipaiBut;
//    UILabel *_gereLab;
//    UILabel *_gaiseLab;
//    UILabel *_cheyiLab;
//    UILabel *_meirongLab;
}

@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *danshuLab;
@property (nonatomic, strong) UIButton *jvliBut;
@property (nonatomic, strong) UIImageView *jvliImgView;
@property (nonatomic, strong) UILabel *jvliLab;
@property (nonatomic, strong) UILabel *gereLab;
@property (nonatomic, strong) UILabel *gaiseLab;
@property (nonatomic, strong) UILabel *cheyiLab;
@property (nonatomic, strong) UILabel *meirongLab;




@end

@implementation CLPersonTableViewCell


- (void)setModel:(CLAddPersonModel *)model {

    _model = model;
    
    self.nameLab.text = model.name;
    self.danshuLab.text = [NSString stringWithFormat:@"%@单", model.orderCount];
    self.gereLab.text = [NSString stringWithFormat:@"隔热膜：%@星", model.filmLevel];
    self.gaiseLab.text = [NSString stringWithFormat:@"车身改色：%@星", model.colorModifyLevel];
    self.cheyiLab.text = [NSString stringWithFormat:@"隐形车衣：%@星", model.carCoverLevel];
    self.meirongLab.text = [NSString stringWithFormat:@"美容清洁：%@星", model.beautyLevel];
    self.jvliLab.text = [NSString stringWithFormat:@"%.2f km", [model.distance floatValue]];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self != nil) {
    
        self.backgroundColor = [UIColor grayColor];
        
        UIView *vv = [[UIView alloc] init];
        vv.backgroundColor = [UIColor whiteColor];
        vv.frame = CGRectMake(-1, 5, [UIScreen mainScreen].bounds.size.width + 2, 120);
        vv.layer.borderColor = [[UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1] CGColor];
        vv.layer.borderWidth = 1;
        [self.contentView addSubview:vv];
        
        
        // 姓名
        _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(5, 8, 60, 30)];
        _nameLab.font = [UIFont systemFontOfSize:18];
        [vv addSubview:_nameLab];
        
        // 订单数
        _danshuLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_nameLab.frame), 13, 50, 20)];
        _danshuLab.textColor = [UIColor whiteColor];
        _danshuLab.textAlignment = NSTextAlignmentCenter;
        _danshuLab.font = [UIFont systemFontOfSize:13.5];
        _danshuLab.backgroundColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:235/ 255.0 alpha:1];
        _danshuLab.layer.cornerRadius = 4;
        [vv addSubview:_danshuLab];
        
        // 距离
        _jvliImgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_danshuLab.frame) + 10, 13, 15, 20)];
        _jvliImgView.contentMode = UIViewContentModeScaleAspectFit;
        _jvliImgView.image = [UIImage imageNamed:@"distance"];
        [vv addSubview:_jvliImgView];
        _jvliLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_jvliImgView.frame) + 5, 13, 120, 20)];
        _jvliLab.font = [UIFont systemFontOfSize:14];
        _jvliLab.textColor = [UIColor darkGrayColor];
        [vv addSubview:_jvliLab];
        
        // 指派按钮
        _zhipaiBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _zhipaiBut.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 10, 50, 30);
        [_zhipaiBut setTitle:@"指派" forState:UIControlStateNormal];
        [_zhipaiBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
        _zhipaiBut.layer.borderWidth = 1;
        _zhipaiBut.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
        _zhipaiBut.layer.cornerRadius = 3;
        _zhipaiBut.titleLabel.font = [UIFont systemFontOfSize:16];
        [_zhipaiBut addTarget:self action:@selector(zhipaiButClick:) forControlEvents:UIControlEventTouchUpInside];
        [vv addSubview:_zhipaiBut];
        
        // 隔热层
        _gereLab = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_nameLab.frame) + 13, [UIScreen mainScreen].bounds.size.width / 2.0 - 20, 25)];
        _gereLab.font = [UIFont systemFontOfSize:14];
        _gereLab.textColor = [UIColor darkGrayColor];
        [vv addSubview:_gereLab];
        
        // 车身改色
        _gaiseLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_gereLab.frame) + 10, _gereLab.frame.origin.y, [UIScreen mainScreen].bounds.size.width / 2.0 - 20, 25)];
        _gaiseLab.font = [UIFont systemFontOfSize:14];
        _gaiseLab.textAlignment = NSTextAlignmentRight;
        _gaiseLab.textColor = [UIColor darkGrayColor];
        [vv addSubview:_gaiseLab];
        
        // 隐形车衣
        _cheyiLab = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_gereLab.frame) + 5, [UIScreen mainScreen].bounds.size.width / 2.0 - 20, 25)];
        _cheyiLab.font = [UIFont systemFontOfSize:14];
        _cheyiLab.textColor = [UIColor darkGrayColor];
        [vv addSubview:_cheyiLab];
        
        // 美容清洁
        _meirongLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_cheyiLab.frame) + 10, _cheyiLab.frame.origin.y, [UIScreen mainScreen].bounds.size.width / 2.0 - 20, 25)];
        _meirongLab.textAlignment = NSTextAlignmentRight;
        _meirongLab.font = [UIFont systemFontOfSize:14];
        _meirongLab.textColor = [UIColor darkGrayColor];
        [vv addSubview:_meirongLab];
    }
    
    return self;
}

- (void)zhipaiButClick:(UIButton *)sender {
    
//    NSLog(@"===%@", _model.distance);
    
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    mDic[@"orderId"] = _model.orderID;
    mDic[@"techId"] = _model.jishiID;
    
    [GFHttpTool postAppintTechForOrder:mDic Success:^(id responseObject) {
        
//        NSLog(@"指派技师返回的数据＝＝＝＝%@", responseObject);
        if([responseObject[@"status"] integerValue] == 1) {
        
            [[self viewController].navigationController popToRootViewControllerAnimated:YES];
        }
        
    } failure:^(NSError *error) {
        
        
    }];
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

- (void)setCell2 {
    
    self.backgroundColor = [UIColor whiteColor];
    
    // 姓名
    _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 30)];
    [self.contentView addSubview:_nameLab];
    
    // 订单数
    _danshuLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_nameLab.frame), 10, 50, 25)];
    _danshuLab.backgroundColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:235/ 255.0 alpha:1];
    [self.contentView addSubview:_danshuLab];
    
    // 指派按钮
    _zhipaiBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _zhipaiBut.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 10, 50, 30);
    [_zhipaiBut setTitle:@"指派" forState:UIControlStateNormal];
    [_zhipaiBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
    _zhipaiBut.layer.borderWidth = 1;
    _zhipaiBut.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
    _zhipaiBut.layer.cornerRadius = 3;
    [self.contentView addSubview:_zhipaiBut];
    
    // 隔热层
    _gereLab = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_nameLab.frame) + 5, [UIScreen mainScreen].bounds.size.width / 2.0 - 20, 30)];
    _gereLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_gereLab];
    
    // 车身改色
    _gaiseLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_gereLab.frame), _gereLab.frame.origin.y, [UIScreen mainScreen].bounds.size.width / 2.0 - 20, 30)];
    _gaiseLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_gaiseLab];
    
    // 隐形车衣
    _cheyiLab = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_gereLab.frame) + 5, [UIScreen mainScreen].bounds.size.width / 2.0 - 20, 30)];
    _cheyiLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_cheyiLab];
    
    // 美容清洁
    _meirongLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_cheyiLab.frame), _cheyiLab.frame.origin.y, [UIScreen mainScreen].bounds.size.width / 2.0 - 20, 30)];
    _meirongLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_meirongLab];
    
}

- (void)setCell{
    
//头像
    _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(25, 10, 80, 80)];
    _headImage.image = [UIImage imageNamed:@"userHeadImage"];
    _headImage.layer.cornerRadius = 40;
    _headImage.clipsToBounds = YES;
    [self addSubview:_headImage];
    
    
    _userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, 200, 40)];
//    _userNameLabel.text = @"林峰";
    _userNameLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
    [self addSubview:_userNameLabel];
    
   _identityLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 50, 120, 40)];
//    _identityLabel.text = @"15836163101";
    _identityLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
    [self addSubview:_identityLabel];
    
    _button = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-80, 35, 60, 30)];
    [_button setTitle:@"确定" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
    _button.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
    _button.layer.borderWidth = 1.0f;
    _button.layer.cornerRadius = 10;
    
    [self addSubview:_button];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 98, [UIScreen mainScreen].bounds.size.width, 2)];
    lineView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [self addSubview:lineView];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
