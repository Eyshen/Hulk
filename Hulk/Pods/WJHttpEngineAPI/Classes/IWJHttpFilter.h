//
//  IWJHttpFilter.h
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

@protocol IWJHttpResponse;

/**
 *  HTTP 结果 过滤器
 */
@protocol IWJHttpFilter <NSObject>

/**
 *  HTTP 响应结果过滤器
 *
 *  @param res 响应结果
 *
 *  @return YES:向后继续过滤  NO:做拦截处理，不向后继续过滤
 */
-(BOOL) doFilter:(id<IWJHttpResponse>) res;

/**
 *  过滤源数据
 */
-(BOOL) doFilterData:(id) resData;

@end
