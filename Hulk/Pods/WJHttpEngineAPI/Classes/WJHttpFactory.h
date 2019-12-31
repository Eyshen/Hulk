//
//  WJHttpFactory.h
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
#import "IWJHttpEngine.h"

/**
 *  Http 组件工厂
 */
@interface WJHttpFactory : NSObject

/**
 *  创建一个HttpEngine
 */
+(id<IWJHttpEngine>) buildHttpEngine;

@end
