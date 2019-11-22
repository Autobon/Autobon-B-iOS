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
#import "HXPhotoPicker.h"
#import "GFIndentViewController.h"
#import "CLHomeProductTableViewCell.h"
#import "CLPackageProductTableViewCell.h"
#import "CLProductPackageModel.h"


@interface GFOneIndentViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UWDatePickerViewDelegate,HXAlbumListViewControllerDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
    
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
    
    UITableView *_tableView;
    UIView *_packageTitleBaseView;
    UIView *_footBaseView;
    NSMutableArray *_selectPackageClassButtonArray; //选择施工项目按钮数组
    NSMutableArray *_selectPackageClassLabelArray; //选择施工项目数目按钮
    UIButton *_packageBaseViewChangeButton;
    UIScrollView *_packageScrollView;
    UIButton *_showSelectProductButton;     //查看已选项目按钮
    NSInteger _selectType;      //当前选中的施工项目类型
    NSInteger _selectPackageIndex;  //当前选中的套餐
    CLProductPackageModel *_selectPackageModel; //当前选中套餐对象
    NSMutableArray *_packageSelectButtonArray;
    UITextField *_orderDataVinTextField;
    UITextField *_orderDataCarLicenseTextField;
    UITextField *_orderDataCarTypeTextField;
    UITextField *_orderDataBeginTimeTextField;
    UITextField *_orderDataEndTimeTextField;
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

@property (strong, nonatomic) HXPhotoManager *manager;
@property (strong, nonatomic) UIColor *bottomViewBgColor;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *dataOrderBaseView;
@property (nonatomic, strong) UIView *photoOrderBaseView;
@property (nonatomic, strong) UIView *showBgView;           //弹出框背景View
@property (nonatomic, strong) NSMutableArray *packageArray;
@property (nonatomic, strong) NSMutableArray *productArray;
@property (nonatomic, strong) NSMutableArray *selectProductArray;       //已选中施工项目
@property (nonatomic, strong) NSMutableArray *selectProductIdArray;       //已选中施工项目Id
@property (nonatomic, strong) NSMutableArray *packageProductArray;
@property (nonatomic, strong) NSMutableArray *selectPackageArray;       //已选中施工套餐
@property (nonatomic, strong) NSMutableArray *selectPackageIdArray;       //已选中施工套餐Id


@end

@implementation GFOneIndentViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _suo = 0;
    _selectPackageIndex = -1;
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
    self.selectPackageArray = [[NSMutableArray alloc]init];
    self.selectPackageIdArray = [[NSMutableArray alloc]init];
    
    // 基础设置
    [self _setBase];
    
    // 界面搭建
//    [self _setView];
    
    [self NSNotificationCenter];
    
    [self setViewForBase];
    
    [self setDataOrderView];
    
    [self setPhotoOrderView];
    self.photoOrderBaseView.hidden = YES;
    
    [self getProductList:0];
    [self getAllProductList];
    
    self.selectProductArray = [[NSMutableArray alloc]init];
    self.selectProductIdArray = [[NSMutableArray alloc]init];
    
    
    [self setSaveDataForView];
    
}


- (void)setSaveDataForView{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dataDictionary = [userDefaults objectForKey:@"homeOrderData"];
    
    if (dataDictionary){
        ICLog(@"---存储的数据---dataDictionary--%@----", dataDictionary);
        _orderDataCarLicenseTextField.text = dataDictionary[@"license"];
        _orderDataVinTextField.text = dataDictionary[@"vin"];
        _orderDataCarTypeTextField.text = dataDictionary[@"vehicleModel"];
        _orderDataBeginTimeTextField.text = dataDictionary[@"agreedStartTime"];
        _orderDataEndTimeTextField.text = dataDictionary[@"agreedEndTime"];
        self.selectProductIdArray = [[NSMutableArray alloc] initWithArray:dataDictionary[@"offerIds"]];
        NSMutableArray *labelStringArray = dataDictionary[@"labelStringArray"];
        [_selectPackageClassLabelArray enumerateObjectsUsingBlock:^(UILabel *objLabel, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *labelString = labelStringArray[idx];
            objLabel.text = labelString;
            if ([labelString integerValue] > 0){
                objLabel.hidden = false;
            }
        }];
    }else{
        ICLog(@"---暂未存储数据---");
    }
}


- (void)setDataOrderView{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *orderByPhotoString = [userDefaults objectForKey:@"cooperatorOrderByPhoto"];
    
    
    _dataOrderBaseView = [[UIView alloc]init];
    [self.view addSubview:_dataOrderBaseView];
    [_dataOrderBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        
        if ([orderByPhotoString isEqualToString:@"1"]){
            ICLog(@"支持数据下单");
            make.top.equalTo(_navView.mas_bottom).offset(45);
        }else{
            ICLog(@"不支持数据下单");
            make.top.equalTo(_navView.mas_bottom).offset(0);
        }
    }];
    
    UIView *textFieldBaseView = [[UIView alloc]init];
    textFieldBaseView.backgroundColor = [UIColor whiteColor];
    [_dataOrderBaseView addSubview:textFieldBaseView];
    [textFieldBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(_dataOrderBaseView);
        make.height.mas_offset(212);
    }];
    
    
    UILabel *vinLabel = [[UILabel alloc]init];
    vinLabel.text = @"车架号后七位";
    vinLabel.font = [UIFont systemFontOfSize:14];
    [textFieldBaseView addSubview:vinLabel];
    [vinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textFieldBaseView);
        make.left.equalTo(textFieldBaseView).offset(22);
        make.height.mas_offset(40);
        make.width.mas_offset(90);
    }];
//    UIView *vinLineView = [[UIView alloc]init];
//    vinLineView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
//    [textFieldBaseView addSubview:vinLineView];
//    [vinLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(textFieldBaseView);
//        make.bottom.equalTo(vinLabel);
//        make.height.mas_offset(1);
//    }];
    
    
    _orderDataVinTextField = [[UITextField alloc]init];
    _orderDataVinTextField.placeholder = @"未填写";
    _orderDataVinTextField.textAlignment = NSTextAlignmentRight;
    _orderDataVinTextField.font = [UIFont systemFontOfSize:14];
    [textFieldBaseView addSubview:_orderDataVinTextField];
    [_orderDataVinTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vinLabel.mas_right).offset(10);
        make.right.equalTo(textFieldBaseView).offset(-22);
        make.height.mas_offset(25);
        make.centerY.equalTo(vinLabel);
    }];
    
    UIView *vinLineView = [[UIView alloc]init];
    vinLineView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
//    vinLineView.backgroundColor = [UIColor redColor];
    [textFieldBaseView addSubview:vinLineView];
    [vinLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textFieldBaseView).offset(15);
        make.right.equalTo(textFieldBaseView).offset(-15);
        make.top.equalTo(vinLabel.mas_bottom).offset(1);
        make.height.mas_offset(1);
    }];
    
    UILabel *carLicenseLabel = [[UILabel alloc]init];
    carLicenseLabel.text = @"车牌号";
    carLicenseLabel.font = [UIFont systemFontOfSize:14];
    [textFieldBaseView addSubview:carLicenseLabel];
    [carLicenseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vinLabel.mas_bottom).offset(2);
        make.left.equalTo(textFieldBaseView).offset(22);
        make.height.mas_offset(40);
        make.width.mas_offset(90);
    }];
    
    _orderDataCarLicenseTextField = [[UITextField alloc]init];
    _orderDataCarLicenseTextField.placeholder = @"未填写";
    _orderDataCarLicenseTextField.textAlignment = NSTextAlignmentRight;
    _orderDataCarLicenseTextField.font = [UIFont systemFontOfSize:14];
    [textFieldBaseView addSubview:_orderDataCarLicenseTextField];
    [_orderDataCarLicenseTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(carLicenseLabel.mas_right).offset(10);
        make.right.equalTo(textFieldBaseView).offset(-22);
        make.height.mas_offset(25);
        make.centerY.equalTo(carLicenseLabel);
    }];
    
    UIView *carLicenseLineView = [[UIView alloc]init];
    carLicenseLineView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    [textFieldBaseView addSubview:carLicenseLineView];
    [carLicenseLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textFieldBaseView).offset(15);
        make.right.equalTo(textFieldBaseView).offset(-15);
        make.top.equalTo(carLicenseLabel.mas_bottom).offset(5);
        make.height.mas_offset(1);
    }];
    
    UILabel *carTypeLabel = [[UILabel alloc]init];
    carTypeLabel.text = @"车型";
    carTypeLabel.font = [UIFont systemFontOfSize:14];
    [textFieldBaseView addSubview:carTypeLabel];
    [carTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(carLicenseLabel.mas_bottom).offset(2);
        make.left.equalTo(textFieldBaseView).offset(22);
        make.height.mas_offset(40);
        make.width.mas_offset(90);
    }];
    
    _orderDataCarTypeTextField = [[UITextField alloc]init];
    _orderDataCarTypeTextField.placeholder = @"未填写";
    _orderDataCarTypeTextField.textAlignment = NSTextAlignmentRight;
    _orderDataCarTypeTextField.font = [UIFont systemFontOfSize:14];
    [textFieldBaseView addSubview:_orderDataCarTypeTextField];
    [_orderDataCarTypeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(carTypeLabel.mas_right).offset(10);
        make.right.equalTo(textFieldBaseView).offset(-22);
        make.height.mas_offset(25);
        make.centerY.equalTo(carTypeLabel);
    }];
    
    UIView *carTypeLineView = [[UIView alloc]init];
    carTypeLineView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    [textFieldBaseView addSubview:carTypeLineView];
    [carTypeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textFieldBaseView).offset(15);
        make.right.equalTo(textFieldBaseView).offset(-15);
        make.top.equalTo(carTypeLabel.mas_bottom).offset(5);
        make.height.mas_offset(1);
    }];
    
    UILabel *beginTimeLabel = [[UILabel alloc]init];
    beginTimeLabel.text = @"预约施工时间";
    beginTimeLabel.font = [UIFont systemFontOfSize:14];
    [textFieldBaseView addSubview:beginTimeLabel];
    [beginTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(carTypeLabel.mas_bottom).offset(2);
        make.left.equalTo(textFieldBaseView).offset(22);
        make.height.mas_offset(40);
        make.width.mas_offset(90);
    }];
    
    _orderDataBeginTimeTextField = [[UITextField alloc]init];
    _orderDataBeginTimeTextField.placeholder = @"预约施工时间";
    _orderDataBeginTimeTextField.textAlignment = NSTextAlignmentRight;
    _orderDataBeginTimeTextField.font = [UIFont systemFontOfSize:14];
    _orderDataBeginTimeTextField.delegate = self;
    _orderDataBeginTimeTextField.tag = 1;
    [textFieldBaseView addSubview:_orderDataBeginTimeTextField];
    [_orderDataBeginTimeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textFieldBaseView.mas_centerX).offset(0);
        make.right.equalTo(textFieldBaseView).offset(-22);
        make.height.mas_offset(40);
        make.centerY.equalTo(beginTimeLabel);
    }];
    
    
    
    UIView *beginTimeLineView = [[UIView alloc]init];
    beginTimeLineView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    [textFieldBaseView addSubview:beginTimeLineView];
    [beginTimeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textFieldBaseView).offset(15);
        make.right.equalTo(textFieldBaseView).offset(-15);
        make.top.equalTo(_orderDataBeginTimeTextField.mas_bottom).offset(5);
        make.height.mas_offset(1);
    }];
    
    
    UILabel *endTimeLabel = [[UILabel alloc]init];
    endTimeLabel.text = @"预约结束时间";
    endTimeLabel.font = [UIFont systemFontOfSize:14];
    [textFieldBaseView addSubview:endTimeLabel];
    [endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(beginTimeLabel.mas_bottom).offset(2);
        make.left.equalTo(textFieldBaseView).offset(22);
        make.height.mas_offset(40);
        make.width.mas_offset(90);
    }];
    
    _orderDataEndTimeTextField = [[UITextField alloc]init];
    _orderDataEndTimeTextField.placeholder = @"最迟交车时间";
    _orderDataEndTimeTextField.textAlignment = NSTextAlignmentRight;
    _orderDataEndTimeTextField.font = [UIFont systemFontOfSize:14];
    _orderDataEndTimeTextField.delegate = self;
    _orderDataEndTimeTextField.tag = 2;
    [textFieldBaseView addSubview:_orderDataEndTimeTextField];
    [_orderDataEndTimeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textFieldBaseView.mas_centerX).offset(0);
        make.right.equalTo(textFieldBaseView).offset(-22);
        make.height.mas_offset(40);
        make.centerY.equalTo(endTimeLabel);
    }];
    
//    UIView *endTimeLineView = [[UIView alloc]init];
//    endTimeLineView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
//    [textFieldBaseView addSubview:endTimeLineView];
//    [endTimeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(textFieldBaseView).offset(15);
//        make.right.equalTo(textFieldBaseView).offset(-15);
//        make.top.equalTo(_orderDataEndTimeTextField.mas_bottom).offset(5);
//        make.height.mas_offset(1);
//    }];
    
    _packageTitleBaseView = [[UIView alloc]init];
//    packageTitleBaseView.backgroundColor = [UIColor cyanColor];
    [_dataOrderBaseView addSubview:_packageTitleBaseView];
    [_packageTitleBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_dataOrderBaseView);
        make.top.equalTo(textFieldBaseView.mas_bottom).offset(0);
        make.height.mas_offset(40);
    }];;
    
    UIView *leftLittleView = [[UIView alloc]init];
    leftLittleView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [_packageTitleBaseView addSubview:leftLittleView];
    [leftLittleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_packageTitleBaseView);
        make.width.mas_offset(5);
        make.height.mas_offset(15);
        make.centerY.equalTo(_packageTitleBaseView);
    }];
    
    UILabel *packageTitleLabel = [[UILabel alloc]init];
    packageTitleLabel.text = @"选择施工项目";
    packageTitleLabel.font = [UIFont systemFontOfSize:14];
    [_packageTitleBaseView addSubview:packageTitleLabel];
    [packageTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_packageTitleBaseView);
        make.left.equalTo(_packageTitleBaseView).offset(30);
    }];
    
    _packageBaseViewChangeButton = [[UIButton alloc]init];
    [_packageBaseViewChangeButton setTitle:@"选择套餐" forState:UIControlStateNormal];
    [_packageBaseViewChangeButton setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
    _packageBaseViewChangeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_packageBaseViewChangeButton addTarget:self action:@selector(packageBaseViewChangeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_packageTitleBaseView addSubview:_packageBaseViewChangeButton];
    [_packageBaseViewChangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_packageTitleBaseView).offset(-16);
        make.width.mas_offset(70);
        make.height.mas_offset(45);
        make.centerY.equalTo(_packageTitleBaseView);
    }];
    
    _footBaseView = [[UIView alloc]init];
//    footBaseView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    _footBaseView.backgroundColor = [UIColor whiteColor];
    [_dataOrderBaseView addSubview:_footBaseView];
    [_footBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(_dataOrderBaseView);
        make.height.mas_offset(60);
    }];
    
    
    //已选套餐/项目
    _showSelectProductButton = [[UIButton alloc]init];
    _showSelectProductButton.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [_showSelectProductButton setTitle:@"已选项目" forState:UIControlStateNormal];
    _showSelectProductButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _showSelectProductButton.layer.cornerRadius = 3;
    [_showSelectProductButton addTarget:self action:@selector(showSelectProductBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_footBaseView addSubview:_showSelectProductButton];
    [_showSelectProductButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_dataOrderBaseView).offset(15);
        make.right.equalTo(_dataOrderBaseView.mas_centerX).offset(-15);
        make.height.mas_offset(40);
        make.centerY.equalTo(_footBaseView);
    }];

    UIButton *dataOrderSubmitButton = [[UIButton alloc]init];
    dataOrderSubmitButton.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [dataOrderSubmitButton setTitle:@"一键下单" forState:UIControlStateNormal];
    dataOrderSubmitButton.titleLabel.font = [UIFont systemFontOfSize:15];
    dataOrderSubmitButton.layer.cornerRadius = 3;
    [dataOrderSubmitButton addTarget:self action:@selector(orderDataSubmitBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [dataOrderSubmitButton addTarget:self action:@selector(saveOrderData) forControlEvents:UIControlEventTouchUpInside];
    [_footBaseView addSubview:dataOrderSubmitButton];
    [dataOrderSubmitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_dataOrderBaseView.mas_centerX).offset(15);
        make.right.equalTo(_dataOrderBaseView.mas_right).offset(-15);
        make.height.mas_offset(40);
        make.centerY.equalTo(_footBaseView);
    }];
    
    
    
    
    UIView *leftView = [[UIView alloc]init];
    [_dataOrderBaseView addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_dataOrderBaseView);
        make.top.equalTo(_packageTitleBaseView.mas_bottom);
        make.bottom.equalTo(_footBaseView.mas_top);
        make.width.mas_offset(70);
    }];
//    leftView.backgroundColor = [UIColor cyanColor];
    
    _selectPackageClassButtonArray = [[NSMutableArray alloc]init];
    _selectPackageClassLabelArray = [[NSMutableArray alloc]init];
    UIButton *lastButton;
    NSArray *titleStringArray = @[@"贴膜", @"美容", @"车衣", @"改色"];
    for (int i = 0; i < 4; i++) {
        UIButton *button = [[UIButton alloc]init];
        [button setTitle:titleStringArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(selectPackageClassBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_selectPackageClassButtonArray addObject:button];
        if (i == 0){
            button.backgroundColor = [UIColor whiteColor];
        }
//        button.backgroundColor = [UIColor redColor];
        [leftView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(leftView);
            make.height.mas_equalTo(leftView.mas_height).multipliedBy(0.25);
//            make.width.equalTo(otherView.width).multipleBy(0.5);
//            make.height.mas_offset(45);
            if (lastButton){
                make.top.equalTo(lastButton.mas_bottom);
            }else{
                make.top.equalTo(leftView.mas_top);
            }
            
        }];
        lastButton = button;
        
        
        UILabel *iconLabel = [[UILabel alloc]init];
        iconLabel.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        [button addSubview:iconLabel];
        iconLabel.font = [UIFont systemFontOfSize:10];
        iconLabel.layer.cornerRadius = 7;
        iconLabel.clipsToBounds = YES;
        iconLabel.textAlignment = NSTextAlignmentCenter;
        iconLabel.text = @"0";
        iconLabel.textColor = [UIColor whiteColor];
        [iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(button).offset(20);
            make.centerY.equalTo(button).offset(-8);
            make.width.mas_offset(14);
            make.height.mas_offset(14);
        }];
        iconLabel.hidden = YES;
        
        [_selectPackageClassLabelArray addObject:iconLabel];
        
        
        
        
    }
    
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.separatorColor = [UIColor clearColor];
    [_dataOrderBaseView addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_dataOrderBaseView);
        make.left.equalTo(leftView.mas_right);
        make.top.equalTo(_packageTitleBaseView.mas_bottom);
        make.bottom.equalTo(_footBaseView.mas_top);
    }];
    
}

- (void)setPackageScrollBaseView{
    [_packageScrollView removeFromSuperview];
    _packageScrollView = nil;
    
    // 设置选择套餐滚动视图
    _packageScrollView = [[UIScrollView alloc]init];
    _packageScrollView.backgroundColor = [UIColor whiteColor];
    [_dataOrderBaseView addSubview:_packageScrollView];
    [_packageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_dataOrderBaseView);
        make.top.equalTo(_packageTitleBaseView.mas_bottom);
        make.bottom.equalTo(_footBaseView.mas_top);
    }];
    _packageScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 45 * self.packageArray.count);
    _packageSelectButtonArray = [[NSMutableArray alloc]init];
    self.selectPackageIdArray = [[NSMutableArray alloc]init];
    self.selectPackageArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < self.packageArray.count; i++) {
        CLProductPackageModel *productModel = self.packageArray[i];
        
        UIButton *contentBaseButton = [[UIButton alloc]init];
        contentBaseButton.backgroundColor = [UIColor whiteColor];
        [_packageScrollView addSubview:contentBaseButton];
        contentBaseButton.frame = CGRectMake(0, 0 + i * 45, self.view.frame.size.width, 45);
        contentBaseButton.tag = i;
        [contentBaseButton addTarget:self action:@selector(packageBaseViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *contentTitleLabel = [[UILabel alloc]init];
        contentTitleLabel.text = productModel.name;
//        contentTitleLabel.text = [NSString stringWithFormat:@"套餐%d", i + 1];
        [contentBaseButton addSubview:contentTitleLabel];
        [contentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentBaseButton).offset(25);
            make.centerY.equalTo(contentBaseButton);
            
        }];
        
        UIButton *contentButton = [[UIButton alloc]init];
        [contentButton setTitle:@"选择" forState:UIControlStateNormal];
        contentButton.titleLabel.font = [UIFont systemFontOfSize:15];
        contentButton.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        contentButton.layer.cornerRadius = 14;
        [contentBaseButton addSubview:contentButton];
        [contentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(contentBaseButton).offset(-25);
            make.centerY.equalTo(contentBaseButton);
            make.height.mas_offset(28);
            make.width.mas_offset(70);
        }];
        contentButton.tag = i;
        [contentButton addTarget:self action:@selector(scrollViewPackageSelectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_packageSelectButtonArray addObject:contentButton];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSMutableDictionary *dataDictionary = [userDefaults objectForKey:@"homeOrderData"];
        NSArray *packageIdArray;
        if (dataDictionary){
            ICLog(@"---存储的数据---dataDictionary--%@----", dataDictionary);
            packageIdArray = dataDictionary[@"packageIdArray"];
            if (packageIdArray){
                self.selectPackageIdArray = [[NSMutableArray alloc]initWithArray:packageIdArray];
            }
        }
        if ([packageIdArray containsObject:productModel.idString]){
            [contentButton setTitle:@"已选择" forState:UIControlStateNormal];
            contentButton.selected = YES;
            [contentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            contentButton.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
            [self.selectPackageArray addObject:productModel];
            ICLog(@"-----self.selectPackageArray----%@---", self.selectPackageArray);
        }
        
        
        
    }
    
}

#pragma mark - 选择套餐按钮相应方法
- (void)scrollViewPackageSelectBtnClick:(UIButton *)button{
    ICLog(@"选择套餐按钮相应方法");
    [self.view endEditing:YES];
    if (button.selected == YES){
        button.selected = NO;
        [button setTitle:@"选择" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
//        _selectPackageIndex = -5;
        CLProductPackageModel *packageModel = self.packageArray[button.tag];
        [_selectPackageArray removeObject:packageModel];
        [_selectPackageIdArray removeObject:packageModel.idString];
        return;
    }
    
//    if (_selectPackageIndex > -1){
//        UIButton *selectButton = _packageSelectButtonArray[_selectPackageIndex];
//        [selectButton setTitle:@"选择" forState:UIControlStateNormal];
//        [selectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        selectButton.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
//    }
    [button setTitle:@"已选择" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    button.selected = YES;
//    _selectPackageIndex = button.tag;
    CLProductPackageModel *packageModel = self.packageArray[button.tag];
//    _selectPackageModel = packageModel;
    [_selectPackageArray addObject:packageModel];
    [_selectPackageIdArray addObject:packageModel.idString];
    
    [self saveOrderData];
}



//选择套餐与项目切换按钮相应方法
- (void)packageBaseViewChangeBtnClick{
    [self.view endEditing:YES];
    if([_packageBaseViewChangeButton.titleLabel.text isEqualToString:@"选择套餐"]){
        [_packageBaseViewChangeButton setTitle:@"选择项目" forState:UIControlStateNormal];
        [_showSelectProductButton setTitle:@"已选套餐" forState:UIControlStateNormal];
        [self getPackageList];
        _packageScrollView.hidden = NO;
    }else{
        [_packageBaseViewChangeButton setTitle:@"选择套餐" forState:UIControlStateNormal];
        _packageScrollView.hidden = YES;
        [_showSelectProductButton setTitle:@"已选项目" forState:UIControlStateNormal];
    }
    
}






//选择视同项目切换相应方法
- (void)selectPackageClassBtnClick:(UIButton *) button{
    [_selectPackageClassButtonArray enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    }];
    button.backgroundColor = [UIColor whiteColor];
    [self getProductList:button.tag];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
//    return 50;
        return self.productArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CLHomeProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil){
        cell = [[CLHomeProductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.contentButton.tag = indexPath.row;
    [cell.contentButton addTarget:self action:@selector(productSelectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if(self.productArray.count > indexPath.row){
        CLProductModel *productModel = self.productArray[indexPath.row];
        cell.contentTitleLabel.text = productModel.typeName;
        cell.contentValueLabel.text = productModel.constructionPositionName;
        if ([self.selectProductIdArray containsObject:productModel.idString]){
            ICLog(@"已存在");
            [cell.contentButton setTitle:@"已选择" forState:UIControlStateNormal];
            [cell.contentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            cell.contentButton.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        }else{
            ICLog(@"不存在");
            [cell.contentButton setTitle:@"选择" forState:UIControlStateNormal];
            [cell.contentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            cell.contentButton.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        }
    }
    
    
    
    
    
    
    return cell;
}


#pragma mark - 选择项目按钮相应方法
- (void)productSelectBtnClick:(UIButton *)button{
    [self.view endEditing:YES];
    if (_productArray.count > button.tag){
        CLProductModel *productModel = self.productArray[button.tag];
        if ([self.selectProductIdArray containsObject:productModel.idString]){
            ICLog(@"已存在");
            [self.selectProductIdArray removeObject:productModel.idString];
            [button setTitle:@"选择" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
            UILabel *iconLabel = _selectPackageClassLabelArray[_selectType];
            iconLabel.text = [NSString stringWithFormat:@"%d", [iconLabel.text intValue] - 1];
            if ([iconLabel.text intValue] < 1){
                iconLabel.hidden = YES;
            }
            __block NSInteger deleteIndex;
            [self.selectProductArray enumerateObjectsUsingBlock:^(CLProductModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.idString isEqualToString:productModel.idString]) {
                    deleteIndex = idx;
                    *stop = YES;
                    ICLog(@"-------");
                }
            }];
            [self.selectProductArray removeObjectAtIndex:deleteIndex];
            
        }else{
            ICLog(@"不存在");
            [self.selectProductIdArray addObject:productModel.idString];
            [button setTitle:@"已选择" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
            UILabel *iconLabel = _selectPackageClassLabelArray[_selectType];
            iconLabel.text = [NSString stringWithFormat:@"%d", [iconLabel.text intValue] + 1];
            iconLabel.hidden = NO;
            [self.selectProductArray addObject:productModel];
        }
    }
    
    
    [self saveOrderData];
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ICLog(@"查看施工项目详情");
    if (self.productArray.count > indexPath.row){
        [self showProductDetailView:self.productArray[indexPath.row]];
    }
}


- (void)showSelectProductBtnClick{
    if ([_showSelectProductButton.titleLabel.text isEqualToString:@"已选项目"]){
        if (self.selectProductArray.count < 1){
            [self addAlertView:@"请先选择项目"];
            return;
        }
        
        
        _showBgView = [[UIView alloc]init];
        _showBgView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        [self.view addSubview:_showBgView];
        [_showBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self.view);
        }];
        
        UIView *baseView = [[UIView alloc]init];
        baseView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        [_showBgView addSubview:baseView];
        [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.showBgView);
            make.height.mas_offset(400);
        }];
        
        UIView *titleBaseView = [[UIView alloc]init];
        titleBaseView.backgroundColor = [UIColor whiteColor];
        [baseView addSubview:titleBaseView];
        [titleBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(baseView);
            make.height.mas_offset(40);
        }];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"已选项目";
        titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [titleBaseView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleBaseView).offset(15);
            make.centerY.equalTo(titleBaseView);
        }];
        
        UIButton *showBgViewCancelButton = [[UIButton alloc]init];
        [showBgViewCancelButton setImage:[UIImage imageNamed:@"clb_xq_btn_close"] forState:UIControlStateNormal];
        [showBgViewCancelButton addTarget:self action:@selector(showBgViewCancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [titleBaseView addSubview:showBgViewCancelButton];
        [showBgViewCancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(titleBaseView).offset(-5);
            make.centerY.equalTo(titleBaseView).offset(0);
            make.width.mas_offset(40);
            make.height.mas_offset(40);
        }];
        
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.backgroundColor = [UIColor whiteColor];
        [baseView addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(baseView);
            make.top.equalTo(titleBaseView.mas_bottom).offset(15);
        }];
        
        
        for (int i = 0; i < self.selectProductArray.count; i++) {
            CLPackageProductTableViewCell *cell = [[CLPackageProductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            [scrollView addSubview:cell];
            cell.productModel = self.selectProductArray[i];
            cell.frame = CGRectMake(0, 130 * i, self.view.frame.size.width, 130);
        }
        
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 130 * self.selectProductArray.count);
        scrollView.contentOffset = CGPointMake(0, -100);
    }else{
        if (self.selectPackageIdArray.count < 1){
            [self addAlertView:@"请先选择套餐"];
            return;
        }
        
        _showBgView = [[UIView alloc]init];
        _showBgView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        [self.view addSubview:_showBgView];
        [_showBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self.view);
        }];
        
        UIView *baseView = [[UIView alloc]init];
        baseView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        [_showBgView addSubview:baseView];
        [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.showBgView);
            make.height.mas_offset(150);
        }];
        
        UIView *titleBaseView = [[UIView alloc]init];
        titleBaseView.backgroundColor = [UIColor whiteColor];
        [baseView addSubview:titleBaseView];
        [titleBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(baseView);
            make.height.mas_offset(40);
        }];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"已选套餐";
        titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [titleBaseView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleBaseView).offset(15);
            make.centerY.equalTo(titleBaseView);
        }];
        
        UIButton *showBgViewCancelButton = [[UIButton alloc]init];
        [showBgViewCancelButton setImage:[UIImage imageNamed:@"clb_xq_btn_close"] forState:UIControlStateNormal];
        [showBgViewCancelButton addTarget:self action:@selector(showBgViewCancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [titleBaseView addSubview:showBgViewCancelButton];
        [showBgViewCancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(titleBaseView).offset(-5);
            make.centerY.equalTo(titleBaseView).offset(0);
            make.width.mas_offset(40);
            make.height.mas_offset(40);
        }];
        
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.backgroundColor = [UIColor whiteColor];
        [_showBgView addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(baseView);
            make.top.equalTo(titleBaseView.mas_bottom).offset(15);
        }];
        
        for (int i = 0; i < self.selectPackageArray.count; i++) {
            
            UIButton *contentBaseButton = [[UIButton alloc]init];
            contentBaseButton.backgroundColor = [UIColor whiteColor];
            [scrollView addSubview:contentBaseButton];
            contentBaseButton.frame = CGRectMake(0, 0 + i * 45, self.view.frame.size.width, 45);
            
            CLProductPackageModel *productModel = self.selectPackageArray[i];
            
            UILabel *contentTitleLabel = [[UILabel alloc]init];
//            contentTitleLabel.text = [NSString stringWithFormat:@"套餐%d", i + 1];
            contentTitleLabel.text = productModel.name;
//            contentTitleLabel.text = _selectPackageModel.name;
            [contentBaseButton addSubview:contentTitleLabel];
            [contentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(contentBaseButton).offset(25);
                make.centerY.equalTo(contentBaseButton);
            }];
            
//            UIButton *contentButton = [[UIButton alloc]init];
//            [contentButton setTitle:@"移除" forState:UIControlStateNormal];
//            contentButton.titleLabel.font = [UIFont systemFontOfSize:15];
//            contentButton.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
//            contentButton.layer.cornerRadius = 14;
//            [contentBaseButton addSubview:contentButton];
//            [contentButton mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.right.equalTo(contentBaseButton).offset(-25);
//                make.centerY.equalTo(contentBaseButton);
//                make.height.mas_offset(28);
//                make.width.mas_offset(70);
//            }];
        }
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 45 * 10);
        scrollView.contentOffset = CGPointMake(0, -100);
    }
    
    
}



//查看套餐详情
- (void)packageBaseViewBtnClick:(UIButton *)button{
    if (self.packageArray.count > button.tag){
        CLProductPackageModel *packageModel = self.packageArray[button.tag];
        [self getPackageDetail:packageModel];
    }
    
}

- (void)setPackageDetailForView:(CLProductPackageModel *)packageModel{
    _showBgView = [[UIView alloc]init];
    _showBgView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [self.view addSubview:_showBgView];
    [_showBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    
    UIView *baseView = [[UIView alloc]init];
    baseView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    [_showBgView addSubview:baseView];
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.showBgView);
        make.height.mas_offset(400);
    }];
    
    UIView *titleBaseView = [[UIView alloc]init];
    titleBaseView.backgroundColor = [UIColor whiteColor];
    [baseView addSubview:titleBaseView];
    [titleBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(baseView);
        make.height.mas_offset(40);
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = packageModel.name;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [titleBaseView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleBaseView).offset(15);
        make.centerY.equalTo(titleBaseView);
    }];
    
    UIButton *showBgViewCancelButton = [[UIButton alloc]init];
    [showBgViewCancelButton setImage:[UIImage imageNamed:@"clb_xq_btn_close"] forState:UIControlStateNormal];
    [showBgViewCancelButton addTarget:self action:@selector(showBgViewCancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [titleBaseView addSubview:showBgViewCancelButton];
    [showBgViewCancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(titleBaseView).offset(-5);
        make.centerY.equalTo(titleBaseView).offset(0);
        make.width.mas_offset(40);
        make.height.mas_offset(40);
    }];
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.backgroundColor = [UIColor whiteColor];
    [baseView addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(baseView);
        make.top.equalTo(titleBaseView.mas_bottom).offset(15);
    }];
    
    
    for (int i = 0; i < _packageProductArray.count; i++) {
        CLPackageProductTableViewCell *cell = [[CLPackageProductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [scrollView addSubview:cell];
        cell.productModel = _packageProductArray[i];
        cell.frame = CGRectMake(0, 130 * i, self.view.frame.size.width, 130);
    }
    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 130 * _packageProductArray.count);
    scrollView.contentOffset = CGPointMake(0, -100);
}





//查看项目详情
- (void)showProductDetailView:(CLProductModel *)productModel{
    
    _showBgView = [[UIView alloc]init];
    _showBgView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [self.view addSubview:_showBgView];
    [_showBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    
    UIView *baseView = [[UIView alloc]init];
    baseView.backgroundColor = [UIColor whiteColor];
    [_showBgView addSubview:baseView];
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.showBgView);
        make.height.mas_offset(180);
    }];
    
    CLPackageProductTableViewCell *cell = [[CLPackageProductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    [baseView addSubview:cell];
    cell.productModel = productModel;
    [cell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(baseView);
        make.top.equalTo(baseView).offset(30);
        make.height.mas_offset(130);
    }];
    
    UIButton *showBgViewCancelButton = [[UIButton alloc]init];
    [showBgViewCancelButton setImage:[UIImage imageNamed:@"clb_xq_btn_close"] forState:UIControlStateNormal];
    [showBgViewCancelButton addTarget:self action:@selector(showBgViewCancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [baseView addSubview:showBgViewCancelButton];
    [showBgViewCancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(baseView).offset(-5);
        make.top.equalTo(baseView).offset(5);
        make.width.mas_offset(40);
        make.height.mas_offset(40);
    }];
    
    
}

//移除弹出框
- (void)showBgViewCancelBtnClick{
    [_showBgView removeFromSuperview];
    _showBgView = nil;
}




- (void)setViewForBase{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *orderByPhotoString = [userDefaults objectForKey:@"cooperatorOrderByPhoto"];
    if ([orderByPhotoString isEqualToString:@"1"]){
        ICLog(@"支持数据下单");
        
    }else{
        ICLog(@"不支持数据下单");
        return;
    }
    
    
    UIView *headerBaseView = [[UIView alloc]init];
    headerBaseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerBaseView];
    [headerBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_navView.mas_bottom);
        make.height.mas_offset(40);
    }];
    
    // 主负责人
    UIButton *mainBut = [UIButton buttonWithType:UIButtonTypeCustom];
    mainBut.frame = CGRectMake(0, 0, self.view.frame.size.width / 2.0, 40);
    mainBut.titleLabel.font = [UIFont boldSystemFontOfSize:14 / 320.0 * kWidth];
    [mainBut setTitle:@"数据下单" forState:UIControlStateNormal];
    [mainBut setTitleColor:[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] forState:UIControlStateNormal];
    [mainBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateSelected];
    mainBut.selected = YES;
    [headerBaseView addSubview:mainBut];
    [mainBut addTarget:self action:@selector(renButClick:) forControlEvents:UIControlEventTouchUpInside];
    mainBut.tag = 1000;
    mainBut.userInteractionEnabled = NO;
    // 次负责人
    UIButton *otherBut = [UIButton buttonWithType:UIButtonTypeCustom];
    otherBut.frame = CGRectMake(CGRectGetMaxX(mainBut.frame), 0, kWidth / 2.0, 40);
    otherBut.titleLabel.font = [UIFont boldSystemFontOfSize:14 / 320.0 * kWidth];
    [otherBut setTitle:@"拍照下单" forState:UIControlStateNormal];
    [otherBut setTitleColor:[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] forState:UIControlStateNormal];
    [otherBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateSelected];
    [headerBaseView addSubview:otherBut];
    [otherBut addTarget:self action:@selector(renButClick:) forControlEvents:UIControlEventTouchUpInside];
    otherBut.tag = 2000;
    // 边线
    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 40 - 1, kWidth, 1)];
    vv.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [headerBaseView addSubview:vv];
    // 下划线
    NSString *proStr = @"数据下单";
    NSMutableDictionary *proDic = [[NSMutableDictionary alloc] init];
    proDic[NSFontAttributeName] = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    proDic[NSForegroundColorAttributeName] = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    CGRect proRect = [proStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:proDic context:nil];
    CGFloat lineViewW = proRect.size.width + 20;
    CGFloat lineViewH = 1.5;
    CGFloat lineViewX = (kWidth / 2.0 - lineViewW) / 2.0;
//    CGFloat lineViewY = CGRectGetMaxY(headerBaseView.frame) - lineViewH;
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(lineViewX, 35, lineViewW, lineViewH)];
    self.lineView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [headerBaseView addSubview:self.lineView];
    
    
}

- (void)renButClick:(UIButton *)sender {
    
    sender.selected = YES;
    
    if(sender.tag == 1000) {
        
        
        UIButton *but = (UIButton *)[self.view viewWithTag:2000];
        but.selected = NO;
        
        but.userInteractionEnabled = YES;
        sender.userInteractionEnabled = NO;
        
        self.photoOrderBaseView.hidden = YES;
        self.dataOrderBaseView.hidden = NO;
        
    }else {
        
        UIButton *but = (UIButton *)[self.view viewWithTag:1000];
        but.selected = NO;
        
        
        but.userInteractionEnabled = YES;
        sender.userInteractionEnabled = NO;
        

        self.photoOrderBaseView.hidden = NO;
        self.dataOrderBaseView.hidden = YES;
    }
    
    CGFloat centerX = sender.center.x;
    CGPoint oriPoint = self.lineView.center;
    oriPoint.x = centerX;
    [UIView animateWithDuration:0.5 animations:^{
        self.lineView.center = oriPoint;
    }];
    
    
    
    
}





#pragma mark - 注册通知中心
- (void)NSNotificationCenter{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getListUnfinished) name:@"FINISHED" object:nil];
}

- (void)_setBase {
    
    
    
    self.view.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    
    
    
    // 导航栏
    _navView = [[GFNavigationView alloc] initWithLeftImgName:@"person" withLeftImgHightName:@"personClick" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"车邻邦" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [_navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
    [self.view bringSubviewToFront:_navView];
    
    
}

#pragma mark - 获取商户未完成订单
- (void)getListUnfinished{
//    self.baseView.frame = CGRectMake(0, 0, kWidth, baseViewHH);
//    self.scrollerView.contentSize = CGSizeMake(0, baseViewHH+50);
//    _tipButton.hidden = YES;
//    [self.scrollerView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_navView.mas_bottom).offset(0);
//    }];
//
//    return;
    
    /*
    [GFHttpTool dingdanPostWithDictionary:@{@"page":@"1",@"pageSize":@"1",@"status":@"1"} success:^(id responseObject) {
        
        
        ICLog(@"------%@", responseObject);
        
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
        
        
        ICLog(@"------%@", error);
    }];
    */
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



- (void)setPhotoOrderView {
    
    
    _photoOrderBaseView = [[UIView alloc]init];
    [self.view addSubview:_photoOrderBaseView];
    [_photoOrderBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(_navView.mas_bottom).offset(60);
    }];
    _photoOrderBaseView.clipsToBounds = YES;
    
    
    
    
    
//    [self getListUnfinished];
    
    self.scrollerView = [[CLTouchScrollView alloc] init];
    self.scrollerView.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    //    self.scrollerView.frame = CGRectMake(0, 64-kHeight * 0.0625-20, kWidth, kHeight - 44+kHeight * 0.0625);
//    self.scrollerView.frame = CGRectMake(0, 64, kWidth, kHeight - 44);
//    self.scrollerView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.scrollerView.contentSize = CGSizeMake(0, 1050);
    self.scrollerView.showsHorizontalScrollIndicator = NO;
    self.scrollerView.showsVerticalScrollIndicator = NO;
    [_photoOrderBaseView addSubview:self.scrollerView];
    [_photoOrderBaseView sendSubviewToBack:self.scrollerView];
    [self.scrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(_photoOrderBaseView);
        make.top.equalTo(_photoOrderBaseView).offset(-50);
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
        
        if (self.photoOrderBaseView.hidden == YES){  //数据下单
            if (self.shijianNum == 1){
                _orderDataBeginTimeTextField.text = date;
            }else if(self.shijianNum == 2){
                _orderDataEndTimeTextField.text = date;
            }
        }else{  //拍照下单
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


#pragma mark - 一键存储按钮
- (void)saveOrderData{
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc]init];
    if(_orderDataVinTextField.text.length >0){
        dataDictionary[@"license"] = _orderDataCarLicenseTextField.text;
    }
    if(_orderDataVinTextField.text.length > 0){
        dataDictionary[@"vin"] = _orderDataVinTextField.text;
    }
    if (_orderDataCarTypeTextField.text.length > 0){
        dataDictionary[@"vehicleModel"] = _orderDataCarTypeTextField.text;
    }
    if (_orderDataBeginTimeTextField.text.length > 0){
        dataDictionary[@"agreedStartTime"] = _orderDataBeginTimeTextField.text;
    }
    if (_orderDataEndTimeTextField.text.length > 0){
        dataDictionary[@"agreedEndTime"] = _orderDataEndTimeTextField.text;
    }
    
    ICLog(@"---selectProductIdArray----%@----", _selectProductIdArray);
    
//    if (self.selectProductIdArray.count > 0){
//        NSString *offerIdString = @"";
//        for (int i = 0; i < self.selectProductIdArray.count; i++) {
//            if (i == 0){
//                offerIdString = self.selectProductIdArray[0];
//            }else{
//                offerIdString = [NSString stringWithFormat:@"%@,%@", offerIdString, self.selectProductIdArray[i]];
//            }
//        }
        dataDictionary[@"offerIds"] = self.selectProductIdArray;
//    }
    ICLog(@"---_selectPackageIndex----%ld----", (long)_selectPackageIndex);
    if (self.selectPackageIdArray.count > 0){
//        CLProductPackageModel *packageModel = self.packageArray[_selectPackageIndex];
        dataDictionary[@"packageIdArray"] = self.selectPackageIdArray;
    }
    
    NSMutableArray *labelStringArray = [[NSMutableArray alloc]init];
    [_selectPackageClassLabelArray enumerateObjectsUsingBlock:^(UILabel *objLabel, NSUInteger idx, BOOL * _Nonnull stop) {
        [labelStringArray addObject:objLabel.text];
    }];
    dataDictionary[@"labelStringArray"] = labelStringArray;
    
    ICLog(@"-存储字段---dataDictionary----%@----", dataDictionary);
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:dataDictionary forKey:@"homeOrderData"];
    
}


#pragma mark - 数据一键下单按钮相应方法
- (void)orderDataSubmitBtnClick{
    if(_orderDataVinTextField.text.length < 1){
        [self addAlertView:@"请填写车架号"];
        return;
    }else if(_orderDataVinTextField.text.length != 7){
        [self addAlertView:@"请填写车架号后七位"];
        return;
    }else if (_orderDataCarTypeTextField.text.length < 1){
        [self addAlertView:@"请填写车型"];
        return;
    }else if (_orderDataBeginTimeTextField.text.length < 1){
        [self addAlertView:@"请选择预约开始时间"];
        return;
    }else if (_orderDataEndTimeTextField.text.length < 1){
        [self addAlertView:@"请选择最迟交车时间"];
        return;
    }
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
    if (_packageScrollView == nil || _packageScrollView.hidden == YES){  //选择项目
        if (self.selectProductIdArray.count < 1){
            [self addAlertView:@"请选择施工项目"];
            return;
        }
        NSString *offerIdString = @"";
        for (int i = 0; i < self.selectProductIdArray.count; i++) {
            if (i == 0){
                offerIdString = self.selectProductIdArray[0];
            }else{
                offerIdString = [NSString stringWithFormat:@"%@,%@", offerIdString, self.selectProductIdArray[i]];
            }
        }
        dataDict[@"offerIds"] = offerIdString;
        
    } else {    //选择套餐
//        if (_selectPackageIndex < 0){
//            [self addAlertView:@"请选择套餐"];
//            return;
//        }
//        CLProductPackageModel *packageModel = self.packageArray[_selectPackageIndex];
//        dataDict[@"offerIds"] = packageModel.productOfferIds;
        
        if (self.selectPackageIdArray.count < 1){
            [self addAlertView:@"请选择套餐"];
            return;
        }
        NSString *menuIdString = @"";
        for (int i = 0; i < self.selectPackageIdArray.count; i++) {
            if (i == 0){
                menuIdString = self.selectPackageIdArray[0];
            }else{
                menuIdString = [NSString stringWithFormat:@"%@,%@", menuIdString, self.selectPackageIdArray[i]];
            }
        }
        dataDict[@"setMenuIds"] = menuIdString;
        
    }
    dataDict[@"vin"] = _orderDataVinTextField.text;
    if (_orderDataCarLicenseTextField.text.length > 1){
        dataDict[@"license"] = _orderDataCarLicenseTextField.text;
    }
    dataDict[@"vehicleModel"] = _orderDataCarTypeTextField.text;
    dataDict[@"agreedStartTime"] = _orderDataBeginTimeTextField.text;
    dataDict[@"agreedEndTime"] = _orderDataEndTimeTextField.text;
    ICLog(@"------dataDict-----%@----", dataDict);
    
    [GFHttpTool postCoopMerchantDataOrderWithParameters:dataDict success:^(id responseObject) {
        ICLog(@"---下单成功---%@---", responseObject);
        if ([responseObject[@"status"] integerValue] == 1){
            [self addAlertView:@"下单完成"];
            _orderDataVinTextField.text = @"";
            _orderDataCarLicenseTextField.text = @"";
            _orderDataCarTypeTextField.text = @"";
            _orderDataBeginTimeTextField.text = @"";
            _orderDataEndTimeTextField.text = @"";
            
            _selectPackageIndex = -5;
            _selectPackageModel = nil;
            [self.selectProductIdArray removeAllObjects];
            [self.selectProductArray removeAllObjects];
            [self.selectPackageIdArray removeAllObjects];
            [self.selectPackageArray removeAllObjects];
            [_selectPackageClassLabelArray enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.text = @"0";
                obj.hidden = YES;
            }];
            [_tableView reloadData];
            [_packageSelectButtonArray enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [obj setTitle:@"选择" forState:UIControlStateNormal];
                [obj setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                obj.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
            }];
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults removeObjectForKey:@"homeOrderData"];
            
        }else{
            [self addAlertView:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        ICLog(@"---error---%@---", error);
    }];
    
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
                ICLog(@"mDic---%@---",mDic);
                [GFHttpTool postOneIndentDictionary:mDic success:^(NSDictionary *responseObject) {
                    ICLog(@"下单返回数据-----%@---",responseObject);
                    if ([responseObject[@"status"] integerValue] == 1) {
                        
                        if(_appointButton.selected) {
                            GFIndentViewController *indentVC = [[GFIndentViewController alloc]init];
                            [self.navigationController pushViewController:indentVC animated:YES];
                            
                        }else {
                            GFAlertView *alertView = [[GFAlertView alloc]initWithMiao:3.0];
                            UIWindow *winndow = [UIApplication sharedApplication].keyWindow;
                            [winndow addSubview:alertView];
                            
                            
                            ICLog(@"-滚动视图的打印--%@---", NSStringFromCGRect(self.scrollerView.frame));
                        }
                        
                        
                        for(UIView *mylabelview in [self.view subviews]) {
                            
                            [mylabelview removeFromSuperview];
                        }
                        //
                        [self viewDidLoad];
                        //                            self.scrollerView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
                        //                            [self.navigationController popToRootViewControllerAnimated:YES];
                        
                        
                        
                        
                        
                    }
                } failure:^(NSError *error) {
                    
                    ICLog(@"－－－下单失败---%@----",error);
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
    
    /*
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
    */
    
    self.manager = nil;
    [self directGoPhotoViewController];
//    [self goAlbumBtnClick];
}


- (void)directGoPhotoViewController {
    HXAlbumListViewController *vc = [[HXAlbumListViewController alloc] init];
    vc.manager = self.manager;
    vc.delegate = self;
    HXCustomNavigationController *nav = [[HXCustomNavigationController alloc] initWithRootViewController:vc];
    nav.supportRotation = self.manager.configuration.supportRotation;
    [self presentViewController:nav animated:YES completion:nil];
}



- (void)albumListViewController:(HXAlbumListViewController *)albumListViewController didDoneAllImage:(NSArray<UIImage *> *)imageList{
    NSSLog(@"%@",imageList);
    [imageList enumerateObjectsUsingBlock:^(UIImage* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self updataImage:obj];
    }];
}


- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
        _manager.configuration.openCamera = YES;
        _manager.configuration.lookLivePhoto = YES;
        _manager.configuration.photoMaxNum = 6 - self.photoImgArr.count;
        _manager.configuration.videoMaxNum = 1;
        _manager.configuration.maxNum = 10;
        _manager.configuration.videoMaxDuration = 500.f;
        _manager.configuration.saveSystemAblum = NO;
        //        _manager.configuration.reverseDate = YES;
        _manager.configuration.showDateSectionHeader = NO;
        _manager.configuration.selectTogether = NO;
        //        _manager.configuration.rowCount = 3;
        //        _manager.configuration.movableCropBox = YES;
        //        _manager.configuration.movableCropBoxEditSize = YES;
        //        _manager.configuration.movableCropBoxCustomRatio = CGPointMake(1, 1);
        _manager.configuration.requestImageAfterFinishingSelection = YES;
        __weak typeof(self) weakSelf = self;
        //        _manager.configuration.replaceCameraViewController = YES;
        _manager.configuration.shouldUseCamera = ^(UIViewController *viewController, HXPhotoConfigurationCameraType cameraType, HXPhotoManager *manager) {
            
            // 这里拿使用系统相机做例子
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = (id)weakSelf;
            imagePickerController.allowsEditing = NO;
            NSString *requiredMediaTypeImage = ( NSString *)kUTTypeImage;
            NSString *requiredMediaTypeMovie = ( NSString *)kUTTypeMovie;
            NSArray *arrMediaTypes;
            if (cameraType == HXPhotoConfigurationCameraTypePhoto) {
                arrMediaTypes=[NSArray arrayWithObjects:requiredMediaTypeImage,nil];
            }else if (cameraType == HXPhotoConfigurationCameraTypeVideo) {
                arrMediaTypes=[NSArray arrayWithObjects:requiredMediaTypeMovie,nil];
            }else {
                arrMediaTypes=[NSArray arrayWithObjects:requiredMediaTypeImage, requiredMediaTypeMovie,nil];
            }
            [imagePickerController setMediaTypes:arrMediaTypes];
            // 设置录制视频的质量
            [imagePickerController setVideoQuality:UIImagePickerControllerQualityTypeHigh];
            //设置最长摄像时间
            [imagePickerController setVideoMaximumDuration:60.f];
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            imagePickerController.modalPresentationStyle=UIModalPresentationOverCurrentContext;
            [viewController presentViewController:imagePickerController animated:YES completion:nil];
        };
    }
    return _manager;
}


- (void)goAlbumBtnClick {
//    self.manager.configuration.clarityScale = 0.8;//小图清晰度
    self.manager.configuration.themeColor = self.view.tintColor; //主题颜色
    self.manager.configuration.cellSelectedTitleColor = nil;
    self.manager.configuration.navBarBackgroudColor = nil; //导航栏背景颜色
    self.manager.configuration.statusBarStyle = UIStatusBarStyleDefault;
    self.manager.configuration.sectionHeaderTranslucent = YES;
    self.bottomViewBgColor = nil;
    self.manager.configuration.cellSelectedBgColor = nil;
    self.manager.configuration.selectedTitleColor = nil;
    self.manager.configuration.sectionHeaderSuspensionBgColor = nil;
    self.manager.configuration.sectionHeaderSuspensionTitleColor = nil;
    self.manager.configuration.navigationTitleColor = nil;//导航栏标题颜色
    self.manager.configuration.hideOriginalBtn = NO;
    self.manager.configuration.filtrationICloudAsset = NO;
    self.manager.configuration.photoMaxNum = 6;
    self.manager.configuration.videoMaxNum = 0;
    self.manager.configuration.rowCount = 3;
    self.manager.configuration.downloadICloudAsset = NO;
    self.manager.configuration.saveSystemAblum = YES;
    self.manager.configuration.showDateSectionHeader = NO;
    self.manager.configuration.reverseDate = NO;
    self.manager.configuration.navigationTitleSynchColor = NO;
    self.manager.configuration.replaceCameraViewController = NO;
    self.manager.configuration.openCamera = YES;
    [self hx_presentAlbumListViewControllerWithManager:self.manager done:^(NSArray<HXPhotoModel *> *allList, NSArray<HXPhotoModel *> *photoList, NSArray<HXPhotoModel *> *videoList, BOOL original, HXAlbumListViewController *viewController) {
        ICLog(@"all - %@",allList);
        ICLog(@"photo - %@",photoList);
        
        
        [photoList enumerateObjectsUsingBlock:^(HXPhotoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            [self updataImage:obj.previewPhoto];
            [self updataImage:obj.thumbPhoto];
        }];
        
    } cancel:^(HXAlbumListViewController *viewController) {
        ICLog(@"取消了");
    }];
}



#pragma mark - 图片协议方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
    [self dismissViewControllerAnimated:YES completion:nil];

    [self updataImage:image];
    
    
}


- (void)updataImage:(UIImage *)image{
    
    GFImageView *imgView = [[GFImageView alloc] init];
    
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
    
    
    
    self.imgView.hidden = YES;
    self.cameraBtn.hidden = YES;
    
    
    
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
        
        ICLog(@"上传成功－－%@--",responseObject);
        if ([responseObject[@"status"] integerValue] == 1) {
            
            
            
            _isUpOrderImage = YES;
            [_dataDictionary setObject:responseObject[@"message"] forKey:@"photo"];
            [self.photoUrlArr addObject:responseObject[@"message"]];
            [self.photoImgArr addObject:image];
            [self.photoImgViewArr addObject:imgView];
            
            
            imgView.frame = CGRectMake((([UIScreen mainScreen].bounds.size.width - 40) / 3.0 + 10) * (self.photoIndex % 3) + 10, CGRectGetMaxY(self.msgView.frame) + 10 + (([UIScreen mainScreen].bounds.size.width - 40) / 3.0 + 10) * (self.photoIndex / 3), ([UIScreen mainScreen].bounds.size.width - 40) / 3.0, ([UIScreen mainScreen].bounds.size.width - 40) / 3.0);
            self.addPhotoBut.frame = CGRectMake((([UIScreen mainScreen].bounds.size.width - 40) / 3.0 + 10) * ((self.photoIndex + 1) % 3) + 10, CGRectGetMaxY(self.msgView.frame) + 10 + (([UIScreen mainScreen].bounds.size.width - 40) / 3.0 + 10) * ((self.photoIndex + 1) / 3), ([UIScreen mainScreen].bounds.size.width - 40) / 3.0, ([UIScreen mainScreen].bounds.size.width - 40) / 3.0);
            
            
            if(self.photoIndex == 5) {
                
                self.addPhotoBut.hidden = YES;
            }
            
            self.photoIndex += 1;
            
            ICLog(@"----%@==", self.photoUrlArr);
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
        ICLog(@"上传失败－－%@---",error);
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





// 获取产品列表
- (void)getProductList:(NSInteger )type{
    ICLog(@"获取产品列表");
    [self.view endEditing:YES];
//    type  1 隔热膜   2 隐形车衣   3 车身改色   4 美容清洁
    _productArray = [[NSMutableArray alloc]init];
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
    dataDict[@"page"] = @(1);
    dataDict[@"pageSize"] = @(2000);
    if (type == 0){
        dataDict[@"type"] = @"1";
    }else if(type == 1){
        dataDict[@"type"] = @"4";
    }else if (type == 2){
        dataDict[@"type"] = @"2";
    }else if (type == 3){
        dataDict[@"type"] = @"3";
    }
    ICLog(@"----dataDict----%@----",dataDict);
    [GFHttpTool getProductOfferWithParameters:dataDict success:^(id responseObject) {
        ICLog(@"-getProductList--responseObject---%@-", responseObject);
        if ([responseObject[@"status"] integerValue] == 1) {
            NSDictionary *messageDictionary = responseObject[@"message"];
            NSArray *listArray = messageDictionary[@"list"];
            [listArray enumerateObjectsUsingBlock:^(NSDictionary *modelDic, NSUInteger idx, BOOL * _Nonnull stop) {
                CLProductModel *productModel = [[CLProductModel alloc]init];
                [productModel setModelForDictionary:modelDic];
                [_productArray addObject:productModel];
            }];
        }
        [_tableView reloadData];
        _selectType = type;
    } failure:^(NSError *error) {
        ICLog(@"-getProductList--error---%@-", error);
    }];
    
}

// 获取产品列表
- (void)getAllProductList{
    ICLog(@"获取产品列表");
    [self.view endEditing:YES];
    //    type  1 隔热膜   2 隐形车衣   3 车身改色   4 美容清洁
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
    dataDict[@"page"] = @(1);
    dataDict[@"pageSize"] = @(2000);
    
    ICLog(@"----dataDict----%@----",dataDict);
    [GFHttpTool getProductOfferWithParameters:dataDict success:^(id responseObject) {
        ICLog(@"-getProductList--responseObject---%@-", responseObject);
        if ([responseObject[@"status"] integerValue] == 1) {
            NSDictionary *messageDictionary = responseObject[@"message"];
            NSArray *listArray = messageDictionary[@"list"];
            [listArray enumerateObjectsUsingBlock:^(NSDictionary *modelDic, NSUInteger idx, BOOL * _Nonnull stop) {
                CLProductModel *productModel = [[CLProductModel alloc]init];
                [productModel setModelForDictionary:modelDic];
                if ([_selectProductIdArray containsObject:productModel.idString]) {
                    [_selectProductArray addObject:productModel];
                }
            }];
        }
    } failure:^(NSError *error) {
        ICLog(@"-getProductList--error---%@-", error);
    }];
    
}



// 获取套餐列表
- (void)getPackageList{
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
    dataDict[@"page"] = @(1);
    dataDict[@"pageSize"] = @(2000);
    _packageArray = [[NSMutableArray alloc]init];
    [GFHttpTool getProductOfferSetMenuWithParameters:dataDict success:^(id responseObject) {
        ICLog(@"-getProductList--responseObject---%@-", responseObject);
        if ([responseObject[@"status"] integerValue] == 1) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSMutableDictionary *dataDictionary = [userDefaults objectForKey:@"homeOrderData"];
            NSString *packageId;
            if (dataDictionary){
                ICLog(@"---存储的数据---dataDictionary--%@----", dataDictionary);
                packageId = dataDictionary[@"packageId"];
            }
            NSDictionary *messageDictionary = responseObject[@"message"];
            NSArray *listArray = messageDictionary[@"list"];
            [listArray enumerateObjectsUsingBlock:^(NSDictionary *modelDic, NSUInteger idx, BOOL * _Nonnull stop) {
                CLProductPackageModel *packageModel = [[CLProductPackageModel alloc]init];
                [packageModel setModelForDictionary:modelDic];
                [_packageArray addObject:packageModel];
                if ([packageId isEqualToString:packageModel.idString]){
                    _selectPackageIndex = idx;
                    _selectPackageModel = packageModel;
                    ICLog(@"---_selectPackageIndex--%ld----", _selectPackageIndex);
                }
            }];
            
            
            
            [self setPackageScrollBaseView];
            
        }
    } failure:^(NSError *error) {
        ICLog(@"-getProductList--error---%@-", error);
    }];
}

#pragma mark - 获取套餐详情
- (void)getPackageDetail:(CLProductPackageModel *)packageModel{
    [self.view endEditing:YES];
    self.packageProductArray = [[NSMutableArray alloc]init];
    [GFHttpTool getProductOfferSetMenuDetailWithOrderId:packageModel.idString success:^(id responseObject) {
        ICLog(@"-getProductDetail--responseObject---%@-", responseObject);
        if ([responseObject[@"status"] integerValue] == 1) {
            NSDictionary *messageDictionary = responseObject[@"message"];
            NSArray *productOfferArray = messageDictionary[@"productOffers"];
            if ([productOfferArray isKindOfClass:[NSNull class]]){
                [self addAlertView:@"清先添加施工项目"];
                return;
            }
            [productOfferArray enumerateObjectsUsingBlock:^(NSDictionary *modelDic, NSUInteger idx, BOOL * _Nonnull stop) {
                CLProductModel *productModel = [[CLProductModel alloc]init];
                [productModel setModelForDictionary:modelDic];
                [self.packageProductArray addObject:productModel];
            }];
        }
        
        [self setPackageDetailForView:packageModel];
    } failure:^(NSError *error) {
        ICLog(@"--getProductDetail-error---%@-", error);
    }];
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


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self.view endEditing:YES];
    
    UIButton *button = [[UIButton alloc]init];
    button.tag = textField.tag;
    [self xuanzeshijianClick:button];
    
    return NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
