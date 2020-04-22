//
//  GFDeNoindentViewController.m
//  CarMapB
//
//  Created by 陈光法 on 16/11/23.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFDeNoindentViewController.h"
#import "GFNavigationView.h"
#import "HZPhotoBrowser.h"
#import "UIButton+WebCache.h"
#import "GFTitleView.h"
#import "GFAnnotationView.h"
#import "MJRefresh.h"

#import <BaiduMapAPI_Base/BMKTypes.h>
#import "GFMapViewController.h"
#import "GFNoIndentModel.h"

#import "CLAddPersonViewController.h"
#import "GFHttpTool.h"

#import "GFNoIndentViewController.h"

#import "GFDetailPeoViewController.h"

#import "CLAddPersonModel.h"

#import "GFJishiDDViewController.h"
#import "GFTipView.h"


#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]


@interface GFDeNoindentViewController () <HZPhotoBrowserDelegate, BMKMapViewDelegate, BMKMapViewDelegate, BMKShareURLSearchDelegate,BMKGeoCodeSearchDelegate,BMKPoiSearchDelegate,BMKRouteSearchDelegate> {
    
    CGFloat kWidth;
    CGFloat kHieght;
    
    UIScrollView *_scrollView;
    
    GFNavigationView *_navView;
    NSDictionary *_orderDetailDict;
}

// 地图管理者
@property(nonatomic, strong) BMKMapManager *mapManager;
// 地图
@property (nonatomic, strong) BMKMapView *mapView;
// 技师大头针
@property (nonatomic, strong) GFAnnotation *jishiAnno;
// 商户大头针
@property (nonatomic, strong) GFAnnotation *shanghuAnno;


@property (nonatomic, strong) UIView *vv2;
@end

@implementation GFDeNoindentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
    kWidth = [UIScreen mainScreen].bounds.size.width;
    kHieght = [UIScreen mainScreen].bounds.size.height;
    
    // 添加导航
    [self setNavigation];
    
    
    
    [self getOrderDetail];
}

- (void)getOrderDetail{
    
    [GFHttpTool getOrderDetailOrderId:[self.model.orderID integerValue] success:^(id responseObject) {
        ICLog(@"获取订单详情成功----%@--", responseObject);
        NSString *statusString = [NSString stringWithFormat:@"%@", responseObject[@"status"]];
        if ([statusString isEqualToString:@"1"]){
            _orderDetailDict = responseObject[@"message"];
            // 界面布局
            [self _setDeInView];
        }
    } failure:^(NSError *error) {
        ICLog(@"获取订单详情失败----%@--", error);
    }];
    
}

- (void)jishixinxiClick {
    
//    NSLog(@"跳转到技师详情页面＝＝＝＝");
    NSInteger ID = [self.model.techId integerValue];
    [GFHttpTool getjishiDetailOrderId:ID success:^(id responseObject) {
        
//        NSLog(@"--技师详情--%@", responseObject);
        
        if([responseObject[@"status"] integerValue] == 1) {
        
            CLAddPersonModel *model = [[CLAddPersonModel alloc] initWithDictionary:responseObject[@"message"]];
//            GFDetailPeoViewController *deVC = [[GFDetailPeoViewController alloc] init];
            GFJishiDDViewController *deVC = [[GFJishiDDViewController alloc] init];
            deVC.model = model;
            
            [self.navigationController pushViewController:deVC animated:YES];
        }
        
//        printf(@"====%s", responseObject);
        
        
        
//        deVC.model
    } failure:^(NSError *error) {
        
        
    }];
}

// 界面布局
- (void)_setDeInView{
    
    if([self.model.techLatitude floatValue] == 0 && [self.model.techLongitude floatValue] == 0) {
        self.jishi = @"无";
    }
    
    
    UIView *mapBaseView = [[UIView alloc] init];
    mapBaseView.layer.borderWidth = 1;
    mapBaseView.layer.borderColor = [[UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1] CGColor];
    mapBaseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mapBaseView];
    
    [mapBaseView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_navView.mas_bottom).offset(6);
        make.height.mas_offset(230);
    }];
    
    //  技师位置
    GFTitleView *kejiView = [[GFTitleView alloc] initWithY:0 Title:@"技师信息"];
    [mapBaseView addSubview:kejiView];
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 10, kejiView.frame.size.height);
    but.backgroundColor = [UIColor clearColor];
    but.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [but setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(jishixinxiClick) forControlEvents:UIControlEventTouchUpInside];
    [kejiView addSubview:but];
    // 添加地图
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(1, CGRectGetMaxY(kejiView.frame) - 1, [UIScreen mainScreen].bounds.size.width, 230 - [UIScreen mainScreen].bounds.size.height * 0.0782)];
    self.mapView.delegate = self;
    [self.mapView setMapType:BMKMapTypeStandard];   // 地图类型
    self.mapView.userTrackingMode = BMKUserTrackingModeFollow;  // 跟随模式
    //    [self.mapView setZoomLevel:13];
    [mapBaseView addSubview:self.mapView];
    
    ICLog(@"===%f,,,%f", [self.model.techLatitude floatValue], [self.model.techLongitude floatValue]);
    

    if([self.model.techLatitude floatValue] == 0 && [self.model.techLongitude floatValue] == 0) {
    
        // 商户大头针
        self.shanghuAnno = [[GFAnnotation alloc] init];
        self.shanghuAnno.iconImgName = @"location";
        self.shanghuAnno.coordinate = CLLocationCoordinate2DMake([self.model.latitude floatValue], [self.model.longitude floatValue]);
        [self.mapView addAnnotation:self.shanghuAnno];
        _mapView.zoomLevel = 13;
        
        /*
        UILabel *lab = [[UILabel alloc] init];
        lab.backgroundColor = [UIColor orangeColor];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = @"暂无技师位置信息";
        lab.textColor = [UIColor whiteColor];
        [self.view addSubview:lab];
        
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(10);
            make.top.equalTo(kejiView.mas_bottom).offset(10);
            make.width.mas_offset(150);
            make.height.mas_offset(40);
        }];
        */
        
        self.mapView.centerCoordinate = self.shanghuAnno.coordinate;
    }else {
    
        // 添加大头针
        self.jishiAnno = [[GFAnnotation alloc] init];
        self.jishiAnno.iconImgName = @"mmm";
        self.jishiAnno.coordinate = CLLocationCoordinate2DMake([self.model.techLatitude floatValue], [self.model.techLongitude floatValue]);
        [self.mapView addAnnotation:self.jishiAnno];
        // 商户大头针
        self.shanghuAnno = [[GFAnnotation alloc] init];
        self.shanghuAnno.iconImgName = @"location";
        self.shanghuAnno.coordinate = CLLocationCoordinate2DMake([self.model.latitude floatValue], [self.model.longitude floatValue]);
        [self.mapView addAnnotation:self.shanghuAnno];
        // 设置地图中心
        CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(([self.model.techLatitude floatValue] - [self.model.latitude floatValue]) / 2.0, ([self.model.techLongitude floatValue] - [self.model.longitude floatValue]) / 2.0);
        self.mapView.centerCoordinate = centerCoordinate;
        self.mapView.centerCoordinate = self.jishiAnno.coordinate;
        BMKCoordinateRegion region ;//表示范围的结构体
        region.center = CLLocationCoordinate2DMake((self.jishiAnno.coordinate.latitude + self.shanghuAnno.coordinate.latitude)/2,(self.jishiAnno.coordinate.longitude + self.shanghuAnno.coordinate.longitude)/2);//中心点
        region.span.latitudeDelta = (self.jishiAnno.coordinate.latitude - self.shanghuAnno.coordinate.latitude)*2;//经度范围（设置为0.1表示显示范围为0.2的纬度范围）
        region.span.longitudeDelta = (self.jishiAnno.coordinate.latitude - self.shanghuAnno.coordinate.latitude)*2;//纬度范围
        [_mapView setRegion:region animated:YES];
        _mapView.zoomLevel = _mapView.zoomLevel - 0.3;
    }
    
    
    _scrollView = [[UIScrollView alloc] init];
//    _scrollView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(mapBaseView.mas_bottom);
        if([self.jishi isEqualToString:@"无"]) {
            mapBaseView.hidden = YES;
            make.top.equalTo(_navView.mas_bottom);
        }
    }];
    
    
    
    
    
    NSString *fenStr = [NSString stringWithFormat:@"下单备注：%@", self.model.remark];
    NSMutableDictionary *fenDic = [[NSMutableDictionary alloc] init];
    fenDic[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    fenDic[NSForegroundColorAttributeName] = [UIColor blackColor];
    CGRect fenRect = [fenStr boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fenDic context:nil];
    CGFloat ff = fenRect.size.height - 30.0;
    CGFloat a;
    if(ff >= 0) {
    
        a = fenRect.size.height;
    }else {
        
        a = 30;
    }
    
    UIView *orderDetailBaseView = [[UIView alloc] init];
    orderDetailBaseView.layer.borderWidth = 1;
    orderDetailBaseView.layer.borderColor = [[UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1] CGColor];
    orderDetailBaseView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:orderDetailBaseView];
    
    // 订单编号
    UILabel *bianhaoLab = [[UILabel alloc] initWithFrame:CGRectMake(6, 10, 200, 30)];
    bianhaoLab.text = [NSString stringWithFormat:@"订单编号：%@", self.model.orderNum];
    bianhaoLab.font = [UIFont boldSystemFontOfSize:13];
    bianhaoLab.textColor = [UIColor darkGrayColor];
    [orderDetailBaseView addSubview:bianhaoLab];
    
    // 撤单按钮
    UIButton *chedanBut = [UIButton buttonWithType:UIButtonTypeCustom];
    chedanBut.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 6 - 50, bianhaoLab.frame.origin.y, 50, 30);
    [chedanBut setTitle:@"撤单" forState:UIControlStateNormal];
    chedanBut.titleLabel.font = [UIFont systemFontOfSize:13];
    [chedanBut setTitleColor:[UIColor colorWithRed:88 / 255.0 green:88 / 255.0 blue:88 / 255.0 alpha:1] forState:UIControlStateNormal];
    chedanBut.layer.cornerRadius = 5;
    chedanBut.layer.borderWidth = 1;
    chedanBut.layer.borderColor = [[UIColor colorWithRed:153.0 / 255.0 green:153.0 / 255.0 blue:153.0 / 255.0 alpha:1] CGColor];
    [orderDetailBaseView addSubview:chedanBut];
    [chedanBut addTarget:self action:@selector(chedanButClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 指定技师
    UIButton *zhipaiBut = [UIButton buttonWithType:UIButtonTypeCustom];
    zhipaiBut.frame = CGRectMake(CGRectGetMinX(chedanBut.frame) - 6 - 60, bianhaoLab.frame.origin.y, 60, 30);
    zhipaiBut.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [zhipaiBut setTitle:@"指定技师" forState:UIControlStateNormal];
    zhipaiBut.layer.cornerRadius = 5;
    zhipaiBut.titleLabel.font = [UIFont systemFontOfSize:13];
    [orderDetailBaseView addSubview:zhipaiBut];
    [zhipaiBut addTarget:self action:@selector(zhipaiButClick) forControlEvents:UIControlEventTouchUpInside];
    if([self.zhipai isEqualToString:@"有"]) {
        
        zhipaiBut.hidden = NO;
    }else {
        
        zhipaiBut.hidden = YES;
    }
    
    
    // 车牌号
    UILabel *licenseLab = [[UILabel alloc] initWithFrame:CGRectMake(6,  CGRectGetMaxY(bianhaoLab.frame), 200, 30)];
    licenseLab.text = [NSString stringWithFormat:@"车牌号：%@", self.model.license];
    licenseLab.font = [UIFont boldSystemFontOfSize:13];
    licenseLab.textColor = [UIColor darkGrayColor];
    [orderDetailBaseView addSubview:licenseLab];
    
    // 车架号
    UILabel *vinLab = [[UILabel alloc] initWithFrame:CGRectMake(6, CGRectGetMaxY(licenseLab.frame), 200, 30)];
    vinLab.text = [NSString stringWithFormat:@"车架号：%@", self.model.vin];
    vinLab.font = [UIFont boldSystemFontOfSize:13];
    vinLab.textColor = [UIColor darkGrayColor];
    [orderDetailBaseView addSubview:vinLab];
    
    
    // 已施工时间
    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(6, CGRectGetMaxY(vinLab.frame), [UIScreen mainScreen].bounds.size.width - 10, 30)];
    timeLab.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    timeLab.font = [UIFont systemFontOfSize:14];
    [orderDetailBaseView addSubview:timeLab];
    if([self.model.statusString isEqualToString:@"施工中"]){
    
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
        NSDate *dd = [formatter dateFromString:self.model.startTime];
        NSInteger time = (NSInteger)[[NSDate date] timeIntervalSince1970] - (NSInteger)[dd timeIntervalSince1970];
//        NSLog(@"-已经开始---%ld", time);
        
        NSInteger mm = time / 60;
        
        NSInteger fen = mm % 60;
        NSInteger hour = mm / 60;
        if(hour > 0) {
            
            timeLab.text = [NSString stringWithFormat:@"已施工 %ld小时%ld分", hour, fen];
        }else {
        
            timeLab.text = [NSString stringWithFormat:@"已施工 %ld分", fen];
        }
        
    }else {
        
        timeLab.text = self.model.statusString;
    }
    
    // 施工项目
    UILabel *proLab = [[UILabel alloc] initWithFrame:CGRectMake(6, CGRectGetMaxY(timeLab.frame), [UIScreen mainScreen].bounds.size.width - 10, 30)];
    proLab.textColor = [UIColor darkGrayColor];
    proLab.font = [UIFont systemFontOfSize:14];
    proLab.text = [NSString stringWithFormat:@"施工项目：%@", self.model.typeName];
    [orderDetailBaseView addSubview:proLab];
    
    UIView *lastView = proLab;
    
#pragma mark - 报价产品
    NSArray *productOfferShowsArray = _orderDetailDict[@"productOfferShows"];
    if ([productOfferShowsArray isKindOfClass:[NSNull class]]){
        productOfferShowsArray = [[NSArray alloc]init];
    }
    if (productOfferShowsArray.count > 0){
        UIView *titleBaseView = [[UIView alloc]init];
        titleBaseView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
        titleBaseView.frame = CGRectMake(1, CGRectGetMaxY(lastView.frame), [UIScreen mainScreen].bounds.size.width + 2, 40);
        [orderDetailBaseView addSubview:titleBaseView];
        
        UIView *leftLittleView = [[UIView alloc]init];
        leftLittleView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        [titleBaseView addSubview:leftLittleView];
        leftLittleView.frame = CGRectMake(0, 12, 6, 16);
        
        
        UILabel *menusTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, [UIScreen mainScreen].bounds.size.width - 40, 30)];
        menusTitleLab.textColor = [UIColor darkGrayColor];
        menusTitleLab.font = [UIFont systemFontOfSize:14];
        menusTitleLab.text = [NSString stringWithFormat:@"报价产品"];
        [titleBaseView addSubview:menusTitleLab];
        
        
        UIView *titleImageBaseView = [[UIView alloc]init];
        titleImageBaseView.backgroundColor = [UIColor whiteColor];
        [orderDetailBaseView addSubview:titleImageBaseView];
        titleImageBaseView.frame = CGRectMake(1, CGRectGetMaxY(titleBaseView.frame), [UIScreen mainScreen].bounds.size.width, 40);
        
        UIImageView *titleImageView = [[UIImageView alloc]init];
        titleImageView.image = [UIImage imageNamed:@"cpin"];
        [titleImageBaseView addSubview:titleImageView];
        titleImageView.frame = CGRectMake(20, 12, 15, 15);
        
        UILabel *titleImageLabel = [[UILabel alloc]init];
        titleImageLabel.text = @"型号+部位";
        titleImageLabel.font = [UIFont boldSystemFontOfSize:14];
        [titleImageBaseView addSubview:titleImageLabel];
        titleImageLabel.frame = CGRectMake(40, 5, [UIScreen mainScreen].bounds.size.width - 60, 30);
        
        UIView *titleLineView = [[UIView alloc]init];
        titleLineView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
        [titleImageBaseView addSubview:titleLineView];
        titleLineView.frame = CGRectMake(15, 39, [UIScreen mainScreen].bounds.size.width - 30, 1);
        
        lastView = titleImageBaseView;
        for (int i = 0; i < productOfferShowsArray.count; i++) {
            
            UIView *titleBaseView = [[UIView alloc]init];
            titleBaseView.backgroundColor = [UIColor whiteColor];
            [orderDetailBaseView addSubview:titleBaseView];
            titleBaseView.frame = CGRectMake(1, CGRectGetMaxY(lastView.frame), [UIScreen mainScreen].bounds.size.width, 40);
            lastView = titleBaseView;
            
            
            NSDictionary *productDict = productOfferShowsArray[i];
            UILabel *menusNameLab = [[UILabel alloc] initWithFrame:CGRectMake(40, 5, [UIScreen mainScreen].bounds.size.width - 60, 30)];
            menusNameLab.textColor = [UIColor darkGrayColor];
            menusNameLab.font = [UIFont systemFontOfSize:14];
            menusNameLab.text = [NSString stringWithFormat:@"%@--%@", productDict[@"model"], productDict[@"constructionPositionName"]];
            [titleBaseView addSubview:menusNameLab];
            
            UIView *lineView = [[UIView alloc]init];
            lineView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
            [titleBaseView addSubview:lineView];
            lineView.frame = CGRectMake(15, 39, [UIScreen mainScreen].bounds.size.width - 30, 1);
        }
    }
    
    
    
#pragma mark - 施工套餐
    NSArray *setMenusArray = _orderDetailDict[@"setMenus"];
    if ([setMenusArray isKindOfClass:[NSNull class]]){
        setMenusArray = [[NSArray alloc]init];
    }
    if (setMenusArray.count > 0){
        
        UIView *titleBaseView = [[UIView alloc]init];
        titleBaseView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
        titleBaseView.frame = CGRectMake(1, CGRectGetMaxY(lastView.frame), [UIScreen mainScreen].bounds.size.width + 2, 40);
        [orderDetailBaseView addSubview:titleBaseView];
        
        UIView *leftLittleView = [[UIView alloc]init];
        leftLittleView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        [titleBaseView addSubview:leftLittleView];
        leftLittleView.frame = CGRectMake(0, 12, 6, 16);
        
        
        UILabel *menusTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, [UIScreen mainScreen].bounds.size.width - 40, 30)];
        menusTitleLab.textColor = [UIColor darkGrayColor];
        menusTitleLab.font = [UIFont systemFontOfSize:14];
        menusTitleLab.text = [NSString stringWithFormat:@"组合套餐"];
        [titleBaseView addSubview:menusTitleLab];
        
        
        UIView *titleImageBaseView = [[UIView alloc]init];
        titleImageBaseView.backgroundColor = [UIColor whiteColor];
        [orderDetailBaseView addSubview:titleImageBaseView];
        titleImageBaseView.frame = CGRectMake(1, CGRectGetMaxY(titleBaseView.frame), [UIScreen mainScreen].bounds.size.width, 40);
        
        UIImageView *titleImageView = [[UIImageView alloc]init];
        titleImageView.image = [UIImage imageNamed:@"tchan"];
        [titleImageBaseView addSubview:titleImageView];
        titleImageView.frame = CGRectMake(20, 12, 15, 15);
        
        UILabel *titleImageLabel = [[UILabel alloc]init];
        titleImageLabel.text = @"套餐名称";
        titleImageLabel.font = [UIFont boldSystemFontOfSize:14];
        [titleImageBaseView addSubview:titleImageLabel];
        titleImageLabel.frame = CGRectMake(40, 5, [UIScreen mainScreen].bounds.size.width - 60, 30);
        
        UIView *titleLineView = [[UIView alloc]init];
        titleLineView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
        [titleImageBaseView addSubview:titleLineView];
        titleLineView.frame = CGRectMake(15, 39, [UIScreen mainScreen].bounds.size.width - 30, 1);
        
        lastView = titleImageBaseView;
        
        for (int i = 0; i < setMenusArray.count; i++) {
            
            UIView *titleBaseView = [[UIView alloc]init];
            titleBaseView.backgroundColor = [UIColor whiteColor];
            [orderDetailBaseView addSubview:titleBaseView];
            titleBaseView.frame = CGRectMake(1, CGRectGetMaxY(lastView.frame), [UIScreen mainScreen].bounds.size.width, 40);
            lastView = titleBaseView;
            
            
            NSDictionary *menusDict = setMenusArray[i];
            UILabel *menusNameLab = [[UILabel alloc] initWithFrame:CGRectMake(40, 5, [UIScreen mainScreen].bounds.size.width - 60, 30)];
            menusNameLab.textColor = [UIColor darkGrayColor];
            menusNameLab.font = [UIFont systemFontOfSize:14];
            menusNameLab.text = [NSString stringWithFormat:@"%@", menusDict[@"name"]];
            [titleBaseView addSubview:menusNameLab];
            
            UIView *lineView = [[UIView alloc]init];
            lineView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
            [titleBaseView addSubview:lineView];
            lineView.frame = CGRectMake(15, 39, [UIScreen mainScreen].bounds.size.width - 30, 1);
            
        }
    }
    
    

    UIView *lineBaseView = [[UIView alloc]init];
    lineBaseView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
    lineBaseView.frame = CGRectMake(1, CGRectGetMaxY(lastView.frame), [UIScreen mainScreen].bounds.size.width + 2, 10);
    [orderDetailBaseView addSubview:lineBaseView];
    
    // 预约施工时间
    UILabel *yuyueTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(6, CGRectGetMaxY(lineBaseView.frame) + 10, [UIScreen mainScreen].bounds.size.width - 10, 30)];
    yuyueTimeLab.textColor = [UIColor darkGrayColor];
    yuyueTimeLab.font = [UIFont systemFontOfSize:14];
    yuyueTimeLab.text = [NSString stringWithFormat:@"预约施工时间：%@", self.model.agreedStartTime];
    [orderDetailBaseView addSubview:yuyueTimeLab];
    
    // 最迟交车时间
    UILabel *zuicheTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(6, CGRectGetMaxY(yuyueTimeLab.frame), [UIScreen mainScreen].bounds.size.width - 10, 30)];
    zuicheTimeLab.textColor = [UIColor darkGrayColor];
    zuicheTimeLab.font = [UIFont systemFontOfSize:14];
    zuicheTimeLab.text = [NSString stringWithFormat:@"最迟交车时间：%@", self.model.agreedEndTime];
    [orderDetailBaseView addSubview:zuicheTimeLab];
    
    // 订单创建时间
    UILabel *xiadanTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(6, CGRectGetMaxY(zuicheTimeLab.frame), [UIScreen mainScreen].bounds.size.width - 10, 30)];
    xiadanTimeLab.textColor = [UIColor darkGrayColor];
    xiadanTimeLab.font = [UIFont systemFontOfSize:14];
    xiadanTimeLab.text = [NSString stringWithFormat:@"订单创建时间：%@", self.model.createTime];
    [orderDetailBaseView addSubview:xiadanTimeLab];
    
    // 下单备注
    UILabel *beizhuLab = [[UILabel alloc] initWithFrame:CGRectMake(6, CGRectGetMaxY(xiadanTimeLab.frame) + 5, [UIScreen mainScreen].bounds.size.width - 10, fenRect.size.height)];
    beizhuLab.textColor = [UIColor darkGrayColor];
    beizhuLab.font = [UIFont systemFontOfSize:14];
    beizhuLab.numberOfLines = 0;
    beizhuLab.text = fenStr;
    [orderDetailBaseView addSubview:beizhuLab];
    
    NSInteger productCount = 0;
    if (setMenusArray.count > 0){
        productCount = productCount + setMenusArray.count + 2;
    }
    if (productOfferShowsArray.count > 0){
        productCount = productCount + productOfferShowsArray.count + 2;
    }
    
    
    orderDetailBaseView.frame = CGRectMake(-1, 10, [UIScreen mainScreen].bounds.size.width + 2, 255 + a + productCount * 40 + 10 + 20);
    
    
    
    // 订单图片
    UIView *vv2 = [[UIView alloc] initWithFrame:CGRectMake(-1, CGRectGetMaxY(orderDetailBaseView.frame) + 10, kWidth + 2, 100)];
    vv2.layer.borderWidth = 1;
    vv2.layer.borderColor = [[UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1] CGColor];
    vv2.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:vv2];
    _vv2 = vv2;
    
    CGFloat butImgW = (kWidth - 40) / 3.0;
    CGFloat butImgH = butImgW;
    for(int i=0; i<self.model.photoArr.count; i++) {
    
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake((i % 3) * (butImgW + 10) + 10, (i / 3) * (butImgH + 10) + 10, butImgW, butImgH);
        but.tag = i + 1;
        but.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
//        [but setBackgroundImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
        [but sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseHttp, self.model.photoArr[i]]] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if(error){
                [but setImage:[UIImage imageNamed:@"load_image_failed"] forState:UIControlStateNormal];
            }
        }];
        [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
        [vv2 addSubview:but];
    }
    
    NSInteger num = self.model.photoArr.count - 1;
    vv2.frame = CGRectMake(-1, CGRectGetMaxY(orderDetailBaseView.frame) + 10, kWidth + 2, (num / 3 + 1) * (butImgH + 10) + 10);
    
    
    
    _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, CGRectGetMaxY(vv2.frame) + 20);
}

- (void)zhipaiButClick {
    
    CLAddPersonViewController *vc = [[CLAddPersonViewController alloc] init];
    vc.orderId = self.model.orderID;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)chedanButClick {
    
//    UIAlertView *aView = [[UIAlertView alloc] initWithTitle:@"注意" message:@"确定删除该订单！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    [self.view addSubview:aView];
//    aView.delegate = self;
//    [aView show];
    if(![_model.statusString isEqualToString:@"已出发"] && ![_model.statusString isEqualToString:@"已签到"] && ![_model.statusString isEqualToString:@"施工中"]) {
        
        UIAlertView *aView = [[UIAlertView alloc] initWithTitle:@"注意" message:@"确定撤销该订单！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [self.view addSubview:aView];
        aView.delegate = self;
        [aView show];
    }else {
        
        UIAlertView *aView = [[UIAlertView alloc] initWithTitle:@"注意" message:@"已开始施工的订单不可撤销" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [self.view addSubview:aView];
        [aView show];
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonInde {
    
//    NSLog(@"=====++++=%ld===", buttonInde);
    if(buttonInde == 1) {
        
        [GFHttpTool postCanceledOrder:self.model.orderID Success:^(id responseObject) {
            
//            NSLog(@"==撤单返回的信息==%@", responseObject);
            
            if([responseObject[@"status"] integerValue] == 1) {
                
                [self tipShow:@"撤单成功！"];
                [self performSelector:@selector(successWork) withObject:nil afterDelay:1];
            }else {
                
                if([responseObject[@"message"] isKindOfClass:[NSNull class]]) {
                    
                    [self tipShow:@"撤单失败，请重试或联系上头"];
                }else {
                    
                    [self tipShow:responseObject[@"message"]];
                }
            }
            
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"FINISHED" object:self userInfo:nil];
            
            
            
        } failure:^(NSError *error) {
            
            
        }];
    }
}

- (void)successWork {
    
    
    [self.noIndentVC.tableView.mj_header beginRefreshing];
    [self.navigationController popViewControllerAnimated:YES];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"FINISHED" object:self userInfo:nil];

}
- (void)tipShow:(NSString *)string{
    
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:string withShowTimw:2.5];
    [tipView tipViewShow];
    
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    
    if([annotation isKindOfClass:[GFAnnotation class]]) {
        GFAnnotationView *annView = [GFAnnotationView annotationWithMapView:mapView];
        
        annView.annotation = annotation;
        return annView;
    }
    
    
    return nil;
}


- (void)butClick:(UIButton *)sender {
    
    HZPhotoBrowser *browser = [[HZPhotoBrowser alloc] init];
    
    browser.sourceImagesContainerView = _vv2;
    
    browser.imageCount = self.model.photoArr.count;
    
    browser.currentImageIndex = sender.tag - 1;
    
    browser.delegate = self;
    
    [browser show]; // 展示图片浏览器
}
- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    
    UIImage *img = [UIImage imageNamed:@"userImage"];
    
    return img;
}
- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseHttp, self.model.photoArr[index]]];
    
    return url;
}

// 添加导航
- (void)setNavigation{
    
    _navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"订单详情" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [_navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //    [navView.rightBut addTarget:navView action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
    
    
}
- (void)backBtnClick{
    /*
     if (_isAdd) {
     CLHomeOrderViewController *homeOrder = self.navigationController.viewControllers[0];
     [homeOrder headRefresh];
     }
     */
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
