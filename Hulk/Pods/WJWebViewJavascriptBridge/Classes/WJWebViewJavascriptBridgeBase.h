//
//  WJWebViewJavascriptBridgeBase.h
//
//  Created by @LokiMeyburg on 10/15/14.
//  Copyright (c) 2014 @LokiMeyburg. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kWJCustomProtocolScheme @"wjwvjbscheme"
#define kWJQueueHasMessage      @"__WJ_WVJB_QUEUE_MESSAGE__"
#define kWJBridgeLoaded         @"__WJ_BRIDGE_LOADED__"

typedef void (^WJWVJBResponseCallback)(id responseData);
typedef void (^WJWVJBHandler)(id data, WJWVJBResponseCallback responseCallback);
typedef NSDictionary WJWVJBMessage;

@protocol WJWebViewJavascriptBridgeBaseDelegate <NSObject>
- (NSString*) _evaluateJavascript:(NSString*)javascriptCommand;
@end

@interface WJWebViewJavascriptBridgeBase : NSObject


@property (weak, nonatomic) id <WJWebViewJavascriptBridgeBaseDelegate> delegate;
@property (strong, nonatomic) NSMutableArray* startupMessageQueue;
@property (strong, nonatomic) NSMutableDictionary* responseCallbacks;
@property (strong, nonatomic) NSMutableDictionary* messageHandlers;
@property (strong, nonatomic) WJWVJBHandler messageHandler;

- (void)reset;
- (void)sendData:(id)data responseCallback:(WJWVJBResponseCallback)responseCallback handlerName:(NSString*)handlerName;
- (void)flushMessageQueue:(NSString *)messageQueueString;
- (void)injectJavascriptFile;
- (BOOL)isCorrectProcotocolScheme:(NSURL*)url;
- (BOOL)isQueueMessageURL:(NSURL*)urll;
- (BOOL)isBridgeLoadedURL:(NSURL*)urll;
- (void)logUnkownMessage:(NSURL*)url;
- (NSString *)webViewJavascriptCheckCommand;
- (NSString *)webViewJavascriptFetchQueyCommand;
- (void)disableJavscriptAlertBoxSafetyTimeout;

@end
