//
//  IWJHttpResponse.h
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

/**
 *  HTTP 响应接口
 */
@protocol IWJHttpResponse <NSObject>

/**
 *  解析响应结果
 *
 *  @param responseString 响应字符串
 *
 *  @return 响应对象
 */
+(id<IWJHttpResponse>) parseResult:(NSData*) responseData;

@optional
/**
 *  是否存在逻辑错误
 */
-(BOOL) isError;

/**
 *  服务端返回的逻辑错误码
 */
-(NSString*) errorCode;

/**
 *  服务端返回的逻辑错误说明
 */
-(NSString*) errorMsg;

@end
