//
//  CLWorkerModel.h
//  CarMap
//
//  Created by 李孟龙 on 16/4/8.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLWorkerModel : NSObject

@property (nonatomic ,strong) NSString *name;       // 姓名
@property (nonatomic ,strong) NSString *mainString; // 管理员
@property (nonatomic ,strong) NSString *workerId;   // 员工账户ID
@property (nonatomic) BOOL fired;                   // 是否离职

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *sex;



@end
