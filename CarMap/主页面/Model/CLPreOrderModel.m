//
//  CLPreOrderModel.m
//  CarMapB
//
//  Created by inCarL on 2020/1/7.
//  Copyright © 2020 mll. All rights reserved.
//

#import "CLPreOrderModel.h"
#import "Commom.h"

@implementation CLPreOrderModel

- (void)setModelForData:(NSDictionary *)dictionary{
    self.idString = [NSString stringWithFormat:@"%@", dictionary[@"id"]];
    
    NSString *agreedStartTime = [NSString stringWithFormat:@"%@",dictionary[@"agreedStartTime"]];
    if ([agreedStartTime isEqualToString:@"<null>"]){
        self.agreedStartTime = @"";
    }else{
        NSDate *startDate = [Commom timeIntervalToDateWithTimeInterval:[agreedStartTime doubleValue]/1000];
        self.agreedStartTime = [Commom dateToHHMMStringWithDate:startDate];
    }
    self.license = [NSString stringWithFormat:@"%@",dictionary[@"license"]];
    if ([self.license isEqualToString:@"<null>"]){
        self.license = @"";
    }
    self.mark = [NSString stringWithFormat:@"%@",dictionary[@"mark"]];
    if ([self.mark isEqualToString:@"<null>"]){
        self.mark = @"";
    }
    self.remark = [NSString stringWithFormat:@"%@",dictionary[@"remark"]];
    if ([self.remark isEqualToString:@"<null>"]){
        self.remark = @"";
    }
    self.vehicleModel = [NSString stringWithFormat:@"%@",dictionary[@"vehicleModel"]];
    if ([self.vehicleModel isEqualToString:@"<null>"]){
        self.vehicleModel = @"";
    }
    self.vin = [NSString stringWithFormat:@"%@",dictionary[@"vin"]];
    if ([self.vin isEqualToString:@"<null>"]){
        self.vin = @"";
    }
    NSArray *productOffers = dictionary[@"productOffers"];
    if ([productOffers isKindOfClass:[NSArray class]]){
        self.productOffers = productOffers;
    }
    NSArray *productOfferSetMenus = dictionary[@"productOfferSetMenus"];
    if ([productOfferSetMenus isKindOfClass:[NSArray class]]){
        self.productOfferSetMenus = productOfferSetMenus;
    }
}


@end
