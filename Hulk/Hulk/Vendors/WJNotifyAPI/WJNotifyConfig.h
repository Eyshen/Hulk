//
//  WJNotifyConfig.h
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



/**
 *  通知配置
 */
@interface WJNotifyConfig : NSObject

/**
 *  注册通知处理器
 */
+ (BOOL)registerHandler:(Class)clazz;

@end
