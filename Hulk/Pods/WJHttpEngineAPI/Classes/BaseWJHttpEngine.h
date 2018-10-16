//
//  BaseWJHttpEngine.h
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
#import "IWJHttpFilter.h"
#import "IWJHttpRequest.h"
#import "IWJHttpResponse.h"
#import "WJHttpFilterCore.h"
#import "WJLoggingMacros.h"
/**
 *  HTTP 引擎基类
 *  不要直接使用此类（要继承）
 */
@interface BaseWJHttpEngine : NSObject

@property (nonatomic, copy) WJHttpEngineResponseBlock resBlock;
@property (nonatomic, copy) WJHttpEngineNativeResponseBlock nativeResBlock;

@property (nonatomic, copy) WJHttpEngineDownloadResponseBlock downloadResBlock;
@property (nonatomic, copy) WJHttpEngineProgressBlock progressBlock;

@property (atomic, assign) BOOL loading;//是否在加载中
@end
