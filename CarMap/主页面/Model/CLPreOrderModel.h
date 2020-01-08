//
//  CLPreOrderModel.h
//  CarMapB
//
//  Created by inCarL on 2020/1/7.
//  Copyright © 2020 mll. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLPreOrderModel : NSObject

@property (nonatomic ,strong) NSString *idString;
@property (nonatomic ,strong) NSString *agreedStartTime;
@property (nonatomic ,strong) NSString *license;
@property (nonatomic ,strong) NSString *mark;
@property (nonatomic ,strong) NSString *remark;
@property (nonatomic ,strong) NSString *vehicleModel;
@property (nonatomic ,strong) NSString *vin;
@property (nonatomic ,strong) NSArray *productOfferSetMenus;
@property (nonatomic ,strong) NSArray *productOffers;

- (void)setModelForData:(NSDictionary *)dictionary;


@end

NS_ASSUME_NONNULL_END
