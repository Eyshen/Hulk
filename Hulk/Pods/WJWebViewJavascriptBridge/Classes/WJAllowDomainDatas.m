//
//  WJAllowDomainDatas.m
//  WJWebViewJavascriptBridge-example
//
//  Created by 吴云海 on 16/10/8.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "WJAllowDomainDatas.h"


@implementation WJAllowHostData

- (instancetype)initWithHost:(NSString *)host allowSubHost:(BOOL)allowSubHost {
    self = [super init];
    if (self) {
        self.host = host;
        self.allowSubHost = allowSubHost;
        MAX(10, 11);
    }
    return self;
}

-(void)setHost:(NSString *)host {
    _host = [[host lowercaseString] copy];
}

#pragma MARK IWJAllowDomainData
-(BOOL)isCorrectURL:(NSURL *)url {
    NSString *lowercaseHost = [[url host] lowercaseString];
    if (_allowSubHost) {
        return [lowercaseHost hasSuffix:_host];
    } else {
        return [lowercaseHost isEqualToString:_host];
    }
}


@end

@implementation WJAllowSchemeData

- (instancetype)initWithScheme:(NSString *)scheme {
    self = [super init];
    if (self) {
        self.scheme = scheme;
    }
    return self;
}

#pragma MARK IWJAllowDomainData
-(BOOL)isCorrectURL:(NSURL *)url {
    NSString *scheme = [url scheme];
    if ([scheme isEqualToString:_scheme]) {
        return YES;
    }
    return NO;
}

@end
