//
//  WJWebViewJavascriptBridge.h
//  ExampleApp-iOS
//
//  Created by Marcus Westin on 6/14/13.
//  Copyright (c) 2013 Marcus Westin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJWebViewJavascriptBridgeBase.h"
#import "IWJWebViewJavascriptBridge.h"

#if defined __MAC_OS_X_VERSION_MAX_ALLOWED
    #import <WebKit/WebKit.h>
    #define WJ_WVJB_PLATFORM_OSX
    #define WJ_WVJB_WEBVIEW_TYPE WebView
    #define WJ_WVJB_WEBVIEW_DELEGATE_TYPE NSObject<WJWebViewJavascriptBridgeBaseDelegate>
    #define WJ_WVJB_WEBVIEW_DELEGATE_INTERFACE NSObject<WJWebViewJavascriptBridgeBaseDelegate, WebPolicyDelegate, IWJWebViewJavascriptBridge>
#elif defined __IPHONE_OS_VERSION_MAX_ALLOWED
    #import <UIKit/UIWebView.h>
    #define WJ_WVJB_PLATFORM_IOS
    #define WJ_WVJB_WEBVIEW_TYPE UIWebView
    #define WJ_WVJB_WEBVIEW_DELEGATE_TYPE NSObject<UIWebViewDelegate>
    #define WJ_WVJB_WEBVIEW_DELEGATE_INTERFACE NSObject<UIWebViewDelegate, WJWebViewJavascriptBridgeBaseDelegate, IWJWebViewJavascriptBridge>
#endif

@interface WJWebViewJavascriptBridge : WJ_WVJB_WEBVIEW_DELEGATE_INTERFACE

+ (instancetype)bridgeForWebView:(WJ_WVJB_WEBVIEW_TYPE*)webView;

//- (void)registerHandler:(NSString*)handlerName handler:(WJWVJBHandler)handler;
//- (void)callHandler:(NSString*)handlerName;
//- (void)callHandler:(NSString*)handlerName data:(id)data;
//- (void)callHandler:(NSString*)handlerName data:(id)data responseCallback:(WJWVJBResponseCallback)responseCallback;
- (void)setWebViewDelegate:(WJ_WVJB_WEBVIEW_DELEGATE_TYPE*)webViewDelegate;
//- (void)disableJavscriptAlertBoxSafetyTimeout;

@end
