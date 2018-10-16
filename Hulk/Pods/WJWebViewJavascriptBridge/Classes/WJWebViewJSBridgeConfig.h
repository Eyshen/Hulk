//
//  WJWebViewJSBridgeConfig.h
//  WJWebViewJavascriptBridge-example
//
//  Created by 吴云海 on 16/10/8.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJAllowDomainDatas.h"

/**
 *  JS webview js交互配置
 */
@interface WJWebViewJSBridgeConfig : NSObject

/**
 *  验证是否为有效url
 */
- (BOOL)isValidURL:(NSURL*)url;

/**
 *  添加允许的host
 */
- (void)addAllowHostData:(id<IWJAllowDomainData>)data;


+ (instancetype)sharedInstance;

@end
