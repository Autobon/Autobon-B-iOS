//
//  GFDeNoindentViewController.h
//  CarMapB
//
//  Created by 陈光法 on 16/11/23.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstViewController.h"
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "GFAnnotation.h"


@class GFNoIndentModel;
@class GFNoIndentViewController;


@interface GFDeNoindentViewController : UIViewController

@property (nonatomic, copy) NSString *zhipai;
@property (nonatomic, copy) NSString *jishi;

@property (nonatomic, strong) GFNoIndentModel *model;

@property (nonatomic, strong) GFNoIndentViewController *noIndentVC;

@end
