//
//  WJNotifyConfig.m
//  WJNotifyAPI-example
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by 吴云海 on 16/10/31.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "WJNotifyConfig.h"
#import "IWJNotifyHandler.h"
#import "WJNotifyCore.h"

@implementation WJNotifyConfig

+ (BOOL)registerHandler:(Class)clazz {
    if ([clazz conformsToProtocol:@protocol(IWJNotifyHandler)]) {
        [[WJNotifyCore sharedInstance] injectNotifyHandle:clazz];
        return YES;
    }
    return NO;
}

@end
