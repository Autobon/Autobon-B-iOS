//
//  CLProductPackageModel.h
//  CarMapB
//
//  Created by inCarL on 2019/10/9.
//  Copyright © 2019 mll. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLProductPackageModel : NSObject

@property (nonatomic, strong) NSString *idString;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *coopId;
@property (nonatomic, strong) NSString *productOfferIds;

-(void)setModelForDictionary:(NSDictionary *)dictionary;


@end

NS_ASSUME_NONNULL_END
