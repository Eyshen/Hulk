//
//  WJNetworkContextConfig.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by 吴云海 on 15-12-27.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import "WJNetworkContextConfig.h"

@implementation WJNetworkContextConfig

DEF_SINGLETON(WJNetworkContextConfig)


-(void)setCheckServerHost:(NSString *)host {
    if (host) {
        _serverHost = [host copy];
    }
}

@end
