//
//  AppBaseViewModel.m
//  WJCommon-master
//
//  Created by 吴云海 on 16-2-27.
//  Copyright (c) 2016年 WJ. All rights reserved.
//

#import "AppBaseViewModel.h"

@implementation AppBaseViewModel

-(instancetype)initWithRouterParams:(NSDictionary *)params {
    self = [super init];
    if (self) {
        self.routerParams = params;
    }
    return self;
}

@end
