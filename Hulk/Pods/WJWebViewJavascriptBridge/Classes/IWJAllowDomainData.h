//
//  IWJAllowDomainData.h
//  WJWebViewJavascriptBridge-example
//
//  Created by 吴云海 on 16/10/8.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  允许加载域
 */
@protocol IWJAllowDomainData <NSObject>

/**
 *  是否为有效url
 */
- (BOOL)isCorrectURL:(NSURL*)url;

@end
