//
//  WJNotifyCore.h
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

#import "AbstractWJBusinessObject.h"
#import "WJSingleton.h"
#import "IWJNotify.h"

@protocol IWJInjectConfig <NSObject>

- (void)injectNotifyHandle:(Class)clazz;

@end




/**
 *  通知处理中心
 */
@interface WJNotifyCore : AbstractWJBusinessObject<IWJInjectConfig>


AS_SINGLETON(WJNotifyCore)

/**
 *  处理通知
 */
- (void)handleNotify:(id<IWJNotify>)notify;

/**
 *  是否可处理此通知
 */
- (BOOL)canHandleNotify:(id<IWJNotify>)notify;

@end
