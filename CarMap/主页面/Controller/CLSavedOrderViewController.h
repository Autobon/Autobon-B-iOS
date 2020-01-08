//
//  CLSavedOrderViewController.h
//  CarMapB
//
//  Created by inCarL on 2020/1/7.
//  Copyright © 2020 mll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLPreOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CLSelectSaveOrderDelegate <NSObject>

- (void)selectSaveOrderModel:(CLPreOrderModel *)preOrderModel;

@end

@interface CLSavedOrderViewController : UIViewController

@property (nonatomic ,strong) id<CLSelectSaveOrderDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
