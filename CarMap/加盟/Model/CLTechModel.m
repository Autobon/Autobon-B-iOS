//
//  CLTechModel.m
//  CarMapB
//
//  Created by inCar on 17/5/19.
//  Copyright © 2017年 mll. All rights reserved.
//

#import "CLTechModel.h"

@implementation CLTechModel

- (void)setModelForData:(NSDictionary *)dictionary{
    self.avatar = dictionary[@"avatar"];
    self.bank = dictionary[@"bank"];
    self.bankAddress = dictionary[@"bankAddress"];
    self.bankCardNo = dictionary[@"bankCardNo"];
    self.beautyLevel = dictionary[@"beautyLevel"];
    self.beautyWorkingSeniority = dictionary[@"beautyWorkingSeniority"];
    self.carCoverLevel = dictionary[@"carCoverLevel"];
    self.carCoverWorkingSeniority = dictionary[@"carCoverWorkingSeniority"];
    self.colorModifyLevel = dictionary[@"colorModifyLevel"];
    self.colorModifyWorkingSeniority = dictionary[@"colorModifyWorkingSeniority"];
    self.createAt = dictionary[@"createAt"];
    self.filmLevel = dictionary[@"filmLevel"];
    self.filmWorkingSeniority = dictionary[@"filmWorkingSeniority"];
    self.gender = dictionary[@"gender"];
    self.idString = dictionary[@"id"];
    self.idNo = dictionary[@"idNo"];
    self.idPhoto = dictionary[@"idPhoto"];
    self.lastLoginAt = dictionary[@"lastLoginAt"];
    self.lastLoginIp = dictionary[@"lastLoginIp"];
    self.name = dictionary[@"name"];
    self.phone = dictionary[@"phone"];
    self.requestVerifyAt = dictionary[@"requestVerifyAt"];
    self.reference = dictionary[@"reference"];
    self.resume = dictionary[@"resume"];
    self.skill = dictionary[@"skill"];
    self.status = dictionary[@"status"];
    self.verifyAt = dictionary[@"verifyAt"];
    self.verifyMsg = dictionary[@"verifyMsg"];
    self.workStatus = dictionary[@"workStatus"];

    
}


@end
