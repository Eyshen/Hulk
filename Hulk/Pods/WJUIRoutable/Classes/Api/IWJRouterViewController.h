//
//  IWJRouterViewController.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/8/21.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWJRouterViewControllerDelegate.h"

/**
 路由视图控制器接口
 */
@protocol IWJRouterViewController <IWJRouterViewControllerDelegate>

/**
 *  回调委托
 */
@property (nonatomic, weak) id<IWJRouterViewControllerDelegate> routerDelegate;

/**
 *  路由视图控制器初始化方法
 *
 *  @param params   参数
 *  @param delegate 委托
 *
 *  @return 视图控制器
 */
-(id) initWithURL:(NSString*) URL routerParams:(NSDictionary*) params;

@end
