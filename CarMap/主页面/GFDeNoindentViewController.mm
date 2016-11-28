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


#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]


@interface GFDeNoindentViewController () <HZPhotoBrowserDelegate, BMKMapViewDelegate, BMKMapViewDelegate, BMKShareURLSearchDelegate,BMKGeoCodeSearchDelegate,BMKPoiSearchDelegate,BMKRouteSearchDelegate> {
    
    CGFloat kWidth;
    CGFloat kHieght;
    
    UIScrollView *_scrollView;
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
    
    // 界面布局
    [self _setDeInView];
}

- (void)jishixinxiClick {
    
    NSLog(@"跳转到技师详情页面＝＝＝＝");
    
    [GFHttpTool getjishiDetailOrderId:0 success:^(id responseObject) {
        
        
        
        GFDetailPeoViewController *deVC = [[GFDetailPeoViewController alloc] init];
//        deVC.model
    } failure:^(NSError *error) {
        
        
    }];
}

// 界面布局
- (void)_setDeInView{
    
    
    UIView *vv3 = [[UIView alloc] initWithFrame:CGRectMake(-1, 70, [UIScreen mainScreen].bounds.size.width + 2, 230)];
    vv3.layer.borderWidth = 1;
    vv3.layer.borderColor = [[UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1] CGColor];
    vv3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vv3];
    //  技师位置
    GFTitleView *kejiView = [[GFTitleView alloc] initWithY:0 Title:@"技师信息"];
    [vv3 addSubview:kejiView];
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 10, kejiView.frame.size.height);
    but.backgroundColor = [UIColor redColor];
    [but setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(jishixinxiClick) forControlEvents:UIControlEventTouchUpInside];
    [kejiView addSubview:but];
    // 添加地图
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(1, CGRectGetMaxY(kejiView.frame) - 1, [UIScreen mainScreen].bounds.size.width, 230 - [UIScreen mainScreen].bounds.size.height * 0.0782)];
    self.mapView.delegate = self;
    [self.mapView setMapType:BMKMapTypeStandard];   // 地图类型
    self.mapView.userTrackingMode = BMKUserTrackingModeFollow;  // 跟随模式
    //    [self.mapView setZoomLevel:13];
    [vv3 addSubview:self.mapView];
    
    NSLog(@"===%f,,,%f", [self.model.techLatitude floatValue], [self.model.techLongitude floatValue]);
    if([self.model.techLatitude floatValue] == 0 && [self.model.techLongitude floatValue] == 0) {
    
        // 商户大头针
        self.shanghuAnno = [[GFAnnotation alloc] init];
        self.shanghuAnno.iconImgName = @"location";
        self.shanghuAnno.coordinate = CLLocationCoordinate2DMake([self.model.latitude floatValue], [self.model.longitude floatValue]);
        [self.mapView addAnnotation:self.shanghuAnno];
        _mapView.zoomLevel = 13;
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 150, 40)];
        lab.backgroundColor = [UIColor orangeColor];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = @"暂无技师位置信息";
        lab.textColor = [UIColor whiteColor];
        [self.view addSubview:lab];
        
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
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(vv3.frame), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(vv3.frame))];
//    _scrollView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_scrollView];
    
    
    if([self.jishi isEqualToString:@"无"]) {
    
        vv3.hidden = YES;
        _scrollView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
    }
    
    
    UIView *vv1 = [[UIView alloc] initWithFrame:CGRectMake(-1, 10, [UIScreen mainScreen].bounds.size.width + 2, 170)];
    vv1.layer.borderWidth = 1;
    vv1.layer.borderColor = [[UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1] CGColor];
    vv1.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:vv1];
    
    // 订单编号
    UILabel *bianhaoLab = [[UILabel alloc] initWithFrame:CGRectMake(6, 10, 200, 30)];
    bianhaoLab.text = [NSString stringWithFormat:@"订单编号：%@", self.model.orderNum];
    bianhaoLab.font = [UIFont boldSystemFontOfSize:13];
    bianhaoLab.textColor = [UIColor darkGrayColor];
    [vv1 addSubview:bianhaoLab];
    
    // 撤单按钮
    UIButton *chedanBut = [UIButton buttonWithType:UIButtonTypeCustom];
    chedanBut.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 6 - 50, bianhaoLab.frame.origin.y, 50, 30);
    [chedanBut setTitle:@"撤单" forState:UIControlStateNormal];
    chedanBut.titleLabel.font = [UIFont systemFontOfSize:13];
    [chedanBut setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    chedanBut.layer.cornerRadius = 5;
    chedanBut.layer.borderWidth = 1;
    chedanBut.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [vv1 addSubview:chedanBut];
    [chedanBut addTarget:self action:@selector(chedanButClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 指定技师
    UIButton *zhipaiBut = [UIButton buttonWithType:UIButtonTypeCustom];
    zhipaiBut.frame = CGRectMake(CGRectGetMinX(chedanBut.frame) - 6 - 60, bianhaoLab.frame.origin.y, 60, 30);
    zhipaiBut.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [zhipaiBut setTitle:@"指定技师" forState:UIControlStateNormal];
    zhipaiBut.layer.cornerRadius = 5;
    zhipaiBut.titleLabel.font = [UIFont systemFontOfSize:13];
    [vv1 addSubview:zhipaiBut];
    [zhipaiBut addTarget:self action:@selector(zhipaiButClick) forControlEvents:UIControlEventTouchUpInside];
    if([self.zhipai isEqualToString:@"有"]) {
        
        zhipaiBut.hidden = NO;
    }else {
        
        zhipaiBut.hidden = YES;
    }
    
    // 已施工时间
    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(6, CGRectGetMaxY(bianhaoLab.frame), [UIScreen mainScreen].bounds.size.width - 10, 30)];
    timeLab.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    timeLab.font = [UIFont systemFontOfSize:14];
    timeLab.text = @"已施工88分钟";
    [vv1 addSubview:timeLab];
    
    // 预约施工时间
    UILabel *yuyueTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(6, CGRectGetMaxY(timeLab.frame), [UIScreen mainScreen].bounds.size.width - 10, 30)];
    yuyueTimeLab.textColor = [UIColor darkGrayColor];
    yuyueTimeLab.font = [UIFont systemFontOfSize:14];
    yuyueTimeLab.text = [NSString stringWithFormat:@"预约施工时间：%@", self.model.agreedStartTime];
    [vv1 addSubview:yuyueTimeLab];
    
    // 最迟交车时间
    UILabel *zuicheTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(6, CGRectGetMaxY(yuyueTimeLab.frame), [UIScreen mainScreen].bounds.size.width - 10, 30)];
    zuicheTimeLab.textColor = [UIColor darkGrayColor];
    zuicheTimeLab.font = [UIFont systemFontOfSize:14];
    zuicheTimeLab.text = [NSString stringWithFormat:@"最迟交车时间%@", self.model.agreedEndTime];
    [vv1 addSubview:zuicheTimeLab];
    
    // 下单时间
    UILabel *xiadanTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(6, CGRectGetMaxY(zuicheTimeLab.frame), [UIScreen mainScreen].bounds.size.width - 10, 30)];
    xiadanTimeLab.textColor = [UIColor darkGrayColor];
    xiadanTimeLab.font = [UIFont systemFontOfSize:14];
    xiadanTimeLab.text = [NSString stringWithFormat:@"订单创建时间：%@", self.model.createTime];
    [vv1 addSubview:xiadanTimeLab];

    // 订单图片
    UIView *vv2 = [[UIView alloc] initWithFrame:CGRectMake(-1, CGRectGetMaxY(vv1.frame) + 10, kWidth + 2, 100)];
    vv2.layer.borderWidth = 1;
    vv2.layer.borderColor = [[UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1] CGColor];
    vv2.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:vv2];
    _vv2 = vv2;
    
    CGFloat butImgW = (kWidth - 40) / 3.0;
    CGFloat butImgH = butImgW;
    for(int i=0; i<self.model.photoUrlArr.count; i++) {
    
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake((i % 3) * (butImgW + 10) + 10, (i / 3) * (butImgH + 10) + 10, butImgW, butImgH);
        but.tag = i + 1;
//        [but setBackgroundImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
        [but sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://10.0.12.221:12345%@", self.model.photoUrlArr[i]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"userImage"]];
        [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
        [vv2 addSubview:but];
    }
    
    NSInteger num = self.model.photoUrlArr.count - 1;
    vv2.frame = CGRectMake(-1, CGRectGetMaxY(vv1.frame) + 10, kWidth + 2, (num / 3 + 1) * (butImgH + 10) + 10);
    
    
    
    _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, CGRectGetMaxY(vv2.frame) + 20);
}

- (void)zhipaiButClick {
    
    CLAddPersonViewController *vc = [[CLAddPersonViewController alloc] init];
    vc.orderId = self.model.orderID;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)chedanButClick {
    
    UIAlertView *aView = [[UIAlertView alloc] initWithTitle:@"注意" message:@"确定删除该订单！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [self.view addSubview:aView];
    aView.delegate = self;
    [aView show];
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonInde {
    
    NSLog(@"=====++++=%ld===", buttonInde);
    if(buttonInde == 1) {
        
        [GFHttpTool postCanceledOrder:self.model.orderID Success:^(id responseObject) {
            
            NSLog(@"==撤单返回的信息==%@", responseObject);
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"FINISHED" object:self userInfo:nil];
            
            [self.noIndentVC.tableView.header beginRefreshing];
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSError *error) {
            
            
        }];
    }
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
    
    browser.imageCount = self.model.photoUrlArr.count;
    
    browser.currentImageIndex = sender.tag - 1;
    
    browser.delegate = self;
    
    [browser show]; // 展示图片浏览器
}
- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    
    UIImage *img = [UIImage imageNamed:@"userImage"];
    
    return img;
}
- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://10.0.12.221:12345%@", self.model.photoUrlArr[index]]];
    
    return url;
}

// 添加导航
- (void)setNavigation{
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"车邻邦" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //    [navView.rightBut addTarget:navView action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navView];
    
    
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
