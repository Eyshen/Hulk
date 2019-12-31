//
//  WJUIRoutableConfig.h
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

#import "AbstractWJBusinessObject.h"
#import "WJSingleton.h"
/**
 *  UI路由配置
 */
@interface WJUIRoutableConfig : AbstractWJBusinessObject

AS_SINGLETON(WJUIRoutableConfig)

/**
 *  默认导航视图控制器
 *  Default UINavigationController
 */
@property(nonatomic, readonly) Class defaultNavigationControllerClass;

/**
 *  默认导航视图控制器
 */
@property(nonatomic, readonly) Class routerURLFormatter;

@end
