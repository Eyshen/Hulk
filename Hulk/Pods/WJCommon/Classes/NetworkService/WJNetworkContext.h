//
//  WJNetworkContext.h
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

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "WJSingleton.h"


/**
 *  网络环境工具类
 */
@interface WJNetworkContext : NSObject

AS_SINGLETON(WJNetworkContext)

/**
 *  是否已联网
 *
 *  @return 联网结果
 */
-(BOOL) isConnection;

/**
 *  当前网络状态
 *
 *  @return 状态值
 */
-(NetworkStatus) currentStatus;

/**
 *  添加网络变化通知
 *
 *  @param target
 *  @param selector
 */
-(void) addNotification:(id) target selector:(SEL) selector;

/**
 *  删除网络变化通知
 *
 *  @param target
 */
-(void) removeNotification:(id) target;


@end
