//
//  WJUIRoutableConfig.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/12/25.
//  Copyright © 2015年 WJ. All rights reserved.
//

#import "WJUIRoutableConfig.h"
#import <UIKit/UIKit.h>
#import "WJConfig.h"
#import "IWJRouterURLFormater.h"

@implementation WJUIRoutableConfig

DEF_SINGLETON_INIT(WJUIRoutableConfig)

-(void) singleInit {
    _defaultNavigationControllerClass = [UINavigationController class];
    
    NSDictionary *config = [[WJConfig sharedInstance] getConfig:@"WJUIRoutable"];
    if ([config.allKeys containsObject:@"defaultNavigationController"]) {
        id o = [config objectForKey:@"defaultNavigationController"];
        if ([o isKindOfClass:[NSString class]]) {
            Class clazz = NSClassFromString(o);
            if ([clazz isSubclassOfClass:[UINavigationController class]]) {
                _defaultNavigationControllerClass = clazz;
            }
        }
    }
    if ([config.allKeys containsObject:@"routerURLformatter"]) {
        id o = [config objectForKey:@"routerURLformatter"];
        if ([o isKindOfClass:[NSString class]]) {
            Class clazz = NSClassFromString(o);
            if ([clazz conformsToProtocol:@protocol(IWJRouterURLFormater)]) {
                _routerURLFormatter = clazz;
            }
        }
    }
}

@end
