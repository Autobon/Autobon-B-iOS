//
//  GFSignInViewController.h
//  车邻邦客户端
//
//  Created by 陈光法 on 16/3/1.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GFTextField;

@interface GFSignInViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) GFTextField *phoneTxt;
@property (nonatomic, strong) GFTextField *passwordTxt;
@end
