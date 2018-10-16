//
//  BaseWJHttpResponse.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/7/30.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import "BaseWJObject.h"
#import "IWJHttpResponse.h"
#import "WJLoggingMacros.h"

/**
 *  HTTP 响应基类
 */
@interface BaseWJHttpResponse : BaseWJObject<IWJHttpResponse>

@end
