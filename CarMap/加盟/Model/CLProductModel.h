//
//  CLProductModel.h
//  CarMapB
//
//  Created by inCarL on 2019/9/25.
//  Copyright © 2019 mll. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLProductModel : NSObject

@property (nonatomic) CGFloat cellHeight;

@property (nonatomic ,strong) NSString *brand;
@property (nonatomic ,strong) NSString *code;
@property (nonatomic ,strong) NSString *constructionCommission;
@property (nonatomic ,strong) NSString *constructionPosition;
@property (nonatomic ,strong) NSString *constructionPositionName;
@property (nonatomic ,strong) NSString *coopId;
@property (nonatomic ,strong) NSString *idString;
@property (nonatomic ,strong) NSString *model;
@property (nonatomic ,strong) NSString *name;
@property (nonatomic ,strong) NSString *price;
@property (nonatomic ,strong) NSString *scrapCost;
@property (nonatomic ,strong) NSString *starLevel;
@property (nonatomic ,strong) NSString *type;
@property (nonatomic ,strong) NSString *typeName;
@property (nonatomic ,strong) NSString *warranty;
@property (nonatomic ,strong) NSString *workingHours;

- (void)setModelForDictionary:(NSDictionary *)dictionary;


@end

NS_ASSUME_NONNULL_END
