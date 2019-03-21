//
//  IWJNotifyHandler.h
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

#import <Foundation/Foundation.h>
#import "IWJNotify.h"

/**
 *  通知处理器接口
 */
@protocol IWJNotifyHandler <NSObject>

/**
 *  处理通知
 */
- (void)handle:(id<IWJNotify>)notify;

/**
 *  可处理通知类型
 */
+ (NSInteger)canHandleNotifyType;

/**
 *  实例方法
 */
+ (id<IWJNotifyHandler>)getInstance;

/**
 *  是否可处理
 */
- (BOOL)canHandle:(id<IWJNotify>)notify;

@end
