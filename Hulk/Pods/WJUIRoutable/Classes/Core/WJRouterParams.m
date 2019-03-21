//
//  WJRouterParams.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/8/24.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import "WJRouterParams.h"

@implementation WJRouterParams
- (instancetype)initWithRouterOptions: (WJRouterOptions *)routerOptions openParams: (NSDictionary *)openParams extraParams: (NSDictionary *)extraParams{
    self = [super init];
    if (self) {
        [self setRouterOptions:routerOptions];
        [self setExtraParams: extraParams];
        [self setOpenParams:openParams];
    }
    return self;
}

- (NSDictionary *)controllerParams {
    NSMutableDictionary *controllerParams = [NSMutableDictionary dictionaryWithDictionary:self.routerOptions.defaultParams];
    [controllerParams addEntriesFromDictionary:self.extraParams];
    [controllerParams addEntriesFromDictionary:self.openParams];
    return controllerParams;
}
- (NSDictionary *)getControllerParams {
    return [self controllerParams];
}

@end
