//
//  AppBaseHttpResponse.h
//  Hulk
//
//  Created by zhangyi on 16/4/21.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "BaseWJHttpResponse.h"


#define JCC_HTTP_RES_DATA_ERROR_MSG         @"网络好像不稳定，请稍后再试"

/**
 *  http 借口响应基类
 */
@interface AppBaseHttpResponse : BaseWJHttpResponse

/**
 *  响应状态码
 */
@property (nonatomic, copy) NSString *retCode;

/**
 *  响应状态消息
 */
@property (nonatomic, copy) NSString *retMsg;


@end
