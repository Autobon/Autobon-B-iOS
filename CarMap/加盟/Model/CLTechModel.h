//
//  CLTechModel.h
//  CarMapB
//
//  Created by inCar on 17/5/19.
//  Copyright © 2017年 mll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLTechModel : NSObject
@property (nonatomic ,strong) NSString *avatar;
@property (nonatomic ,strong) NSString *bank;
@property (nonatomic ,strong) NSString *bankAddress;
@property (nonatomic ,strong) NSString *bankCardNo;
@property (nonatomic ,strong) NSString *beautyLevel;
@property (nonatomic ,strong) NSString *beautyWorkingSeniority;
@property (nonatomic ,strong) NSString *carCoverLevel;
@property (nonatomic ,strong) NSString *carCoverWorkingSeniority;
@property (nonatomic ,strong) NSString *colorModifyLevel;
@property (nonatomic ,strong) NSString *colorModifyWorkingSeniority;
@property (nonatomic ,strong) NSString *createAt;
@property (nonatomic ,strong) NSString *filmLevel;
@property (nonatomic ,strong) NSString *filmWorkingSeniority;
@property (nonatomic ,strong) NSString *gender;
@property (nonatomic ,strong) NSString *idString;
@property (nonatomic ,strong) NSString *idNo;
@property (nonatomic ,strong) NSString *idPhoto;
@property (nonatomic ,strong) NSString *lastLoginAt;
@property (nonatomic ,strong) NSString *lastLoginIp;
@property (nonatomic ,strong) NSString *name;
@property (nonatomic ,strong) NSString *phone;
@property (nonatomic ,strong) NSString *reference;
@property (nonatomic ,strong) NSString *requestVerifyAt;
@property (nonatomic ,strong) NSString *resume;
@property (nonatomic ,strong) NSString *skill;
@property (nonatomic ,strong) NSString *status;
@property (nonatomic ,strong) NSString *verifyAt;
@property (nonatomic ,strong) NSString *verifyMsg;
@property (nonatomic ,strong) NSString *workStatus;

- (void)setModelForData:(NSDictionary *)dictionary;

@end
