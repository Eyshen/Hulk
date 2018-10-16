//
//  WJWebViewJSBridgeConfig.m
//  WJWebViewJavascriptBridge-example
//
//  Created by 吴云海 on 16/10/8.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "WJWebViewJSBridgeConfig.h"
#import "WJConfig.h"

#define CONFIG_WEB_BRIDGE_VIEW_JS_BRIDGE_NAME   @"WJWebViewJavascriptBridge"
#define CONFIG_WEB_BRIDGE_ALLOW_HOSTS_NAME      @"allowHosts"
#define CONFIG_WEB_BRIDGE_ALLOW_SCHEMES_NAME    @"allowSchemes"
#define CONFIG_WEB_BRIDGE_ENABLED_HOST_VERIFY   @"enabledHostVerify"

@interface WJWebViewJSBridgeConfig ()

/**
 *  允许api域白名单
 *  item:WJWVAllowDomainData
 */
@property(nonatomic, strong) NSMutableArray *webViewAllowHosts;

@property(nonatomic, assign) BOOL enabledHostVerify;

@end

@implementation WJWebViewJSBridgeConfig

-(BOOL)isValidURL:(NSURL *)url {
    if (_enabledHostVerify) {
        BOOL isValid = NO;
        if (!url) {
            isValid = YES;
        } else if ([self.webViewAllowHosts count] > 1) {
            for (id<IWJAllowDomainData> data in _webViewAllowHosts) {
                isValid = [data isCorrectURL:url];
                if (isValid) break;        }
        }
        return isValid;
    }
    return YES;
}

-(void)addAllowHostData:(id<IWJAllowDomainData>)data {
    if (data) {
        [self.webViewAllowHosts addObject:data];
    }
}

- (id)copy {
    return self;
}

- (id)mutableCopy {
    return self;
}

- (void)singleInit {
    self.enabledHostVerify = YES;
    self.webViewAllowHosts = [[NSMutableArray alloc] init];
    [self addAllowHostData:WJ_WV_ALLOW_SCHEME(@"file")];
    //加载配置
    //加载配置
    NSDictionary *configs = [[WJConfig sharedInstance] getConfig:CONFIG_WEB_BRIDGE_VIEW_JS_BRIDGE_NAME];
    if ([[configs allKeys] containsObject:CONFIG_WEB_BRIDGE_ALLOW_HOSTS_NAME]) {
        id o = [configs objectForKey:CONFIG_WEB_BRIDGE_ALLOW_HOSTS_NAME];
        if ([o isKindOfClass:[NSArray class]]) {
            for (id item in o) {
                if ([item isKindOfClass:[NSString class]]) {
                    [self addAllowHostData:[[WJAllowHostData alloc] initWithHost:item allowSubHost:YES]];
                }
            }
        }
    }
    if ([[configs allKeys] containsObject:CONFIG_WEB_BRIDGE_ALLOW_SCHEMES_NAME]) {
        id o = [configs objectForKey:CONFIG_WEB_BRIDGE_ALLOW_SCHEMES_NAME];
        if ([o isKindOfClass:[NSArray class]]) {
            for (id item in o) {
                if ([item isKindOfClass:[NSString class]]) {
                    [self addAllowHostData:[[WJAllowSchemeData alloc] initWithScheme:item]];
                }
            }
        }
    }
    if ([[configs allKeys] containsObject:CONFIG_WEB_BRIDGE_ENABLED_HOST_VERIFY]) {
        id o = [configs objectForKey:CONFIG_WEB_BRIDGE_ENABLED_HOST_VERIFY];
        if ([o isKindOfClass:[NSNumber class]]) {
            self.enabledHostVerify = [(NSNumber*)o boolValue];
        }
    }
    
}

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static id sharedObject;
    dispatch_once( &once, ^{
        sharedObject = [[self alloc] init];
        [sharedObject singleInit];
    });
    return sharedObject;
}

@end
