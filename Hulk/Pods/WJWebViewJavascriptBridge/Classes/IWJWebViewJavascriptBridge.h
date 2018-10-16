//
//  IWJWebViewJavascriptBridge.h
//  WJWebViewJavascriptBridge-example
//
//  Created by 吴云海 on 16/6/29.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJWebViewJavascriptBridgeBase.h"

@protocol IWJWebViewJavascriptBridge <NSObject>

/**
 *  注册消息
 *
 *  @param handlerName 消息名称
 *  @param handler     处理器
 */
- (void)registerHandler:(NSString*)handlerName handler:(WJWVJBHandler)handler;

/**
 *  调用JS消息
 *
 *  @param handlerName 消息名称
 */
- (void)callHandler:(NSString*)handlerName;

/**
 *  调用JS消息
 *
 *  @param handlerName 消息名称
 *  @param data        参数
 */
- (void)callHandler:(NSString*)handlerName data:(id)data;

/**
 *  调用JS消息
 *
 *  @param handlerName      消息名称
 *  @param data             参数
 *  @param responseCallback 回调block
 */
- (void)callHandler:(NSString*)handlerName data:(id)data responseCallback:(WJWVJBResponseCallback)responseCallback;

/**
 *  禁止安全警告框超时
 */
- (void)disableJavscriptAlertBoxSafetyTimeout;

@end
