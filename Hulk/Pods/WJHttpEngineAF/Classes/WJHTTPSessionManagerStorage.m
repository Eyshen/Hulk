//
//  WJHTTPSessionManagerStorage.m
//  WJHttpEngineAF-example
//
//  Created by wuyunhai on 16/4/25.
//  Copyright © 2016年 jucaicat. All rights reserved.
//

#import "WJHTTPSessionManagerStorage.h"
#import "WJHttpEngineConfig.h"

@interface WJHTTPSessionManagerStorage ()
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@end

@implementation WJHTTPSessionManagerStorage

DEF_SINGLETON_INIT(WJHTTPSessionManager)

-(void) setMaxConcurrentCount:(NSInteger) concurrentCount {
    if (concurrentCount > 0) {
        [[self.sessionManager operationQueue] setMaxConcurrentOperationCount:concurrentCount];
    }
}

-(void) singleInit {
    //单利初始化
    self.sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSMutableSet *cerSet = nil;
    NSArray *cerPaths = [[WJHttpEngineConfig sharedInstance] certificatesPaths];
    if ([cerPaths count] > 0) {
        cerSet = [[NSMutableSet alloc] init];
        for (NSString *p in cerPaths) {
            NSData *data = [[NSData alloc] initWithContentsOfFile:p];
            if (data) {
                [cerSet addObject:data];
            }
        }
    }
    if ([cerSet count] > 0) {
        AFSecurityPolicy *afSecurityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:cerSet];
        [self.sessionManager setSecurityPolicy:afSecurityPolicy];
    }
    //允许无效的SSL证书
    [self.sessionManager.securityPolicy setAllowInvalidCertificates:[[WJHttpEngineConfig sharedInstance] allowInvalidCertificates]];
    [[self.sessionManager operationQueue] setMaxConcurrentOperationCount:5];
}

-(AFHTTPSessionManager *)defaultSessionManager {
    return _sessionManager;
}

@end
