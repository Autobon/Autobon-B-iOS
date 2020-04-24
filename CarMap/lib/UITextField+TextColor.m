//
//  UITextField+TextColor.m
//  CarMapB
//
//  Created by inCarL on 2020/4/22.
//  Copyright © 2020 mll. All rights reserved.
//

#import "UITextField+TextColor.h"

@implementation UITextField (TextColor)

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.textColor = [UIColor blackColor];
    }
    return self;
}


@end
