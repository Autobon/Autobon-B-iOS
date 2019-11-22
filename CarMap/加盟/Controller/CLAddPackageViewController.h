//
//  CLAddPackageViewController.h
//  CarMapB
//
//  Created by inCarL on 2019/10/9.
//  Copyright © 2019 mll. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CLAddPackageDelegate <NSObject>

- (void)addPackageSuccess;

@end


@interface CLAddPackageViewController : UIViewController

@property (nonatomic, strong) id<CLAddPackageDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
