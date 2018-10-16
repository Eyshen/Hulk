//
//  WJWebViewJavascriptBridge.m
//  ExampleApp-iOS
//
//  Created by Marcus Westin on 6/14/13.
//  Copyright (c) 2013 Marcus Westin. All rights reserved.
//

#import "WJWebViewJavascriptBridge.h"
#import "WJWebViewJSBridgeConfig.h"

#if __has_feature(objc_arc_weak)
    #define WVJB_WEAK __weak
#else
    #define WVJB_WEAK __unsafe_unretained
#endif

@implementation WJWebViewJavascriptBridge {
    WVJB_WEAK WJ_WVJB_WEBVIEW_TYPE* _webView;
    WVJB_WEAK id _webViewDelegate;
    long _uniqueId;
    WJWebViewJavascriptBridgeBase *_base;
}


+ (instancetype)bridgeForWebView:(WJ_WVJB_WEBVIEW_TYPE*)webView {
    WJWebViewJavascriptBridge* bridge = [[self alloc] init];
    [bridge _platformSpecificSetup:webView];
    return bridge;
}

- (void)setWebViewDelegate:(WJ_WVJB_WEBVIEW_DELEGATE_TYPE*)webViewDelegate {
    _webViewDelegate = webViewDelegate;
}

- (void)send:(id)data {
    [self send:data responseCallback:nil];
}

- (void)send:(id)data responseCallback:(WJWVJBResponseCallback)responseCallback {
    [_base sendData:data responseCallback:responseCallback handlerName:nil];
}

- (void)callHandler:(NSString *)handlerName {
    [self callHandler:handlerName data:nil responseCallback:nil];
}

- (void)callHandler:(NSString *)handlerName data:(id)data {
    [self callHandler:handlerName data:data responseCallback:nil];
}

- (void)callHandler:(NSString *)handlerName data:(id)data responseCallback:(WJWVJBResponseCallback)responseCallback {
    [_base sendData:data responseCallback:responseCallback handlerName:handlerName];
}

- (void)registerHandler:(NSString *)handlerName handler:(WJWVJBHandler)handler {
    _base.messageHandlers[handlerName] = [handler copy];
}

- (void)disableJavscriptAlertBoxSafetyTimeout {
    [_base disableJavscriptAlertBoxSafetyTimeout];
}


/* Platform agnostic internals
 *****************************/

- (void)dealloc {
    [self _platformSpecificDealloc];
    _base = nil;
    _webView = nil;
    _webViewDelegate = nil;
}

- (NSString*) _evaluateJavascript:(NSString*)javascriptCommand
{
    return [_webView stringByEvaluatingJavaScriptFromString:javascriptCommand];
}

/* Platform specific internals: OSX
 **********************************/
#if defined WJ_WVJB_PLATFORM_OSX

- (void) _platformSpecificSetup:(WJ_WVJB_WEBVIEW_TYPE*)webView {
    _webView = webView;
    
    _webView.policyDelegate = self;
    
    _base = [[WJWebViewJavascriptBridgeBase alloc] init];
    _base.delegate = self;
}

- (void) _platformSpecificDealloc {
    _webView.policyDelegate = nil;
}

- (void)webView:(WebView *)webView decidePolicyForNavigationAction:(NSDictionary *)actionInformation request:(NSURLRequest *)request frame:(WebFrame *)frame decisionListener:(id<WebPolicyDecisionListener>)listener
{
    if (webView != _webView) { return; }
    
    NSURL *url = [request URL];
    if ([_base isCorrectProcotocolScheme:url]) {
        if ([_base isBridgeLoadedURL:url]) {
            [_base injectJavascriptFile];
        } else if ([_base isQueueMessageURL:url]) {
            NSString *messageQueueString = [self _evaluateJavascript:[_base webViewJavascriptFetchQueyCommand]];
            [_base flushMessageQueue:messageQueueString];
        } else {
            [_base logUnkownMessage:url];
        }
        [listener ignore];
    } else if (_webViewDelegate && [_webViewDelegate respondsToSelector:@selector(webView:decidePolicyForNavigationAction:request:frame:decisionListener:)]) {
        if ([[WJWebViewJSBridgeConfig sharedInstance] isValidURL:url]) {
            [_webViewDelegate webView:webView decidePolicyForNavigationAction:actionInformation request:request frame:frame decisionListener:listener];
        }
    } else {
        [listener use];
    }
}

/* Platform specific internals: iOS
 **********************************/
#elif defined WJ_WVJB_PLATFORM_IOS

- (void) _platformSpecificSetup:(WJ_WVJB_WEBVIEW_TYPE*)webView {
    _webView = webView;
    _webView.delegate = self;
    _base = [[WJWebViewJavascriptBridgeBase alloc] init];
    _base.delegate = self;
}

- (void) _platformSpecificDealloc {
    _webView.delegate = nil;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (webView != _webView) { return; }
    
    __strong WJ_WVJB_WEBVIEW_DELEGATE_TYPE* strongDelegate = _webViewDelegate;
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [strongDelegate webViewDidFinishLoad:webView];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if (webView != _webView) { return; }
    
    __strong WJ_WVJB_WEBVIEW_DELEGATE_TYPE* strongDelegate = _webViewDelegate;
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [strongDelegate webView:webView didFailLoadWithError:error];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (webView != _webView) { return YES; }
    NSURL *url = [request URL];
    __strong WJ_WVJB_WEBVIEW_DELEGATE_TYPE* strongDelegate = _webViewDelegate;
    if ([_base isCorrectProcotocolScheme:url]) {
        if ([_base isBridgeLoadedURL:url]) {
            [_base injectJavascriptFile];
        } else if ([_base isQueueMessageURL:url]) {
            NSString *messageQueueString = [self _evaluateJavascript:[_base webViewJavascriptFetchQueyCommand]];
            [_base flushMessageQueue:messageQueueString];
        } else {
            [_base logUnkownMessage:url];
        }
        return NO;
    } else if (strongDelegate && [strongDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        if ([[WJWebViewJSBridgeConfig sharedInstance] isValidURL:url]) {
            return [strongDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
        } else {
            return NO;
        }
    } else {
        return [[WJWebViewJSBridgeConfig sharedInstance] isValidURL:url];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    if (webView != _webView) { return; }
    
    __strong WJ_WVJB_WEBVIEW_DELEGATE_TYPE* strongDelegate = _webViewDelegate;
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [strongDelegate webViewDidStartLoad:webView];
    }
}

-(BOOL)respondsToSelector:(SEL)aSelector {
    if ([super respondsToSelector:aSelector]) {
        return YES;
    }
    if ([_webViewDelegate respondsToSelector:aSelector]) {
        return YES;
    }
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    if(!signature) {
        if([_webViewDelegate respondsToSelector:selector]) {
            return [(NSObject *)_webViewDelegate methodSignatureForSelector:selector];
        }
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation*)invocation
{
    if ([_webViewDelegate respondsToSelector:[invocation selector]]) {
        [invocation invokeWithTarget:_webViewDelegate];
    }
}

#endif

@end
