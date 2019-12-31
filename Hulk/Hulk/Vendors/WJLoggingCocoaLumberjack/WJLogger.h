//
//  WJLogger.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by 吴云海 on 15-12-13.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWJLogger.h"
#import "CocoaLumberjack.h"
/**
 *  日志记录器
 *  使用方法
 *  1、声明静态变量 ddLogLevel
 *  #ifdef DEBUG
 *       static const DDLogLevel ddLogLevel = DDLogLevelInfo;
 *   #else
 *       static const DDLogLevel ddLogLevel = DDLogLevelError;
 *   #endif
 */

#ifdef DEBUG
    static const DDLogLevel ddLogLevel = DDLogLevelAll;
#else
    static const DDLogLevel ddLogLevel = DDLogLevelOff;
#endif


@interface WJLogger : NSObject<IWJLogger>

@end
