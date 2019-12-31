//
//  WJHttpFactory.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/7/29.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import "WJHttpFactory.h"
#import "WJLoggingMacros.h"
#import "WJHttpEngineConfig.h"


@implementation WJHttpFactory

+(id<IWJHttpEngine>)buildHttpEngine {
    id<IWJHttpEngine> httpEngine = nil;
    NSString *engineClazzName = [[WJHttpEngineConfig sharedInstance] defaultEngineName];
    Class engineClazz = NSClassFromString(engineClazzName);
    if (engineClazz) {
        if ([engineClazz conformsToProtocol:@protocol(IWJHttpEngine)]) {
            httpEngine = [[engineClazz alloc] init];
            WJLogDebug(@"构建 %@",NSStringFromClass(engineClazz));
        } else {
            NSString *reason = [NSString stringWithFormat:@"%@ 没有实现协议 IWJHttpEngine",engineClazzName];
            WJLogError(reason);
            @throw [NSException exceptionWithName:@"WJHttpFactoryException" reason:reason userInfo:nil];
        }
    } else {
        NSString *reason = [NSString stringWithFormat:@"%@ 不是有效的 HTTP 引擎,请在WJHttpEngineConfig 中配置",engineClazzName];
        @throw [NSException exceptionWithName:@"WJHttpFactoryException" reason:reason userInfo:nil];
        WJLogError(reason);
    }
    return httpEngine;
}

@end
