//
//  WJWKWebViewJavascriptBridge.h
//
//  Created by @LokiMeyburg on 10/15/14.
//  Copyright (c) 2014 @LokiMeyburg. All rights reserved.
//

#if (__MAC_OS_X_VERSION_MAX_ALLOWED > __MAC_10_9 || __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_1)
#define supportsWKWebKit
#endif

#if defined(supportsWKWebKit )

#import <Foundation/Foundation.h>
#import "WJWebViewJavascriptBridgeBase.h"
#import <WebKit/WebKit.h>
#import "IWJWebViewJavascriptBridge.h"

@interface WJWKWebViewJavascriptBridge : NSObject<WKNavigationDelegate, WJWebViewJavascriptBridgeBaseDelegate,IWJWebViewJavascriptBridge>

+ (instancetype)bridgeForWebView:(WKWebView*)webView;
//- (void)registerHandler:(NSString*)handlerName handler:(WJWVJBHandler)handler;
//- (void)callHandler:(NSString*)handlerName;
//- (void)callHandler:(NSString*)handlerName data:(id)data;
//- (void)callHandler:(NSString*)handlerName data:(id)data responseCallback:(WJWVJBResponseCallback)responseCallback;
- (void)reset;
- (void)setWebViewDelegate:(id<WKNavigationDelegate>)webViewDelegate;
//- (void)disableJavscriptAlertBoxSafetyTimeout;

@end

#endif