//
//  WJRouterParams.h
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

#import <Foundation/Foundation.h>
#import "WJRouterOptions.h"

@interface WJRouterParams : NSObject
//路由参数
@property (readwrite, nonatomic, strong) WJRouterOptions *routerOptions;
//打开参数
@property (readwrite, nonatomic, strong) NSDictionary *openParams;
//额外参数
@property (readwrite, nonatomic, strong) NSDictionary *extraParams;
//控制器参数
@property (readwrite, nonatomic, strong) NSDictionary *controllerParams;
- (id)initWithRouterOptions: (WJRouterOptions *)routerOptions openParams: (NSDictionary *)openParams extraParams: (NSDictionary *)extraParams;
- (NSDictionary *)getControllerParams;
@end
