//
//  BaseWJHttpResponse.m
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

#import "BaseWJHttpResponse.h"

@implementation BaseWJHttpResponse

+(id<IWJHttpResponse>)parseResult:(NSData*)responseData {
    return nil;
}

/**
 *  是否存在逻辑错误
 */
-(BOOL) isError {
    return NO;
}

/**
 *  服务端返回的逻辑错误码
 */
-(NSString*) errorCode {
    return nil;
}

/**
 *  服务端返回的逻辑错误说明
 */
-(NSString*) errorMsg {
    return nil;
}

@end
