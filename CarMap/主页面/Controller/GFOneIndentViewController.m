//
//  GFOneIndentViewController.m
//  车邻邦客户端
//
//  Created by 陈光法 on 16/3/10.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFOneIndentViewController.h"
#import "GFNavigationView.h"
#import "GFTextField.h"
#import "GFTitleView.h"
#import "GFPartnersMessageViewController.h"
#import "GFNoIndentViewController.h"
#import "UWDatePickerView.h"
#import "GFTipView.h"
#import "GFHttpTool.h"
#import "CLIndentModel.h"
#import "GFAlertView.h"
#import "CLAddPersonViewController.h"
#import "GFImageView.h"

#import "GFNoIndentViewController.h"




@interface GFOneIndentViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UWDatePickerViewDelegate> {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    CGFloat jiange1;
    CGFloat jiange2;
    CGFloat jiange3;
    
    
    CGFloat jianjv1;
    
    NSMutableArray *_buttonArray;
   
    UWDatePickerView *_pickerView;
    BOOL _isUpOrderImage;
    NSInteger _orderType;
//    NSMutableArray *_modelArray;
    
    
    CGFloat baseViewHH;
    
    NSMutableDictionary *_dataDictionary;
    
    UIButton *_appointButton;
    
    NSInteger _suo;
    
    GFNavigationView *_navView;
    
}

//@property (nonatomic, strong) GFNavigationView *navView;


// 施工项目
@property (nonatomic, strong) NSMutableArray *proIDArr;

// 订单信息
@property (nonatomic, strong) GFTitleView *msgView;
// 示例图
@property (nonatomic, strong) UIButton *imgView;
@property (nonatomic, strong) UIButton *cameraBtn;
@property (nonatomic, strong) NSMutableArray *photoUrlArr;
@property (nonatomic, strong) UIButton *addPhotoBut;
@property (nonatomic, assign) NSInteger photoIndex;
@property (nonatomic, strong) NSMutableArray *photoImgArr;
@property (nonatomic, strong) NSMutableArray *photoImgViewArr;
// 请填写备注
@property (nonatomic, strong) UITextView *txtView;
// 预约施工时间Lab
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, assign) NSInteger shijianNum;
// 最迟交车时间
@property (nonatomic, strong) UILabel *zuichiTimeLab;



@property (nonatomic, strong) UILabel *timeLab1;


@end

@implementation GFOneIndentViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _suo = 0;
    
    kWidth = [UIScreen mainScreen].bounds.size.width;
    kHeight = [UIScreen mainScreen].bounds.size.height;
    jiange1 = kHeight * 0.013;
    jiange2 = kHeight * 0.0365;
    jiange3 = kHeight * 0.0157;
    jianjv1 = kWidth * 0.0416;
    _dataDictionary = [[NSMutableDictionary alloc]init];
    
    self.proIDArr = [[NSMutableArray alloc] init];
    self.photoUrlArr = [[NSMutableArray alloc] init];
    self.photoImgArr = [[NSMutableArray alloc] init];
    self.photoImgViewArr = [[NSMutableArray alloc] init];
    self.photoIndex = 0;
    
    self.shijianNum = 1;
    
    // 基础设置
    [self _setBase];
    
    // 界面搭建
    [self _setView];
    
    
    [self NSNotificationCenter];
}

#pragma mark - 注册通知中心
- (void)NSNotificationCenter{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getListUnfinished) name:@"FINISHED" object:nil];
}

- (void)_setBase {
    
    
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    
    
    // 导航栏
    _navView = [[GFNavigationView alloc] initWithLeftImgName:@"person" withLeftImgHightName:@"personClick" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"车邻邦" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [_navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
    [self.view bringSubviewToFront:_navView];
    
    
}

#pragma mark - 获取商户未完成订单
- (void)getListUnfinished{
    
    [GFHttpTool dingdanPostWithDictionary:@{@"page":@"1",@"pageSize":@"1"} success:^(id responseObject) {
        
        
//        NSLog(@"------%@", responseObject);
        
        NSDictionary *dataDictionary = responseObject[@"message"];
        
        NSInteger ff = [dataDictionary[@"totalElements"] integerValue];
        if(ff > 0) {
            self.baseView.frame = CGRectMake(0, 0, kWidth, baseViewHH + kHeight * 0.0625);
            self.scrollerView.contentSize = CGSizeMake(0, baseViewHH + kHeight * 0.0625*2);
            [_tipButton setTitle:[NSString stringWithFormat:@"有%@个未完成订单",dataDictionary[@"totalElements"]] forState:UIControlStateNormal];
//            self.scrollerView.frame = CGRectMake(0, 64-20, kWidth, kHeight - 44);
            
            [self.scrollerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_navView.mas_bottom).offset(0);
            }];
            
            _tipButton.hidden = NO;
        }else {
            self.baseView.frame = CGRectMake(0, 0, kWidth, baseViewHH);
//            self.scrollerView.frame = CGRectMake(0, 64-_tipButton.frame.size.height - 20, kWidth, kHeight - 44+_tipButton.frame.size.height);
            self.scrollerView.contentSize = CGSizeMake(0, baseViewHH+50);
            _tipButton.hidden = YES;
            
            [self.scrollerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_navView.mas_bottom).offset(-50);
            }];
            
        }
    } failure:^(NSError *error) {
        
        
//        NSLog(@"------%@", error);
    }];
    
    /*
    [GFHttpTool postListUnfinishedDictionary:@{@"page":@"1",@"pageSize":@"1"} success:^(id responseObject) {
//        NSLog(@"－－请求成功－－%@--",responseObject);
        if ([responseObject[@"result"] integerValue] == 1) {
            NSDictionary *dataDictionary = responseObject[@"data"];
            
            NSInteger ff = [dataDictionary[@"totalElements"] integerValue];
            if(ff > 0) {
                self.baseView.frame = CGRectMake(0, 0, kWidth, baseViewHH + kHeight * 0.0625);
                self.scrollerView.contentSize = CGSizeMake(0, baseViewHH + kHeight * 0.0625*2);
                [_tipButton setTitle:[NSString stringWithFormat:@"有%@个未完成订单",dataDictionary[@"totalElements"]] forState:UIControlStateNormal];
                self.scrollerView.frame = CGRectMake(0, 64-20, kWidth, kHeight - 44);
                _tipButton.hidden = NO;
            }else {
                self.baseView.frame = CGRectMake(0, 0, kWidth, baseViewHH);
                self.scrollerView.frame = CGRectMake(0, 64-_tipButton.frame.size.height - 20, kWidth, kHeight - 44+_tipButton.frame.size.height);
                self.scrollerView.contentSize = CGSizeMake(0, baseViewHH+50);
                _tipButton.hidden = YES;
            }
            
            
//            NSArray *listArray = dataDictionary[@"list"];
//            NSArray *typeArray = @[@"隔热层",@"隐形车衣",@"车身改色",@"美容清洁"];
//            
//            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//            [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
//            
//            [listArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
//                CLIndentModel *model = [[CLIndentModel alloc]init];
//                model.orderId = obj[@"id"];
//                model.orderNum = [NSString stringWithFormat:@"订单编号：%@",obj[@"orderNum"]];
////                model.status = obj[@"status"];
//                NSInteger type = [obj[@"orderType"] integerValue] - 1;
//                model.orderType = typeArray[type];
//                NSDate *date = [NSDate dateWithTimeIntervalSince1970:[obj[@"orderTime"] floatValue]/1000];
//                model.orderTime = [NSString stringWithFormat:@"预约时间：%@",[formatter stringFromDate:date]];
//                
//                model.photo = obj[@"photo"];
//                model.remark = obj[@"remark"];
//            
//                date = [NSDate dateWithTimeIntervalSince1970:[obj[@"addTime"] floatValue]/1000];
//                model.addTime = [NSString stringWithFormat:@"下单时间：%@",[formatter stringFromDate:date]];
//                [_modelArray addObject:model];
//                if ([obj[@"mainTech"] isKindOfClass:[NSNull class]]) {
//                    model.workName = @"";
//                    model.status = @"未接单";
//                }else{
//                    NSDictionary *mainDictionary = obj[@"mainTech"];
//                    model.workName = mainDictionary[@"name"];
//                    model.status = @"已接单";
//                }
//            }];
        }
        
    } failure:^(NSError *error) {
//        NSLog(@"----shibaile---%@---",error);
//         [self addAlertView:@"请求失败"];
    }];
     */
}



- (void)_setView {
    
    [self getListUnfinished];
    
    self.scrollerView = [[CLTouchScrollView alloc] init];
    self.scrollerView.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    //    self.scrollerView.frame = CGRectMake(0, 64-kHeight * 0.0625-20, kWidth, kHeight - 44+kHeight * 0.0625);
//    self.scrollerView.frame = CGRectMake(0, 64, kWidth, kHeight - 44);
//    self.scrollerView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.scrollerView.contentSize = CGSizeMake(0, 1050);
    self.scrollerView.showsHorizontalScrollIndicator = NO;
    self.scrollerView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollerView];
    [self.view sendSubviewToBack:self.scrollerView];
    [self.scrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(_navView.mas_bottom);
    }];
    // 订单信息基础视图
    CGFloat baseViewW = kWidth;
    CGFloat baseViewH = 500;
    CGFloat baseViewX = 0;
    CGFloat baseViewY = 0;
    self.baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
    self.baseView.backgroundColor = [UIColor whiteColor];
    [self.scrollerView addSubview:self.baseView];
    
    // 灰色提示框
    CGFloat tipLabW = kWidth;
    CGFloat tipLabH = kHeight * 0.0625;
    CGFloat tipLabX = 0;
    CGFloat tipLabY = -tipLabH;
    self.tipButton = [[UIButton alloc] initWithFrame:CGRectMake(tipLabX, tipLabY+tipLabH, tipLabW, tipLabH)];
    self.tipButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.tipButton.titleLabel.font = [UIFont systemFontOfSize:11 / 320.0 * kWidth];
    [_scrollerView addSubview:self.tipButton];
    _tipButton.hidden = YES;
    [_tipButton addTarget:self action:@selector(tipBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    // 施工项目
    GFTitleView *projectView = [[GFTitleView alloc] initWithY:CGRectGetMaxY(self.tipButton.frame) + jiange1 Title:@"施工项目"];
    [self.baseView addSubview:projectView];
    
    // 施工项目按钮
    CGFloat butViewW = kWidth;
    CGFloat butViewH = kHeight * 0.099;;
    CGFloat butViewX = 0;
    CGFloat butViewY = CGRectGetMaxY(projectView.frame);
    UIView *butView = [[UIView alloc] initWithFrame:CGRectMake(butViewX, butViewY, butViewW, butViewH)];
    butView.backgroundColor = [UIColor whiteColor];
    [self.baseView addSubview:butView];
    NSArray *nameArr = @[@"隔热膜", @"隐形车衣", @"车身改色", @"美容清洁"];
    _buttonArray = [[NSMutableArray alloc]init];
    for(int i=0; i<4; i++) {
        [self.proIDArr addObject:@"0"];
        CGFloat butW = kWidth * 0.218;
        CGFloat butH = kHeight * 0.068;
        CGFloat butX = (kWidth - butW * 4) / 5.0 * (i + 1) + butW * i;
        CGFloat butY = (butViewH - butH) / 2.0;
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(butX, butY, butW, butH);
        [but setBackgroundColor:[UIColor colorWithRed:237 / 255.0 green:238 / 255.0 blue:239 / 255.0 alpha:1]];
        [but setTitle:nameArr[i] forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:13 /320.0 * kWidth];
        [but setTitleColor:[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        but.tag = i + 1;
        [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
        but.layer.cornerRadius = 17;
        [butView addSubview:but];
        [_buttonArray addObject:but];
    }
    
    // 边线
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(0, butViewH, kWidth, 1)];
    lineView4.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [butView addSubview:lineView4];
    
    
    // 订单信息
    self.msgView = [[GFTitleView alloc] initWithY:CGRectGetMaxY(butView.frame) + jiange1 Title:@"订单信息"];
    [self.baseView addSubview:self.msgView];

    // 示例图
    CGFloat imgViewW = kWidth - 4 * jianjv1;
    CGFloat imgViewH = kHeight * 0.24;
    CGFloat imgViewX = jianjv1*2;
    CGFloat imgViewY = CGRectGetMaxY(self.msgView.frame) + jiange2;
    self.imgView = [[UIButton alloc] initWithFrame:CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH)];
    [self.imgView setBackgroundImage:[UIImage imageNamed:@"orderImage"] forState:UIControlStateNormal];
    self.imgView.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.baseView addSubview:self.imgView];
    
    UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraBtn.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame)-15, CGRectGetMaxY(self.imgView.frame)-15, 30, 30);
    [cameraBtn setBackgroundImage:[UIImage imageNamed:@"cameraUser"] forState:UIControlStateNormal];
    [self.baseView addSubview:cameraBtn];
    self.cameraBtn = cameraBtn;
    
    self.addPhotoBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addPhotoBut.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 40) / 3.0 + 20, CGRectGetMaxY(self.msgView.frame) + 10, ([UIScreen mainScreen].bounds.size.width - 40) / 3.0, ([UIScreen mainScreen].bounds.size.width - 40) / 3.0);
    [self.baseView addSubview:self.addPhotoBut];
    self.addPhotoBut.hidden = YES;
    [self.addPhotoBut setImage:[UIImage imageNamed:@"addImage"] forState:UIControlStateNormal];
    self.addPhotoBut.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.addPhotoBut.layer.borderWidth = 1;
    
    [cameraBtn addTarget:self action:@selector(cameraBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.imgView addTarget:self action:@selector(cameraBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.addPhotoBut addTarget:self action:@selector(cameraBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    // 边线
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(jianjv1, CGRectGetMaxY(self.imgView.frame) + jiange2 + 40, kWidth - jianjv1 * 2, 1)];
    lineView1.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [self.baseView addSubview:lineView1];
    
    // 请填写备注
    CGFloat txtViewW = kWidth - jianjv1*2;
    CGFloat txtViewH = kHeight * 0.21;
    CGFloat txtViewX = jianjv1;
    CGFloat txtViewY = CGRectGetMaxY(lineView1.frame) + kHeight * 0.024;
    self.txtView = [[UITextView alloc] initWithFrame:CGRectMake(txtViewX, txtViewY, txtViewW, txtViewH)];
    self.txtView.text = @"订单备注(请填写本车提成，最多200字)";
    self.txtView.textColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
    self.txtView.delegate = self;
    [self.baseView addSubview:self.txtView];
    
    self.baseView.frame = CGRectMake(baseViewX, baseViewY, baseViewW, CGRectGetMaxY(self.txtView.frame) + 20);
    
    // 边线
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.txtView.frame) + 20, kWidth, 1)];
    lineView2.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [self.baseView addSubview:lineView2];
    
    // 显示时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    
    // 预约施工时间
    self.timeLab = [self _setTimeLabWithY:CGRectGetMaxY(lineView2.frame) + 5 withLeftName:@"预约施工时间" withButTag:1];
    self.timeLab.text = dateString;

    // 最迟交车时间
    NSString *dd = [formatter stringFromDate:([NSDate dateWithTimeIntervalSinceNow:10800])];
    self.zuichiTimeLab = [self _setTimeLabWithY:CGRectGetMaxY(lineView2.frame) + 50 withLeftName:@"最迟交车时间" withButTag:2];
    self.zuichiTimeLab.text = dd;

    
    // 一键下单
    CGFloat signInButW = kWidth - (kWidth * 0.116) * 2;
    CGFloat signInButH = kHeight * 0.07;
    CGFloat signInButX = kWidth * 0.116;
    CGFloat signInButY = CGRectGetMaxY(lineView2.frame) + kHeight * 0.0443 + 95;
    UIButton *signInBut = [UIButton buttonWithType:UIButtonTypeCustom];
    signInBut.frame = CGRectMake(signInButX, signInButY, signInButW, signInButH);
    signInBut.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    signInBut.layer.cornerRadius = 5;
    [signInBut setTitle:@"一键下单" forState:UIControlStateNormal];
    [self.baseView addSubview:signInBut];
    [signInBut addTarget:self action:@selector(signInButClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    _appointButton = [[UIButton alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(signInBut.frame)+5, self.view.frame.size.width-100, 20)];
    [_appointButton setTitle:@"不群推订单，稍后指定技师" forState:UIControlStateNormal];
    [_appointButton setTitleColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_appointButton setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    [_appointButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
    
    _appointButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_appointButton addTarget:self action:@selector(appointBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.baseView addSubview:_appointButton];
    
    
    
    baseViewHH = CGRectGetMaxY(signInBut.frame) + kHeight * 0.0443;
    self.baseView.frame = CGRectMake(0, 0, kWidth, CGRectGetMaxY(signInBut.frame) + kHeight * 0.0443);
    self.scrollerView.contentSize = CGSizeMake(0, CGRectGetMaxY(signInBut.frame) + kHeight * 0.0443+40);
}

- (UILabel *)_setTimeLabWithY:(CGFloat)y withLeftName:(NSString *)titleName withButTag:(NSInteger)tag {
    
    UIView *vv = [[UIView alloc] init];
    vv.frame = CGRectMake(-1, y, [UIScreen mainScreen].bounds.size.width + 2, 40);
    vv.layer.borderColor = [[UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1] CGColor];
    vv.layer.borderWidth = 1;
    vv.backgroundColor = [UIColor whiteColor];
    [self.baseView addSubview:vv];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(1, 0, [UIScreen mainScreen].bounds.size.width * 0.4, vv.frame.size.height)];
    titleLab.text = titleName;
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:16];
    titleLab.textColor = [UIColor grayColor];
    [vv addSubview:titleLab];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLab.frame), 0, [UIScreen mainScreen].bounds.size.width * 0.6, 40)];
    lab.textColor = [UIColor grayColor];
    [vv addSubview:lab];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(CGRectGetMaxX(titleLab.frame), 0, [UIScreen mainScreen].bounds.size.width * 0.6, 40);
    but.tag = tag;
    [but addTarget:self action:@selector(xuanzeshijianClick:) forControlEvents:UIControlEventTouchUpInside];
    [vv addSubview:but];
    
    
    return lab;
}

- (void)xuanzeshijianClick:(UIButton *)sender {
    
//    NSLog(@"-----%ld----", sender.tag);
    
    self.shijianNum = sender.tag;
    
    [self.view endEditing:YES];
    [self setupDateView:DateTypeOfStart];
}

- (void)appointBtnClick:(UIButton *)button{
//    NSLog(@"指定技师按钮");
    
    button.selected = !button.selected;
    
}

#pragma mark =======  PickerView ========
//选择时间的代码，时间选择器
- (void)setupDateView:(DateType)type {
    
    _pickerView = [UWDatePickerView instanceDatePickerView];
    _pickerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [_pickerView setBackgroundColor:[UIColor clearColor]];

    _pickerView.delegate = self;
    _pickerView.type = type;
    
    [self.view addSubview:_pickerView];
}

- (void)getSelectDate:(NSString *)date type:(DateType)type {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//    NSDate *chooseDate = [formatter dateFromString:date];
    NSInteger time = (NSInteger)[[formatter dateFromString:date] timeIntervalSince1970] - [[NSDate date] timeIntervalSince1970];
    if (time > 0) {
        
        if(self.shijianNum == 1 && _suo == 0) {
            
            self.timeLab.text = date;
            self.timeLab.textColor = [UIColor blackColor];
            
            NSDate *dy = [formatter dateFromString:date];
            NSInteger chijianchou = (long)[dy timeIntervalSince1970] + 10800;
            NSDate *dd = [NSDate dateWithTimeIntervalSince1970:chijianchou];
            NSString *ddd = [formatter stringFromDate:dd];
            NSLog(@"===%@", ddd);
            self.zuichiTimeLab.text = ddd;
            _suo = 1;
        }else if(self.shijianNum == 2 && _suo == 0) {
            
            
            self.zuichiTimeLab.text = date;
            self.zuichiTimeLab.textColor = [UIColor blackColor];
            _suo = 1;
        }else if(self.shijianNum == 1 && _suo == 1) {
            
            self.timeLab.text = date;
            self.timeLab.textColor = [UIColor blackColor];
        }else if(self.shijianNum == 2 && _suo == 1){
            
            
            self.zuichiTimeLab.text = date;
            self.zuichiTimeLab.textColor = [UIColor blackColor];
        }
    }else{
        
        [self addAlertView:@"所选时间不合法"];
    }

    
//    NSLog(@"----选择的时间－－－－%@--time---%@-",date,[formatter dateFromString:date]);
    
}

////设置显示在按钮上的时间的格式
//-(NSString *)stringFromDate:(NSDate *)date{
//    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    //    [dateFormatter setDateFormat:@"YYYY-MM-DD HH:MM:SS"];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    
//    NSString *destDateString = [dateFormatter stringFromDate:date];
//    return destDateString;
//}

- (void)timeChoose{
    
    [self.view endEditing:YES];
    [self setupDateView:DateTypeOfStart];
}





#pragma mark - textView的协议方法
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    if ([textView.text isEqualToString:@"订单备注(请填写本车提成，最多200字)"]) {
        textView.text = nil;
        textView.textColor = [UIColor blackColor];
    }
    
    _scrollerView.contentSize = CGSizeMake(_scrollerView.contentSize.width, _scrollerView.contentSize.height+300);
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        textView.text = @"订单备注(请填写本车提成，最多200字)";
        textView.textColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
    }
    
    _scrollerView.contentSize = CGSizeMake(_scrollerView.contentSize.width, _scrollerView.contentSize.height-300);
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (textView.text.length > 200 && range.length==0) {
        return NO;
    }else{
        return YES;
    }
}

#pragma mark - 未完成订单的响应方法
- (void)tipBtnClick{
    
    GFNoIndentViewController *noIndent = [[GFNoIndentViewController alloc]init];
//    noIndent.modelMutableArray = _modelArray;
    [self.navigationController pushViewController:noIndent animated:YES];
    
}


#pragma mark - 一键下单按钮响应方法
- (void)signInButClick {
    
//    CLAddPersonViewController *addPerson = [[CLAddPersonViewController alloc]init];
//    [self.navigationController pushViewController:addPerson animated:YES];
    
    
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    
    // 判断是否群推
    if (_appointButton.selected) {
        
//        NSLog(@"指定技师");
        mDic[@"pushToAll"] = @"false";
    }else{
        
//        NSLog(@"创建订单");
        mDic[@"pushToAll"] = @"true";
    }
    
    // 订单类型拼接
    NSString *proIDStr = @"";
    for(NSString *ss in self.proIDArr) {
    
        if(![ss isEqualToString:@"0"]) {
            
            if([proIDStr isEqualToString:@""]) {
            
                proIDStr = ss;
            }else {
                
                proIDStr = [NSString stringWithFormat:@"%@,%@", proIDStr, ss];
            }
        }
    }
    
    // 判断是否上传了照片
    if (self.photoUrlArr.count <= 0) {
        
        [self addAlertView:@"请上传订单图片"];
    }else{
        
        // 图片地址拼接
        NSString *photoStr = @"";
        for(NSString *str in self.photoUrlArr) {
        
            if([photoStr isEqualToString:@""]){
                
                photoStr = str;
            }else {
                
                photoStr = [NSString stringWithFormat:@"%@,%@", photoStr, str];
            }
        }
        mDic[@"photo"] = photoStr;
        if ([proIDStr isEqualToString:@""]) {
            
            [self addAlertView:@"请选择施工项目"];
        }else{
            
            mDic[@"type"] = proIDStr;   // 订单类型
            if ([_txtView.text isEqualToString:@"订单备注(请填写本车提成，最多200字)"]) {
                
                mDic[@"remark"] = @"无";
            }else{
                
                mDic[@"remark"] = _txtView.text;
            }
            
            //            NSLog(@"一键下单--%@--",_dataDictionary);
            mDic[@"agreedStartTime"] = self.timeLab.text;
            mDic[@"agreedEndTime"] = self.zuichiTimeLab.text;
            
            // 最迟交车时间和最晚交车时间
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSInteger yuyueTime = (NSInteger)[[formatter dateFromString:self.timeLab.text] timeIntervalSince1970];
            NSInteger zuichiTime = (NSInteger)[[formatter dateFromString:self.zuichiTimeLab.text] timeIntervalSince1970];
            NSInteger cha = zuichiTime - yuyueTime;
            if(cha >= 0) {
            
                [GFHttpTool postOneIndentDictionary:mDic success:^(NSDictionary *responseObject) {
//                    NSLog(@"下单返回数据-----%@---",responseObject);
                    if ([responseObject[@"status"] integerValue] == 1) {
                        
                        if(_appointButton.selected) {
                            
                            // 刷新黑条
                            [self getListUnfinished];
                            
                            CLAddPersonViewController *addPerson = [[CLAddPersonViewController alloc]init];
                            NSDictionary *dataDictionary = responseObject[@"message"];
                            addPerson.orderId = dataDictionary[@"id"];
                            [self.navigationController pushViewController:addPerson animated:YES];
                            
                            for(UIView *mylabelview in [self.view subviews]) {
                                
                                [mylabelview removeFromSuperview];
                            }
                            
                            [self viewDidLoad];
                            self.scrollerView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
                            //                        [self.navigationController popToRootViewControllerAnimated:YES];
                            //                        NSLog(@"-滚动视图的打印--%@---", NSStringFromCGRect(self.scrollerView.frame));
                        }else {
                            
                            
                            GFAlertView *alertView = [[GFAlertView alloc]initWithMiao:3.0];
                            UIWindow *winndow = [UIApplication sharedApplication].keyWindow;
                            [winndow addSubview:alertView];
                            
                            for(UIView *mylabelview in [self.view subviews]) {
                                
                                [mylabelview removeFromSuperview];
                            }
                            
                            [self viewDidLoad];
                            self.scrollerView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
                            [self.navigationController popToRootViewControllerAnimated:YES];
//                            NSLog(@"-滚动视图的打印--%@---", NSStringFromCGRect(self.scrollerView.frame));
                        }
                        
                        
                    }
                } failure:^(NSError *error) {
                    
                    NSLog(@"－－－下单失败---%@----",error);
                    [self addAlertView:@"下单失败,请重试"];
                }];

            }else {
                
                [self addAlertView:@"最迟交车时间应不小于预约施工时间"];
            }
            
//            NSLog(@"----下单的字典-%@===", mDic);
            
                    }
    }
    
    /*
    if (_appointButton.selected) {
//        NSLog(@"指定技师");
        [_dataDictionary setObject:@"false" forKey:@"pushToAll"];
    }else{
//        NSLog(@"创建订单");
        [_dataDictionary setObject:@"true" forKey:@"pushToAll"];
    }

    if (_isUpOrderImage == NO) {
        
        [self addAlertView:@"请上传订单图片"];
    }else{
        if (_orderType == 0) {
            
            [self addAlertView:@"请选择订单类型"];
        }else{
            
            [_dataDictionary setObject:@(_orderType) forKey:@"orderType"];
            [_dataDictionary setObject:_timeLab.text forKey:@"orderTime"];
            if ([_txtView.text isEqualToString:@"订单备注"]) {
                [_dataDictionary setObject:@"" forKey:@"remark"];
            }else{
                [_dataDictionary setObject:_txtView.text forKey:@"remark"];
            }
            
//            NSLog(@"一键下单--%@--",_dataDictionary);
            
            [GFHttpTool postOneIndentDictionary:_dataDictionary success:^(NSDictionary *responseObject) {
                NSLog(@"下单返回数据-----%@---",responseObject);
                if ([responseObject[@"status"] integerValue] == 1) {
                    [self.imgView setImage:nil forState:UIControlStateNormal];
                    _txtView.text = @"订单备注";
                    _txtView.textColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
                    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
                    NSString *dateString = [formatter stringFromDate:[NSDate date]];
                    _timeLab.text = dateString;
                    _timeLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
                    [_buttonArray enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [obj setBackgroundColor:[UIColor colorWithRed:237 / 255.0 green:238 / 255.0 blue:239 / 255.0 alpha:1]];
                        obj.selected = NO;
                    }];
                    
                    
                    if (_appointButton.selected) {
//                        NSLog(@"指定技师");
                        CLAddPersonViewController *addPerson = [[CLAddPersonViewController alloc]init];
                        NSDictionary *dataDictionary = responseObject[@"data"];
                        addPerson.orderId = dataDictionary[@"id"];
//                        NSLog(@"---addPerson.orderId---%@--",addPerson.orderId);
                        [self.navigationController pushViewController:addPerson animated:YES];
                    }
                    
                    
                    [self getListUnfinished];
                    _isUpOrderImage = NO;
                    _orderType = 0;
                    GFAlertView *alertView = [[GFAlertView alloc]initWithMiao:3.0];
                    [self.view addSubview:alertView];
                }else{
                    [self addAlertView:responseObject[@"message"]];
                }
            } failure:^(NSError *error) {
//                NSLog(@"－－－下单失败---%@----",error);
//                [self addAlertView:@"下单失败"];
            }];
            
            
            
        }
    }
    */
}


#pragma mark - 立即评价
- (void)judgeBtnClick{
    
}


#pragma mark - 相机按钮的响应方法
- (void)cameraBtnClick{
    
    BOOL result = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if (result) {
//        NSLog(@"---支持使用相机---");
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        [self  presentViewController:imagePicker animated:YES completion:^{
        }];
    }else{
//        NSLog(@"----不支持使用相机----");
    }
    
}

#pragma mark - 图片协议方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
    [self dismissViewControllerAnimated:YES completion:nil];

    GFImageView *imgView = [[GFImageView alloc] init];
    imgView.frame = CGRectMake((([UIScreen mainScreen].bounds.size.width - 40) / 3.0 + 10) * (self.photoIndex % 3) + 10, CGRectGetMaxY(self.msgView.frame) + 10 + (([UIScreen mainScreen].bounds.size.width - 40) / 3.0 + 10) * (self.photoIndex / 3), ([UIScreen mainScreen].bounds.size.width - 40) / 3.0, ([UIScreen mainScreen].bounds.size.width - 40) / 3.0);
    imgView.image = image;
    [self.baseView addSubview:imgView];
    
    UIButton *shanchuBut = [UIButton buttonWithType:UIButtonTypeCustom];
    shanchuBut.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 40) / 3.0 - 25, 0, 25, 25);
    shanchuBut.tag = self.photoIndex;
    [shanchuBut setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [shanchuBut setImage:[UIImage imageNamed:@"deleteOrder"] forState:UIControlStateHighlighted];
    [imgView addSubview:shanchuBut];
    [shanchuBut addTarget:self action:@selector(shanchuButClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.addPhotoBut.hidden = NO;
    self.addPhotoBut.frame = CGRectMake((([UIScreen mainScreen].bounds.size.width - 40) / 3.0 + 10) * ((self.photoIndex + 1) % 3) + 10, CGRectGetMaxY(self.msgView.frame) + 10 + (([UIScreen mainScreen].bounds.size.width - 40) / 3.0 + 10) * ((self.photoIndex + 1) / 3), ([UIScreen mainScreen].bounds.size.width - 40) / 3.0, ([UIScreen mainScreen].bounds.size.width - 40) / 3.0);
    
    
    self.imgView.hidden = YES;
    self.cameraBtn.hidden = YES;
    
    if(self.photoIndex == 5) {
    
        self.addPhotoBut.hidden = YES;
    }
    
    CGSize imagesize;
    if (image.size.width > image.size.height) {
        imagesize.width = 800;
        imagesize.height = image.size.height*800/image.size.width;
    }else{
        imagesize.height = 800;
        imagesize.width = image.size.width*800/image.size.height;
    }
    UIImage *imageNew = [self imageWithImage:image scaledToSize:imagesize];
    NSData *imageData = UIImageJPEGRepresentation(imageNew,0.8);
    [GFHttpTool postOrderImage:imageData success:^(id responseObject) {
        
            NSLog(@"上传成功－－%@--",responseObject);
        if ([responseObject[@"status"] integerValue] == 1) {
            
            self.photoIndex += 1;
            
            _isUpOrderImage = YES;
            [_dataDictionary setObject:responseObject[@"message"] forKey:@"photo"];
            [self.photoUrlArr addObject:responseObject[@"message"]];
            [self.photoImgArr addObject:image];
            [self.photoImgViewArr addObject:imgView];
            
            NSLog(@"----%@==", self.photoUrlArr);
        }else{
            
            [self addAlertView:responseObject[@"message"]];
//            [self.imgView setImage:nil forState:UIControlStateNormal];
            
//            if(self.photoIndex > 0) {
            
                self.addPhotoBut.frame = CGRectMake((([UIScreen mainScreen].bounds.size.width - 40) / 3.0 + 10) * ((self.photoIndex) % 3) + 10, CGRectGetMaxY(self.msgView.frame) + 10 + (([UIScreen mainScreen].bounds.size.width - 40) / 3.0 + 10) * ((self.photoIndex) / 3), ([UIScreen mainScreen].bounds.size.width - 40) / 3.0, ([UIScreen mainScreen].bounds.size.width - 40) / 3.0);
                
                [imgView removeFromSuperview];
//            }
        }
    } failure:^(NSError *error) {
        
        [self.imgView setImage:nil forState:UIControlStateNormal];
        NSLog(@"上传失败－－%@---",error);
        [self addAlertView:@"图片上传失败"];
        
//        if(self.photoIndex > 0) {
        
            self.addPhotoBut.frame = CGRectMake((([UIScreen mainScreen].bounds.size.width - 40) / 3.0 + 10) * ((self.photoIndex) % 3) + 10, CGRectGetMaxY(self.msgView.frame) + 10 + (([UIScreen mainScreen].bounds.size.width - 40) / 3.0 + 10) * ((self.photoIndex) / 3), ([UIScreen mainScreen].bounds.size.width - 40) / 3.0, ([UIScreen mainScreen].bounds.size.width - 40) / 3.0);
            [imgView removeFromSuperview];
    
//        }
    }];
    
    
    /*
    [self.imgView setImage:image forState:UIControlStateNormal];
    
    CGSize imagesize;
    if (image.size.width > image.size.height) {
        imagesize.width = 800;
        imagesize.height = image.size.height*800/image.size.width;
    }else{
        imagesize.height = 800;
        imagesize.width = image.size.width*800/image.size.height;
    }
//    imagesize.width = image.size.width/2;
//    imagesize.height = image.size.height/2;
    UIImage *imageNew = [self imageWithImage:image scaledToSize:imagesize];
    NSData *imageData = UIImageJPEGRepresentation(imageNew,0.8);
    [GFHttpTool postOrderImage:imageData success:^(id responseObject) {
//        NSLog(@"上传成功－－%@--",responseObject);
        if ([responseObject[@"result"] integerValue] == 1) {
            _isUpOrderImage = YES;
            [_dataDictionary setObject:responseObject[@"data"] forKey:@"photo"];
        }else{
            [self addAlertView:responseObject[@"message"]];
            [self.imgView setImage:nil forState:UIControlStateNormal];
        }
    } failure:^(NSError *error) {
        [self.imgView setImage:nil forState:UIControlStateNormal];
//        NSLog(@"上传失败－－%@---",error);
//        [self addAlertView:@"图片上传失败"];
    }];
    */
}


#pragma mark - 压缩图片尺寸
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)butClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if(sender.selected == YES) {
        
        self.proIDArr[sender.tag - 1] = [NSString stringWithFormat:@"%ld", sender.tag];
        sender.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        sender.selected = YES;
    }else {
        
        self.proIDArr[sender.tag - 1] = [NSString stringWithFormat:@"0"];
        [sender setBackgroundColor:[UIColor colorWithRed:237 / 255.0 green:238 / 255.0 blue:239 / 255.0 alpha:1]];
    }
    
//    NSLog(@"====%@", self.proIDArr);
}



- (UIView *)successView {
    
//    CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
//    CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
    
    UIView *vv = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    vv.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    // 基础View
    CGFloat baseViewW = kWidth - 2 * kWidth * 0.1;
    CGFloat baseViewH = 300;
    CGFloat baseViewX = kWidth * 0.1;
    CGFloat baseViewY = 130 / 568.0 * kHeight;
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
    baseView.backgroundColor = [UIColor whiteColor];
    [vv addSubview:baseView];
    baseView.layer.cornerRadius = 7.5;
    baseView.clipsToBounds = YES;
    
    // 右上方X按钮
    CGFloat butW = kHeight * 0.06;
    CGFloat butH = butW;
    CGFloat butX = baseViewW - 20 - butW;
    CGFloat butY = 20;
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(butX, butY, butW, butH);
    but.backgroundColor = [UIColor redColor];
    [baseView addSubview:but];
//    [but addTarget:self action:@selector(okButClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    // 下单成功
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(but.frame) + 5, baseViewW, kHeight * 0.04)];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    lab.text = @"下单成功！";
    [baseView addSubview:lab];
    
    
    // 倒计时按钮
    CGFloat timeLabW = butW * 2.0;
    CGFloat timeLabH = butH;
    CGFloat timeLabX = (baseViewW - timeLabW) / 2.0;
    CGFloat timeLabY = CGRectGetMaxY(lab.frame) + 20;
    self.timeLab1 = [[UILabel alloc] initWithFrame:CGRectMake(timeLabX, timeLabY, timeLabW, timeLabH)];
    self.timeLab1.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [baseView addSubview:self.timeLab1];
    
    baseView.frame = CGRectMake(baseViewX, baseViewY, baseViewW, CGRectGetMaxY(self.timeLab.frame) + 40);
    
    
    // 计时器
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timeWork) userInfo:nil repeats:YES];
    
    
    return vv;
}

- (void)timeWork {

    
}

- (void)shanchuButClick:(UIButton *)sender {
    
    self.photoIndex -= 1;
    [self.photoUrlArr removeObjectAtIndex:sender.tag];
    [self.photoImgArr removeObjectAtIndex:sender.tag];
    [sender.superview removeFromSuperview];
    self.addPhotoBut.hidden = NO;
    self.addPhotoBut.frame = CGRectMake((([UIScreen mainScreen].bounds.size.width - 40) / 3.0 + 10) * ((self.photoIndex) % 3) + 10, CGRectGetMaxY(self.msgView.frame) + 10 + (([UIScreen mainScreen].bounds.size.width - 40) / 3.0 + 10) * ((self.photoIndex) / 3), ([UIScreen mainScreen].bounds.size.width - 40) / 3.0, ([UIScreen mainScreen].bounds.size.width - 40) / 3.0);
    
    for(int i=0; i<self.photoImgViewArr.count; i++) {
    
        GFImageView *imgView = (GFImageView *)self.photoImgViewArr[i];
        [imgView removeFromSuperview];
    }
    
    for(int i=0; i<self.photoImgArr.count; i++) {
        
        GFImageView *imgView = (GFImageView *)self.photoImgViewArr[i];
        imgView.frame = CGRectMake((([UIScreen mainScreen].bounds.size.width - 40) / 3.0 + 10) * (i % 3) + 10, CGRectGetMaxY(self.msgView.frame) + 10 + (([UIScreen mainScreen].bounds.size.width - 40) / 3.0 + 10) * (i / 3), ([UIScreen mainScreen].bounds.size.width - 40) / 3.0, ([UIScreen mainScreen].bounds.size.width - 40) / 3.0);
        imgView.image = (UIImage *)self.photoImgArr[i];
        [self.baseView addSubview:imgView];
    }
    
//    NSLog(@"--上传照片数组--%@", self.photoUrlArr);
}


- (void)leftButClick {
    
    [GFHttpTool postOrderCountsuccess:^(id responseObject) {
        
//        NSLog(@"===%@==", responseObject);
        
        if ([responseObject[@"status"] integerValue] == 1) {
            GFPartnersMessageViewController *partnerView = [[GFPartnersMessageViewController alloc]init];
            partnerView.muLab = [[UILabel alloc]init];
            partnerView.muLab.text = [NSString stringWithFormat:@"%@",responseObject[@"message"]];
//            NSLog(@"--获取商户订单信息－－%@--",partnerView.muLab.text);
            [self.navigationController pushViewController:partnerView animated:YES];
        }else{
            [self addAlertView:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
//        [self addAlertView:@"请求失败"];
    }];
    
    
    
    
    
//    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
