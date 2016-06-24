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
    
}

//@property (nonatomic, strong) GFNavigationView *navView;




// 订单信息
@property (nonatomic, strong) GFTitleView *msgView;
// 示例图
@property (nonatomic, strong) UIButton *imgView;
// 请填写备注
@property (nonatomic, strong) UITextView *txtView;
// 施工时间Lab
@property (nonatomic, strong) UILabel *timeLab;



@property (nonatomic, strong) UILabel *timeLab1;


@end

@implementation GFOneIndentViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    kWidth = [UIScreen mainScreen].bounds.size.width;
    kHeight = [UIScreen mainScreen].bounds.size.height;
    jiange1 = kHeight * 0.013;
    jiange2 = kHeight * 0.0365;
    jiange3 = kHeight * 0.0157;
    jianjv1 = kWidth * 0.0416;
    _dataDictionary = [[NSMutableDictionary alloc]init];
    // 界面搭建
    [self _setView];
    
    // 基础设置
    [self _setBase];
    
    [self NSNotificationCenter];
}

#pragma mark - 注册通知中心
- (void)NSNotificationCenter{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getListUnfinished) name:@"FINISHED" object:nil];
}

- (void)_setBase {
    
    
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    
    
    // 导航栏
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"person" withLeftImgHightName:@"personClick" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"车邻邦" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navView];
    [self.view bringSubviewToFront:navView];
    
    [self getListUnfinished];
}

#pragma mark - 获取商户未完成订单
- (void)getListUnfinished{
    
//    _modelArray = [[NSMutableArray alloc]init];
    
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
                self.scrollerView.contentSize = CGSizeMake(0, baseViewHH);
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
}



- (void)_setView {
    
    
    
    self.scrollerView = [[CLTouchScrollView alloc] init];
    self.scrollerView.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    self.scrollerView.frame = CGRectMake(0, 64-kHeight * 0.0625-20, kWidth, kHeight - 44+kHeight * 0.0625);
    self.scrollerView.contentSize = CGSizeMake(0, 1000);
    self.scrollerView.showsHorizontalScrollIndicator = NO;
    self.scrollerView.showsVerticalScrollIndicator = NO;
//    self.scrollerView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.scrollerView];
    
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
//    self.tipButton.textColor = [UIColor whiteColor];
    self.tipButton.titleLabel.font = [UIFont systemFontOfSize:11 / 320.0 * kWidth];
//    self.tipButton.text = @"有3个未完成订单";
//    [_tipButton setTitle:@"有3个未完成订单" forState:UIControlStateNormal];
    [_scrollerView addSubview:self.tipButton];
    _tipButton.hidden = YES;
    [_tipButton addTarget:self action:@selector(tipBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 订单信息
    self.msgView = [[GFTitleView alloc] initWithY:CGRectGetMaxY(self.tipButton.frame) + jiange1 Title:@"订单信息"];
    [self.baseView addSubview:self.msgView];
    
    // 示例图
    CGFloat imgViewW = kWidth - 4 * jianjv1;
    CGFloat imgViewH = kHeight * 0.24;
    CGFloat imgViewX = jianjv1*2;
    CGFloat imgViewY = CGRectGetMaxY(self.msgView.frame) + jiange2;
    self.imgView = [[UIButton alloc] initWithFrame:CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH)];
//    self.imgView.backgroundColor = [UIColor redColor];
//    self.imgView.image = [UIImage imageNamed:@"orderImage"];
    [self.imgView setBackgroundImage:[UIImage imageNamed:@"orderImage"] forState:UIControlStateNormal];
    self.imgView.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.baseView addSubview:self.imgView];
    
    UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraBtn.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame)-15, CGRectGetMaxY(self.imgView.frame)-15, 30, 30);
    [cameraBtn setBackgroundImage:[UIImage imageNamed:@"cameraUser"] forState:UIControlStateNormal];
    [self.baseView addSubview:cameraBtn];
    
    [cameraBtn addTarget:self action:@selector(cameraBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.imgView addTarget:self action:@selector(cameraBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    // 边线
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(jianjv1, CGRectGetMaxY(self.imgView.frame) + jiange2, kWidth - jianjv1 * 2, 1)];
    lineView1.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [self.baseView addSubview:lineView1];
    
    // 请填写备注
    CGFloat txtViewW = kWidth - jianjv1*2;
    CGFloat txtViewH = kHeight * 0.21;
    CGFloat txtViewX = jianjv1;
    CGFloat txtViewY = CGRectGetMaxY(lineView1.frame) + kHeight * 0.024;
    self.txtView = [[UITextView alloc] initWithFrame:CGRectMake(txtViewX, txtViewY, txtViewW, txtViewH)];
    self.txtView.text = @"订单备注";
    self.txtView.textColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
    self.txtView.delegate = self;
    [self.baseView addSubview:self.txtView];
    
    self.baseView.frame = CGRectMake(baseViewX, baseViewY, baseViewW, CGRectGetMaxY(self.txtView.frame) + 20);
    
    // 边线
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.txtView.frame) + 20, kWidth, 1)];
    lineView2.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [self.baseView addSubview:lineView2];
    
    
    // 施工时间
    GFTitleView *timeView = [[GFTitleView alloc] initWithY:CGRectGetMaxY(lineView2.frame) + jiange3 Title:@"施工时间"];
    [self.baseView addSubview:timeView];
    
    // 施工时间Lab
    UIView *labView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(timeView.frame), kWidth, kHeight * 0.099)];
    labView.backgroundColor = [UIColor whiteColor];
    [self.baseView addSubview:labView];
    CGFloat timeLabW = kWidth - (kWidth * 0.065 * 2);
    CGFloat timeLabH = kHeight * 0.099;
    CGFloat timeLabX = kWidth * 0.065;
    CGFloat timeLabY = 0;
    self.timeLab = [[UILabel alloc] initWithFrame:CGRectMake(timeLabX, timeLabY, timeLabW, timeLabH)];
    // 显示时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    self.timeLab.text = dateString;
    self.timeLab.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    self.timeLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
    [labView addSubview:self.timeLab];
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:labView.bounds];
//    button.backgroundColor = [UIColor redColor];
    
    
    [button addTarget:self action:@selector(timeChoose) forControlEvents:UIControlEventTouchUpInside];
    [labView addSubview:button];
    
    
    
    // 边线
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight * 0.099, kWidth, 1)];
    lineView3.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [labView addSubview:lineView3];
    
    
    // 施工项目
    GFTitleView *projectView = [[GFTitleView alloc] initWithY:CGRectGetMaxY(labView.frame) + jiange3 Title:@"施工项目"];
    [self.baseView addSubview:projectView];
    
    // 施工项目按钮
    CGFloat butViewW = kWidth;
    CGFloat butViewH = timeLabH;
    CGFloat butViewX = 0;
    CGFloat butViewY = CGRectGetMaxY(projectView.frame);
    UIView *butView = [[UIView alloc] initWithFrame:CGRectMake(butViewX, butViewY, butViewW, butViewH)];
    butView.backgroundColor = [UIColor whiteColor];
    [self.baseView addSubview:butView];
    NSArray *nameArr = @[@"隔热膜", @"隐形车衣", @"车身改色", @"美容清洁"];
    _buttonArray = [[NSMutableArray alloc]init];
    for(int i=0; i<4; i++) {
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
    
    // 一键下单
    CGFloat signInButW = kWidth - (kWidth * 0.116) * 2;
    CGFloat signInButH = kHeight * 0.07;
    CGFloat signInButX = kWidth * 0.116;
    CGFloat signInButY = CGRectGetMaxY(butView.frame) + kHeight * 0.0443;
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
//    [_appointButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_appointButton setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    [_appointButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
    
    _appointButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_appointButton addTarget:self action:@selector(appointBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.baseView addSubview:_appointButton];
    
    
    
    
    baseViewHH = CGRectGetMaxY(signInBut.frame) + kHeight * 0.0443;
    self.baseView.frame = CGRectMake(0, 0, kWidth, CGRectGetMaxY(signInBut.frame) + kHeight * 0.0443);
    self.scrollerView.contentSize = CGSizeMake(0, CGRectGetMaxY(signInBut.frame) + kHeight * 0.0443);
    
//    baseView.backgroundColor = [UIColor redColor];
//    self.scrollerView.backgroundColor = [UIColor greenColor];
    
}

- (void)appointBtnClick:(UIButton *)button{
    NSLog(@"指定技师按钮");
    
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
        self.timeLab.text = date;
        self.timeLab.textColor = [UIColor blackColor];
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
    
    if ([textView.text isEqualToString:@"订单备注"]) {
        textView.text = nil;
        textView.textColor = [UIColor blackColor];
    }
    
    _scrollerView.contentSize = CGSizeMake(_scrollerView.contentSize.width, _scrollerView.contentSize.height+300);
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        textView.text = @"订单备注";
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
    
//    GFAlertView *alertView = [[GFAlertView alloc] initWithHomeTipName:@"提醒" withTipMessage:@"订单编号为%@已结束工作，请您对此次工作的技师做出评价" withButtonNameArray:@[@"立即评价"]];
//    [alertView.okBut addTarget:self action:@selector(judgeBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:alertView];
    
    
    if (_appointButton.selected) {
        NSLog(@"指定技师");
        [_dataDictionary setObject:@"false" forKey:@"pushToAll"];
        
        
    }else{
        NSLog(@"创建订单");
        [_dataDictionary setObject:@"true" forKey:@"pushToAll"];
    }
    
    
    

    if (_isUpOrderImage == NO) {
        [self addAlertView:@"请上传订单图片"];
    }else{
        if (_orderType == 0) {
            [self addAlertView:@"请选择订单类型"];
        }else{
//            [_dataDictionary setObject:@"12354654" forKey:@"photo"];
            [_dataDictionary setObject:@(_orderType) forKey:@"orderType"];
            [_dataDictionary setObject:_timeLab.text forKey:@"orderTime"];
            if ([_txtView.text isEqualToString:@"订单备注"]) {
                [_dataDictionary setObject:@"" forKey:@"remark"];
            }else{
                [_dataDictionary setObject:_txtView.text forKey:@"remark"];
            }
            
            NSLog(@"一键下单--%@--",_dataDictionary);
            
            [GFHttpTool postOneIndentDictionary:_dataDictionary success:^(NSDictionary *responseObject) {
                NSLog(@"下单返回数据-----%@---",responseObject);
                if ([responseObject[@"result"] integerValue] == 1) {
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
                        NSLog(@"指定技师");
                        CLAddPersonViewController *addPerson = [[CLAddPersonViewController alloc]init];
                        NSDictionary *dataDictionary = responseObject[@"data"];
                        addPerson.orderId = dataDictionary[@"id"];
                        NSLog(@"---addPerson.orderId---%@--",addPerson.orderId);
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
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
    
    
    
    
}


#pragma mark - 压缩图片尺寸
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
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


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)butClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if(sender.selected == YES) {
        _orderType = sender.tag;
        [_buttonArray enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj setBackgroundColor:[UIColor colorWithRed:237 / 255.0 green:238 / 255.0 blue:239 / 255.0 alpha:1]];
            obj.selected = NO;
        }];
        sender.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        sender.selected = YES;
    }else {
        _orderType = 0;
        [sender setBackgroundColor:[UIColor colorWithRed:237 / 255.0 green:238 / 255.0 blue:239 / 255.0 alpha:1]];
    }
    
    
//    NSLog(@"按钮被点击了");
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

- (void)leftButClick {
    
    [GFHttpTool postOrderCountsuccess:^(id responseObject) {
        
        if ([responseObject[@"result"] integerValue] == 1) {
            GFPartnersMessageViewController *partnerView = [[GFPartnersMessageViewController alloc]init];
            partnerView.muLab = [[UILabel alloc]init];
            partnerView.muLab.text = [NSString stringWithFormat:@"%@",responseObject[@"data"]];
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
