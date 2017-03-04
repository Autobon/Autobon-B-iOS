//
//  CLAddPersonModel.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/29.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLAddPersonModel.h"

@implementation CLAddPersonModel


- (instancetype)initWithDictionary:(NSDictionary *)dic {
    
    self = [super init];
    
    if(self != nil) {
        
        _avatar = [NSString stringWithFormat:@"http://121.40.219.58:8000%@", dic[@"avatar"]];
        _jishiID = [NSString stringWithFormat:@"%@", dic[@"id"]];
        _name = [NSString stringWithFormat:@"%@", dic[@"name"]];
        _phone = [NSString stringWithFormat:@"%@", dic[@"phone"]];
        if(dic[@"orderCount"] == nil) {
        
            _orderCount = @"0";
        }else {
            
            _orderCount = [NSString stringWithFormat:@"%@", dic[@"orderCount"]];

        }
        _distance = [NSString stringWithFormat:@"%@", dic[@"distance"]];
        if(dic[@"distance"] == nil) {
            
            _distance = @"0";
        }
        _filmLevel = [NSString stringWithFormat:@"%@", dic[@"filmLevel"]];
        _fileWorkingSeniority = [NSString stringWithFormat:@"%@", dic[@"filmWorkingSeniority"]];
        _colorModifyLevel = [NSString stringWithFormat:@"%@", dic[@"colorModifyLevel"]];
        _colorModifyWorkingSeniority = [NSString stringWithFormat:@"%@", dic[@"colorModifyWorkingSeniority"]];
        _carCoverLevel = [NSString stringWithFormat:@"%@", dic[@"carCoverLevel"]];
        _carCoverWorkingSeniority = [NSString stringWithFormat:@"%@", dic[@"carCoverWorkingSeniority"]];
        _beautyLevel = [NSString stringWithFormat:@"%@", dic[@"beautyLevel"]];
        _beautyWorkingSeniority = [NSString stringWithFormat:@"%@", dic[@"beautyWorkingSeniority"]];
        _cancelCount = [NSString stringWithFormat:@"%@", dic[@"cancelCount"]];
        _evaluate = [NSString stringWithFormat:@"%@", dic[@"evaluate"]];
    }
    
    return self;
}



@end
