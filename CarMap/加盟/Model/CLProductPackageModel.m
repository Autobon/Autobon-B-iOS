//
//  CLProductPackageModel.m
//  CarMapB
//
//  Created by inCarL on 2019/10/9.
//  Copyright © 2019 mll. All rights reserved.
//

#import "CLProductPackageModel.h"

@implementation CLProductPackageModel

-(void)setModelForDictionary:(NSDictionary *)dictionary{
    self.idString = [NSString stringWithFormat:@"%@", dictionary[@"id"]];
    self.name = dictionary[@"name"];
    self.coopId = [NSString stringWithFormat:@"%@", dictionary[@"coopId"]];
    self.productOfferIds = dictionary[@"productOfferIds"];
}


@end
