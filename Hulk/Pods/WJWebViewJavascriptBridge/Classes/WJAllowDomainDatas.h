//
//  WJAllowDomainDatas.h
//  WJWebViewJavascriptBridge-example
//
//  Created by 吴云海 on 16/10/8.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWJAllowDomainData.h"


#define WJ_WV_ALLOW_HOST(H,A)     ([[WJAllowHostData alloc] initWithHost:H allowSubHost:A])
#define WJ_WV_ALLOW_SCHEME(S)              ([[WJAllowSchemeData alloc] initWithScheme:S])




@interface WJAllowHostData : NSObject<IWJAllowDomainData>

/**
 *  主机头
 */
@property(nonatomic, copy) NSString *host;

/**
 *  允许子域名
 */
@property(nonatomic, assign) BOOL allowSubHost;

/**
 *  初始化方法
 */
- (instancetype)initWithHost:(NSString*)host allowSubHost:(BOOL)allowSubHost;

@end


@interface WJAllowSchemeData : NSObject<IWJAllowDomainData>


@property(nonatomic, copy) NSString *scheme;

/**
 *  初始化方法
 */
- (instancetype)initWithScheme:(NSString*)scheme;

@end
