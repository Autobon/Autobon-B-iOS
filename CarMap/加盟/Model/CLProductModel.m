//
//  CLProductModel.m
//  CarMapB
//
//  Created by inCarL on 2019/9/25.
//  Copyright © 2019 mll. All rights reserved.
//

#import "CLProductModel.h"

@implementation CLProductModel

- (void)setModelForDictionary:(NSDictionary *)dictionary{
    self.brand = dictionary[@"brand"];
    self.code = dictionary[@"code"];
    self.constructionCommission = [NSString stringWithFormat:@"%@", dictionary[@"constructionCommission"]];
    self.constructionPosition = [NSString stringWithFormat:@"%@", dictionary[@"constructionPosition"]];
    self.constructionPositionName = [NSString stringWithFormat:@"%@", dictionary[@"constructionPositionName"]];
    if ([self.constructionPositionName isEqualToString:@"<null>"]){
        self.constructionPositionName = @"无";
    }
    self.coopId = [NSString stringWithFormat:@"%@", dictionary[@"coopId"]];
    self.idString = [NSString stringWithFormat:@"%@", dictionary[@"id"]];
    self.model = dictionary[@"model"];
    self.name = dictionary[@"name"];
    self.price = [NSString stringWithFormat:@"%@", dictionary[@"price"]];
    self.scrapCost = [NSString stringWithFormat:@"%@", dictionary[@"scrapCost"]];
    self.starLevel = [NSString stringWithFormat:@"%@", dictionary[@"starLevel"]];
    self.type = [NSString stringWithFormat:@"%@", dictionary[@"type"]];
    self.typeName = dictionary[@"typeName"];
    self.warranty = [NSString stringWithFormat:@"%@", dictionary[@"warranty"]];
    self.workingHours = [NSString stringWithFormat:@"%@", dictionary[@"workingHours"]];
    self.isSelect = NO;
}



@end
