//
//  GFCooperationViewController.m
//  CarMapB
//
//  Created by 陈光法 on 16/11/16.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFCooperationViewController.h"
#import "GFNavigationView.h"
#import "GFTitleView.h"
#import "GFTextField.h"
#import "CLTouchView.h"
#import "GFHttpTool.h"
#import "GFTipView.h"
#import "BMKLocationService.h"
#import "GFAnnotation.h"
#import "GFAnnotationView.h"
#import "GFJoinInViewController_2.h"
#import "CLTouchScrollView.h"
#import "CLCooperatingViewController.h"

@interface GFCooperationViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate,UISearchBarDelegate,BMKLocationServiceDelegate,BMKMapViewDelegate,BMKGeoCodeSearchDelegate> {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    CGFloat jiange1;
    CGFloat jiange2;
    CGFloat jiange3;
    CGFloat jiange4;
    CGFloat jiange5;
    CGFloat jiange6;
    
    CGFloat jianjv1;
    
    
    UIButton *_certificateImage;
    UIButton *_idImageViewBtn;
    UIView *_chooseView;

    BOOL _isCertificate;
    BOOL _isUpCertificate;
    BOOL _isUpidImageView;
    NSMutableDictionary *_dataDictionary;
    
    CLTouchScrollView *_scView;
    
    
    /// 地图定位
    UISearchBar *_searchbar;
    BMKGeoCodeSearch* _geocodesearch;
    
}

@property (nonatomic, strong) GFTextField *yingyeNameTxt;


// 定位
@property(nonatomic, strong) BMKLocationService *locationService;

// 大头针
@property(nonatomic, strong) GFAnnotation *workerPointAnno;

@end

@implementation GFCooperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self _setCoopNav];
    [self _setCoopView];
    
}

- (void)_setCoopNav {
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"合作商加盟" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navView];
}
-(void)backBtnClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)_setCoopView {
    
    kWidth = [UIScreen mainScreen].bounds.size.width;
    kHeight = [UIScreen mainScreen].bounds.size.height;
    
    jiange1 = kHeight * 0.0183;
    jiange2 = kWidth * 0.008;
    jiange3 = kHeight * 0.021;
    jiange4 = kHeight * 0.0573;
    jiange5 = jiange3;
    jiange6 = kHeight * 0.0365;
    
    jianjv1 = kWidth * 0.18;
    
    _scView = [[CLTouchScrollView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, kHeight - 64)];
    _scView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scView];
    

    // 公司信息
    GFTitleView *kejiView = [[GFTitleView alloc] initWithY:10 Title:@"公司信息"];
    [_scView addSubview:kejiView];
    
    // 营业执照的工商注册名称
    self.yingyeNameTxt = [[GFTextField alloc] initWithY:CGRectGetMaxY(kejiView.frame) withPlaceholder:@"营业执照的工商注册名称"];
    [_scView addSubview:self.yingyeNameTxt];
    
    // 上传营业执照副本
    GFTitleView *zhizhaoView = [[GFTitleView alloc] initWithY:CGRectGetMaxY(self.yingyeNameTxt.frame) Title:@"上传营业执照副本"];
    [_scView addSubview:zhizhaoView];
    // 示例图1
    CGFloat baseView1W = kWidth;
    CGFloat baseView1H = 0.3125 * kHeight;
    CGFloat baseView1X = 0;
    CGFloat baseView1Y = CGRectGetMaxY(zhizhaoView.frame);
    UIView *baseView1 = [[UIView alloc] initWithFrame:CGRectMake(baseView1X, baseView1Y, baseView1W, baseView1H)];
    [_scView addSubview:baseView1];
    // 图片
    CGFloat imgView1W = kWidth - kWidth * 0.18* 2.0;
    CGFloat imgView1H = baseView1H - jiange3 - jiange4;
    CGFloat imgView1X = jianjv1;
    CGFloat imgView1Y = jiange3;
    _certificateImage = [[UIButton alloc] initWithFrame:CGRectMake(imgView1X, imgView1Y, imgView1W, imgView1H)];
    [_certificateImage setBackgroundImage:[UIImage imageNamed:@"userImage"] forState:UIControlStateNormal];
    //    imgView1.image = [UIImage imageNamed:@"userImage"];
    [baseView1 addSubview:_certificateImage];
    // 边线
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, baseView1H, baseView1W, 1)];
    lineView1.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
    [baseView1 addSubview:lineView1];
    // 上传营业执照副本的相机按钮
    UIButton *certificateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    certificateBtn.frame = CGRectMake(CGRectGetMaxX(_certificateImage.frame)-15, CGRectGetMaxY(_certificateImage.frame)-15, 30, 30);
    [certificateBtn setBackgroundImage:[UIImage imageNamed:@"cameraUser"] forState:UIControlStateNormal];
    _certificateImage.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [baseView1 addSubview:certificateBtn];
    _certificateImage.tag =1;
    certificateBtn.tag = 1;
    [_certificateImage addTarget:self action:@selector(cameraBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [certificateBtn addTarget:self action:@selector(cameraBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    /*
    // 商户位置
    GFTitleView *idCardView = [[GFTitleView alloc] initWithY:CGRectGetMaxY(baseView1.frame) Title:@"商户位置"];
    [_scView addSubview:idCardView];
    
    _searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(idCardView.frame) + 10, self.view.frame.size.width-100, 40)];
    _searchbar.barTintColor = [UIColor whiteColor];
    _searchbar.barStyle = UIBarStyleDefault;
    _searchbar.layer.cornerRadius = 10;
    _searchbar.layer.borderWidth = 1.5;
    _searchbar.placeholder = @"请输入详细地址";
    _searchbar.layer.borderColor = [[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]CGColor];
    
    [_scView addSubview:_searchbar];
    _searchbar.delegate = self;
    _searchbar.clipsToBounds = YES;
    
    
    UIButton *searchButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-70, _searchbar.frame.origin.y, 60, 40)];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton setBackgroundColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1]];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [searchButton addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    searchButton.layer.cornerRadius = 5;
    searchButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_scView addSubview:searchButton];
    
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_searchbar.frame) + 10, self.view.frame.size.width , self.view.frame.size.width*7/10)];
    _mapView.delegate = self;
    // 去掉百度地图的logo
    UIView *mapView = _mapView.subviews[0];
    [mapView.subviews[mapView.subviews.count-1] removeFromSuperview];
    [_scView addSubview:_mapView];
    // POI检索
    _poisearch = [[BMKPoiSearch alloc]init];
    _poisearch.delegate = self;
    // 设置地图级别
    [_mapView setZoomLevel:13];
    _nextPageButton.enabled = false;
    _mapView.isSelectedAnnotationViewFront = YES;
    
    [self _setLocationService];
    [self _setAnnonation];
    
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    _geocodesearch.delegate = self;
    */
    
    UIButton *okBut = [UIButton buttonWithType:UIButtonTypeCustom];
    okBut.frame = CGRectMake(40, CGRectGetMaxY(baseView1.frame) + 30, [UIScreen mainScreen].bounds.size.width - 80, 45);
    [okBut setTitle:@"加盟" forState:UIControlStateNormal];
    okBut.layer.cornerRadius = 5;
    okBut.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [_scView addSubview:okBut];
    [okBut addTarget:self action:@selector(okButClick) forControlEvents:UIControlEventTouchUpInside];
    
    _scView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, CGRectGetMaxY(okBut.frame));
}

- (void)okButClick {
    
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    mDic[@"enterpriseName"] = self.yingyeNameTxt.text;
    mDic[@"businessLicensePic"] = _dataDictionary[@"bussinessLicensePic"];
    NSLog(@"-%@-", mDic);
    
    [GFHttpTool jiamengPostWithParameters:mDic success:^(id responseObject) {
        
        NSLog(@"--加盟信息提交成功---%@--\n\n--%@", mDic, responseObject);
        if([responseObject[@"status"] integerValue] == 1) {
        
            [self.navigationController popToRootViewControllerAnimated:YES];
//            CLCooperatingViewController *cooperating = [[CLCooperatingViewController alloc]init];
//            cooperating.setLabel.text = @"正在审核";
//            cooperating.dataDictionary = dataDictionary[@"cooperator"];
//            [self.navigationController pushViewController:cooperating animated:YES];
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"--请求失败!!!!!--%@", error);
    }];
}

//*****//*****//*****//*****//*****//*****//*****//*****//*****//*****//
//*****//*****//*****/  商户位置相关方法  /*****//*****//*****//*****//
//*****//*****//*****//*****//*****//*****//*****//*****//*****//*****//
#pragma mark - ***** 大头针 *****
- (void)_setAnnonation {
    
    // 技师大头针
    self.workerPointAnno = [[GFAnnotation alloc] init];
    //    self.workerPointAnno.title = @"我是技师";
    //    self.workerPointAnno.subtitle = @"天赐我一个单吧";
    //    self.workerPointAnno.iconImgName = @"me-1";
    [_mapView addAnnotation:self.workerPointAnno];
}
#pragma mark - ***** 定位 *****
- (void)_setLocationService {
    
    self.locationService = [[BMKLocationService alloc] init];
    [self.locationService startUserLocationService];
    self.locationService.allowsBackgroundLocationUpdates = NO;
    self.locationService.pausesLocationUpdatesAutomatically = YES;
}
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    //    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    //    [_mapView removeAnnotations:array];
    //    array = [NSArray arrayWithArray:_mapView.overlays];
    //    [_mapView removeOverlays:array];
    if (error == 0) {
        //        BMKPointAnnotation* _workerPointAnno = [[BMKPointAnnotation alloc]init];
        _workerPointAnno.coordinate = result.location;
        _workerPointAnno.title = result.address;
//        [_mapView addAnnotation:_workerPointAnno];
        _mapView.centerCoordinate = result.location;
//        NSString* titleStr;
//        NSString* showmeg;
//        titleStr = @"反向地理编码";
//        showmeg = [NSString stringWithFormat:@"%@",_workerPointAnno.title];
//        NSLog(@"看看字典－－_dataDictionary--%@-",_dataDictionary);
        
        [_dataDictionary setObject:@(result.location.longitude) forKey:@"longitude"];
        [_dataDictionary setObject:@(result.location.latitude) forKey:@"latitude"];
        [_dataDictionary setObject:result.addressDetail.province forKey:@"province"];
        [_dataDictionary setObject:result.addressDetail.city forKey:@"city"];
        [_dataDictionary setObject:result.addressDetail.district forKey:@"district"];
        
//        NSLog(@"看看字典－222－_dataDictionary--%@-",result.addressDetail.city);

//        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
//        [myAlertView show];
    }
}
- (void)onClickReverseGeocode:(CLLocationCoordinate2D )location {
    
    CLLocationCoordinate2D pt = location;
    
    //    pt = (CLLocationCoordinate2D){30.481069601885,114.40935018074};
    
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        //        NSLog(@"反geo检索发送成功");
    }
    else
    {
        //        NSLog(@"反geo检索发送失败");
    }
    
}
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == 0) {
        //        BMKPointAnnotation* _workerPointAnno = [[BMKPointAnnotation alloc]init];
        _workerPointAnno.coordinate = result.location;
        _workerPointAnno.title = result.address;
        [_mapView addAnnotation:_workerPointAnno];
        _mapView.centerCoordinate = result.location;
        NSString* titleStr;
        NSString* showmeg;
        
        titleStr = @"正向地理编码";
        showmeg = [NSString stringWithFormat:@"经度:%f,纬度:%f",_workerPointAnno.coordinate.latitude,_workerPointAnno.coordinate.longitude];
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [myAlertView show];
    }
}
- (void)onClickGeocode {
    //    isGeoSearch = true;
    
    
    BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    //    geocodeSearchOption.city= _cityText.text;
    geocodeSearchOption.address = _searchbar.text;
    BOOL flag = [_geocodesearch geoCode:geocodeSearchOption];
    if(flag)
    {
        //        NSLog(@"geo检索发送成功");
    }
    else
    {
        //        NSLog(@"geo检索发送失败");
    }
    
}
#pragma mark - ***** 定位代理 *****
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    
    _mapView.centerCoordinate = userLocation.location.coordinate;
    self.workerPointAnno.coordinate = userLocation.location.coordinate;
    [self onClickReverseGeocode:self.workerPointAnno.coordinate];
    //    NSLog(@"更新用户位置");
    [self.locationService stopUserLocationService];
    //    [_mapView updateLocationData:userLocation];
}
- (void)didFailToLocateUserWithError:(NSError *)error {
    
    //    NSLog(@"获取当前位置失败，请检查您的网络－－%@",error);
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self onClickGeocode];
    //    [self searchBtnClick];
}
-(void)searchBtnClick
{
    [self.view endEditing:YES];
    
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.city= @"武汉";
    citySearchOption.keyword = _searchbar.text;
    BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
    if(flag)
    {
        //        NSLog(@"城市内检索发送成功");
    }
    else
    {
        //        NSLog(@"城市内检索发送失败");
    }
    
    
}


//- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
//    NSLog(@"看一看");
//    if([annotation isKindOfClass:[GFAnnotation class]]) {
//        GFAnnotationView *annView = [GFAnnotationView annotationWithMapView:mapView];
//
//        annView.annotation = annotation;
//        return annView;
//    }
//
//
//    return nil;
//}
#pragma mark 底图手势操作
/**
 *点中底图标注后会回调此接口
 *@param mapview 地图View
 *@param mapPoi 标注点信息
 */
//- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi*)mapPoi
//{
//    NSLog(@"onClickedMapPoi-%@",mapPoi.text);
//    NSString* showmeg = [NSString stringWithFormat:@"您点击了底图标注:%@,\r\n当前经度:%f,当前纬度:%f,\r\nZoomLevel=%d;RotateAngle=%d;OverlookAngle=%d", mapPoi.text,mapPoi.pt.longitude,mapPoi.pt.latitude, (int)_mapView.zoomLevel,_mapView.rotation,_mapView.overlooking];
//    NSLog(@"---showmeg----%@---",showmeg);
//    _showMsgLabel.text = showmeg;
//}
/**
 *点中底图空白处会回调此接口
 *@param mapview 地图View
 *@param coordinate 空白处坐标点的经纬度
 */
#pragma mark - 单机地图调用的接口
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
    //    NSLog(@"onClickedMapBlank-latitude==%f,longitude==%f",coordinate.latitude,coordinate.longitude);
    //    NSString* showmeg = [NSString stringWithFormat:@"您点击了地图空白处(blank click).\r\n当前经度:%f,当前纬度:%f,\r\nZoomLevel=%d;RotateAngle=%d;OverlookAngle=%d", coordinate.longitude,coordinate.latitude,(int)_mapView.zoomLevel,_mapView.rotation,_mapView.overlooking];
    //    NSLog(@"---showmeg-点击空白处---%@---",showmeg);
    _mapView.centerCoordinate = coordinate;
    self.workerPointAnno.coordinate = coordinate;
    
    [self onClickReverseGeocode:self.workerPointAnno.coordinate];
}
- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi*)mapPoi
{
    _mapView.centerCoordinate = mapPoi.pt;
    self.workerPointAnno.coordinate = mapPoi.pt;
    
    [self onClickReverseGeocode:self.workerPointAnno.coordinate];
}

#pragma mark implement BMKMapViewDelegate
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    // 生成重用标示identifier
    NSString *AnnotationViewID = @"xidanMark";
    
    // 检查是否有重用的缓存
    BMKAnnotationView* annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
        // 设置重天上掉下的效果(annotation)
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }
    
    // 设置位置
    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
    annotationView.canShowCallout = YES;
    // 设置是否可以拖拽
    annotationView.draggable = NO;
    
    return annotationView;
}
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    //    NSLog(@"----选中大头针--%f--",view.annotation.coordinate.latitude);
    [mapView bringSubviewToFront:view];
    [mapView setNeedsDisplay];
}
- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    //    NSLog(@"didAddAnnotationViews");
}

#pragma mark implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    // 清楚屏幕中所有的annotation
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    
    if (error == BMK_SEARCH_NO_ERROR) {
        NSMutableArray *annotations = [NSMutableArray array];
        for (int i = 0; i < result.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            [annotations addObject:item];
            
        }
        [_mapView addAnnotations:annotations];
        [_mapView showAnnotations:annotations animated:YES];
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        //        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }
}





//*****//*****//*****//*****//*****//*****//*****//*****//*****//*****//
#pragma mark - 相机按钮的响应方法
- (void)cameraBtnClick:(UIButton *)button{
    //    NSLog(@"--请选择照片－－");
    [self.view endEditing:YES];
    if (button.tag == 1) {
        _isCertificate = YES;
    }else{
        _isCertificate = NO;
    }
    //    _scrollerView.userInteractionEnabled = NO;
    if (_chooseView == nil) {
        _chooseView = [[CLTouchView alloc]initWithFrame:self.view.bounds];
        //        _chooseView.backgroundColor = [UIColor cyanColor];
        [self.view addSubview:_chooseView];
        
        UIView *chooseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-100, 80)];
        chooseView.center = self.view.center;
        chooseView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        chooseView.layer.cornerRadius = 15;
        chooseView.clipsToBounds = YES;
        [_chooseView addSubview:chooseView];
        
        // 相机和相册按钮
        UIButton *cameraButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-100, 40)];
        [cameraButton setTitle:@"相册" forState:UIControlStateNormal];
        [cameraButton addTarget:self action:@selector(imageChoose:) forControlEvents:UIControlEventTouchUpInside];
        cameraButton.tag = 1;
        [chooseView addSubview:cameraButton];
        
        UIButton *photoButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width-100, 40)];
        [photoButton setTitle:@"相机" forState:UIControlStateNormal];
        [photoButton addTarget:self action:@selector(imageChoose:) forControlEvents:UIControlEventTouchUpInside];
        photoButton.tag = 2;
        [chooseView addSubview:photoButton];
    }
    
    
    _chooseView.hidden = NO;
    
    
    
}
#pragma mark - 选择照片
- (void)imageChoose:(UIButton *)button{
    _chooseView.hidden = YES;
    //    _scrollerView.userInteractionEnabled = YES;
    //    _scrollView.userInteractionEnabled = YES;
    if (button.tag == 1) {
        
        
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePickerController.delegate =self;
        
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }else{
        //        NSLog(@"打开相机");
        BOOL result = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
        if (result) {
            //            NSLog(@"---支持使用相机---");
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            [self  presentViewController:imagePicker animated:YES completion:^{
            }];
        }else{
            //            NSLog(@"----不支持使用相机----");
        }
        
    }
    
    
}
#pragma mark - 图片协议方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    [self dismissViewControllerAnimated:YES completion:nil];
//    if (_isCertificate) {
        [_certificateImage setImage:image forState:UIControlStateNormal];
        CGSize imagesize;
        if (image.size.width > image.size.height) {
            imagesize.width = 800;
            imagesize.height = image.size.height*800/image.size.width;
        }else{
            imagesize.height = 800;
            imagesize.width = image.size.width*800/image.size.height;
        }
        UIImage *imageNew = [self imageWithImage:image scaledToSize:imagesize];
        NSData *imageData = UIImageJPEGRepresentation(imageNew, 0.8);
        
        [GFHttpTool postcertificateImage:imageData success:^(id responseObject) {
            NSLog(@"上传成功－－%@--",responseObject);
            if ([responseObject[@"status"] integerValue] == 1) {
                _isUpCertificate = YES;
                _dataDictionary = [[NSMutableDictionary alloc] init];
                [_dataDictionary setObject:responseObject[@"message"] forKey:@"bussinessLicensePic"];
            }else{
                [self addAlertView:responseObject[@"message"]];
            }
        } failure:^(NSError *error) {
                NSLog(@"上传失败－－%@---",error);
                 [self addAlertView:@"请求失败"];
        }];
        
        
//    }else{
//        [_idImageViewBtn setImage:image forState:UIControlStateNormal];
//        //        _haveIdentityImage = YES;
//        //        _identityButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
//        
//        CGSize imagesize;
//        if (image.size.width > image.size.height) {
//            imagesize.width = 800;
//            imagesize.height = image.size.height*800/image.size.width;
//        }else{
//            imagesize.height = 800;
//            imagesize.width = image.size.width*800/image.size.height;
//        }
//        UIImage *imageNew = [self imageWithImage:image scaledToSize:imagesize];
//        NSData *imageData = UIImageJPEGRepresentation(imageNew, 0.3);
//        
//        
//        [GFHttpTool postIdImageViewImage:imageData success:^(id responseObject) {
//            
//            //            NSLog(@"－－－－上传成功－－－%@--",responseObject);
//            if ([responseObject[@"status"] integerValue] == 1) {
//                _isUpidImageView = YES;
//                [_dataDictionary setObject:responseObject[@"message"] forKey:@"corporationIdPicA"];
//            }else{
//                [self addAlertView:responseObject[@"message"]];
//            }
//            
//        } failure:^(NSError *error) {
//            //             [self addAlertView:@"请求失败"];
//            //            NSLog(@"---请求失败－－－error---%@---",error);
//            
//        }];
//        
//    }
    
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
//*****//*****//*****//*****//*****//*****//*****//*****//*****//*****//

#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    [_scView endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [_mapView viewWillAppear];
    self.locationService.delegate = self;
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _poisearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [_mapView viewWillDisappear];
    self.locationService.delegate = nil;
    _mapView.delegate = nil; // 不用时，置nil
    _poisearch.delegate = nil; // 不用时，置nil
}
- (void)dealloc {
    if (_poisearch != nil) {
        _poisearch = nil;
    }
    if (_mapView) {
        _mapView = nil;
    }
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
