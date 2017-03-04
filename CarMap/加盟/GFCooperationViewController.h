//
//  GFCooperationViewController.h
//  CarMapB
//
//  Created by 陈光法 on 16/11/16.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <BaiduMapAPI_Map/BMKMapComponent.h>
//#import <BaiduMapAPI_Search/BMKSearchComponent.h>
//<BMKMapViewDelegate, BMKPoiSearchDelegate>

@interface GFCooperationViewController : UIViewController {
//    BMKMapView* _mapView;
    UITextField* _cityText;
    UITextField* _keyText;
    UIButton* _nextPageButton;
//    BMKPoiSearch* _poisearch;
    int curPage;
}

@property (nonatomic ,strong) NSDictionary *dataForPastDictionary;

@property (nonatomic ,strong) NSMutableDictionary *dataDictionary;

@end
