//
//  AFWJHttpEngine.m
//  WJHttpEngineAF-example
//
//  Created by wuyunhai on 16/4/25.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "AFWJHttpEngine.h"
#import "AFHTTPSessionManager.h"
#import "AFURLRequestSerialization.h"
#import "AFURLResponseSerialization.h"
#import "WJStringUtils.h"
#import "WJFileUtils.h"
#import "WJHttpEngineConfig.h"
#import "WJHTTPSessionManagerStorage.h"
#import "IWJUploadFileInfo.h"
#import "WJNetworkActivityService.h"

@interface AFWJHttpEngine ()
@property (nonatomic) dispatch_semaphore_t sem;

@property (nonatomic, weak) NSURLSessionTask *sessionTask;
@end

@implementation AFWJHttpEngine

-(instancetype)init {
    self = [super init];
    if (self) {
        if (_sem == NULL) {
            self.sem = dispatch_semaphore_create(0);
        }
    }
    return self;
}

#pragma mark IWJHttpEngine
-(BOOL)hasLoading {
    return self.loading;
}

/**
 *  异步调用
 */
-(void)asynRequest:(id<IWJHttpRequest>)request responseClass:(Class)resClass responseBlock:(WJHttpEngineResponseBlock)resBlock {
    
    WJLogDebug(@"HTTP Asyn Request");
    BOOL validateResult = NO;
    NSError *validateError = nil;
    if ([request respondsToSelector:@selector(validateParamsByError:)]) {
        [request validateParamsByError:&validateError];
        if (!validateError) {
            validateResult = YES;
        }
    } else {
        validateResult = [request validateParams];
    }
    
    if (request && resClass != Nil && [resClass conformsToProtocol:@protocol(IWJHttpResponse)] && validateResult && ![self hasLoading]) {
        WJLogDebug(@"HTTP validateParams SUCCESS");
        
        //检查网络
        
        NSString *method = [[request getMethod] uppercaseString];
        NSString *url = [request getURL];
        NSDictionary *params = [request getParams];
        NSDictionary *headers = [request getHeaders];
        NSDictionary *uploadFiles = [request getUploadFiles];
        BOOL existUploadFile = [request existUploadFile];
        BOOL hideNetworkActivityIndicator = [request hideNetworkActivityIndicator];
        long timeoutDuration = [request getTimeoutDuration] <= 0 ? [[WJHttpEngineConfig sharedInstance] defaultTimeoutDuration] : [request getTimeoutDuration];

//        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        AFHTTPSessionManager *manager = [[WJHTTPSessionManagerStorage sharedInstance] defaultSessionManager];
        
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager.requestSerializer setTimeoutInterval:timeoutDuration];
        if ([headers count] > 0) {
            WJLogDebug(@"HTTP Headers:%@",headers);
            NSArray *keys = [headers allKeys];
            for (NSString *key in keys) {
                if ([[headers objectForKey:key] isKindOfClass:[NSString class]]) {
                    [manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
                }
            }
        }
        WJ_BLOCK_WEAK AFWJHttpEngine *selfObjectRef = self;
        if (WJ_STRING_EQUAL(method, HTTP_METHOD_GET)) {
            
            self.resBlock = resBlock;
            
            if (!hideNetworkActivityIndicator) {
                [[WJNetworkActivityService sharedInstance] start];
            }
            self.loading = YES;
            WJLogDebug(@"HTTP GET url:%@ params:%@",url,params);
            self.sessionTask = [manager GET:url parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (!hideNetworkActivityIndicator) {
                    [[WJNetworkActivityService sharedInstance] stop];
                }
                selfObjectRef.loading = NO;
                WJLogDebug(@"HTTP Response SUCCESS~");
                
                id<IWJHttpResponse> response = [resClass parseResult:responseObject];
                [[WJHttpFilterCore sharedInstance] filter:response];
                if (selfObjectRef.resBlock != NULL) {
                    selfObjectRef.resBlock(response,nil);
                    selfObjectRef.resBlock = NULL;
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (!hideNetworkActivityIndicator) {
                    [[WJNetworkActivityService sharedInstance] stop];
                }
                WJLogDebug(@"HTTP Response Error:%@",error);
                selfObjectRef.loading = NO;
                if (selfObjectRef.resBlock != NULL) {
                    selfObjectRef.resBlock(nil,error);
                    selfObjectRef.resBlock = NULL;
                }
            }];
        } else if (WJ_STRING_EQUAL(method, HTTP_METHOD_POST)) {
            
            self.resBlock = resBlock;
            
            self.loading = YES;
            if (!hideNetworkActivityIndicator) {
                [[WJNetworkActivityService sharedInstance] start];
            }
            WJLogDebug(@"HTTP %@ url:%@",method,url);
            WJLogDebug(@"HTTP Params:%@",params);
            if (existUploadFile) {
                self.sessionTask = [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    NSArray *allKeys = [uploadFiles allKeys];
                    for (NSString *key in allKeys) {
                        id val = uploadFiles[key];
                        if ([val conformsToProtocol:@protocol(IWJUploadFileInfo)]) {
                            id<IWJUploadFileInfo> fileInfo = (id<IWJUploadFileInfo>)val;
                            NSString *fileName = [fileInfo fileName];
                            NSString *filePath = [fileInfo filePath];
                            NSString *miniType = [fileInfo mimeType];
                            if ([WJFileUtils existFile:filePath]) {
                                [formData appendPartWithFileData:[NSData dataWithContentsOfFile:filePath] name:key fileName:fileName mimeType:miniType];
                            }
                        } else if ([val isKindOfClass:[NSString class]]) {
                            NSString *filePath = (NSString*)val;
                            if ([WJFileUtils existFile:filePath]) {
                                [formData appendPartWithFormData:[NSData dataWithContentsOfFile:filePath] name:key];
                            }
                        }
                    }
                } progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if (!hideNetworkActivityIndicator) {
                        [[WJNetworkActivityService sharedInstance] stop];
                    }
                    selfObjectRef.loading = NO;
                    WJLogDebug(@"HTTP Response SUCCESS~");
                    id<IWJHttpResponse> response = [resClass parseResult:responseObject];
                    [[WJHttpFilterCore sharedInstance] filter:response];
                    if (selfObjectRef.resBlock != NULL) {
                        selfObjectRef.resBlock(response,nil);
                        selfObjectRef.resBlock = NULL;
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    if (!hideNetworkActivityIndicator) {
                        [[WJNetworkActivityService sharedInstance] stop];
                    }
                    WJLogDebug(@"HTTP Response Error:%@",error);
                    selfObjectRef.loading = NO;
                    if (selfObjectRef.resBlock != NULL) {
                        selfObjectRef.resBlock(nil,error);
                        selfObjectRef.resBlock = NULL;
                    }
                }];
            } else {
                self.sessionTask = [manager POST:url parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if (!hideNetworkActivityIndicator) {
                        [[WJNetworkActivityService sharedInstance] stop];
                    }
                    selfObjectRef.loading = NO;
                    WJLogDebug(@"HTTP Response SUCCESS~");
                    id<IWJHttpResponse> response = [resClass parseResult:responseObject];
                    [[WJHttpFilterCore sharedInstance] filter:response];
                    if (selfObjectRef.resBlock != NULL) {
                        selfObjectRef.resBlock(response,nil);
                        selfObjectRef.resBlock = NULL;
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    if (!hideNetworkActivityIndicator) {
                        [[WJNetworkActivityService sharedInstance] stop];
                    }
                    selfObjectRef.loading = NO;
                    WJLogDebug(@"HTTP Response Error:%@",error);
                    if (selfObjectRef.resBlock != NULL) {
                        selfObjectRef.resBlock(nil,error);
                        selfObjectRef.resBlock = NULL;
                    }
                }];
            }
        } else {
            WJLogError(@"暂时不支持%@请求",method);
            NSError *error = [NSError errorWithDomain:@"AFWJHttpEngineDomain" code:-1 userInfo:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"暂不支持此方法'%@'请求",method] forKey:NSLocalizedDescriptionKey]];
            resBlock(nil, error);
        }
    } else {
        WJLogError(@"HTTP validateParams Fail");
        if (!validateError) {
            validateError = [NSError errorWithDomain:@"AFWJHttpEngineDomain" code:-1 userInfo:[NSDictionary dictionaryWithObject:@"不符合请求条件" forKey:NSLocalizedDescriptionKey]];
        }
        if (resBlock != NULL) {
            resBlock(nil, validateError);
        }
    }
}

-(void)asynRequestURL:(NSString *)url method:(NSString *)method params:(NSDictionary *)params responseBlock:(WJHttpEngineNativeResponseBlock)nativeResBlock {
    [self asynRequestURL:url method:method params:params headers:nil responseBlock:nativeResBlock];
}

-(void)asynRequestURL:(NSString *)url method:(NSString *)method params:(NSDictionary *)params headers:(NSDictionary *)headers responseBlock:(WJHttpEngineNativeResponseBlock)nativeResBlock {
    
    WJLogDebug(@"HTTP Asyn Request");
    if (WJ_STRING_IS_NOT_EMPTY(url) && ![self hasLoading]) {
        WJLogDebug(@"HTTP validateParams SUCCESS");
        
//        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        AFHTTPSessionManager *manager = [[WJHTTPSessionManagerStorage sharedInstance] defaultSessionManager];
        
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager.requestSerializer setTimeoutInterval:(NSTimeInterval)[[WJHttpEngineConfig sharedInstance] defaultTimeoutDuration]];
        if ([headers count] > 0) {
            WJLogDebug(@"HTTP Headers:%@",headers);
            NSArray *keys = [headers allKeys];
            for (NSString *key in keys) {
                if ([[headers objectForKey:key] isKindOfClass:[NSString class]]) {
                    [manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
                }
            }
        }
        
        WJ_BLOCK_WEAK AFWJHttpEngine *selfObjectRef = self;
        if (WJ_STRING_EQUAL(method, HTTP_METHOD_GET)) {
            self.nativeResBlock = nativeResBlock;
            
            if ([[WJHttpEngineConfig sharedInstance] defaultNetworkActivityEnabled]) {
                [[WJNetworkActivityService sharedInstance] start];
            }
            self.loading = YES;
            WJLogDebug(@"HTTP GET url:%@ params:%@",url,params);
            self.sessionTask = [manager GET:url parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if ([[WJHttpEngineConfig sharedInstance] defaultNetworkActivityEnabled]) {
                    [[WJNetworkActivityService sharedInstance] stop];
                }
                selfObjectRef.loading = NO;
                WJLogDebug(@"HTTP Response SUCCESS~");
                if (selfObjectRef.nativeResBlock != NULL) {
                    selfObjectRef.nativeResBlock(responseObject, nil);
                    selfObjectRef.nativeResBlock = NULL;
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if ([[WJHttpEngineConfig sharedInstance] defaultNetworkActivityEnabled]) {
                    [[WJNetworkActivityService sharedInstance] stop];
                }
                WJLogDebug(@"HTTP Response Error:%@",error);
                selfObjectRef.loading = NO;
                if (selfObjectRef.nativeResBlock != NULL) {
                    selfObjectRef.nativeResBlock(nil, error);
                    selfObjectRef.nativeResBlock = NULL;
                }
            }];
        } else if (WJ_STRING_EQUAL(method, HTTP_METHOD_POST)) {
            self.nativeResBlock = nativeResBlock;
            self.loading = YES;
            if ([[WJHttpEngineConfig sharedInstance] defaultNetworkActivityEnabled]) {
                [[WJNetworkActivityService sharedInstance] start];
            }
            WJLogDebug(@"HTTP %@ url:%@",method,url);
            WJLogDebug(@"HTTP Params:%@",params);
            self.sessionTask = [manager POST:url parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if ([[WJHttpEngineConfig sharedInstance] defaultNetworkActivityEnabled]) {
                    [[WJNetworkActivityService sharedInstance] stop];
                }
                selfObjectRef.loading = NO;
                WJLogDebug(@"HTTP Response SUCCESS~");
                if (selfObjectRef.nativeResBlock != NULL) {
                    selfObjectRef.nativeResBlock(responseObject, nil);
                    selfObjectRef.nativeResBlock = NULL;
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if ([[WJHttpEngineConfig sharedInstance] defaultNetworkActivityEnabled]) {
                    [[WJNetworkActivityService sharedInstance] stop];
                }
                selfObjectRef.loading = NO;
                WJLogDebug(@"HTTP Response Error:%@",error);
                if (selfObjectRef.nativeResBlock != NULL) {
                    selfObjectRef.nativeResBlock(nil,error);
                    selfObjectRef.nativeResBlock = NULL;
                }
            }];
        } else {
            WJLogError(@"暂时不支持%@请求",method);
            NSError *error = [NSError errorWithDomain:@"AFWJHttpEngineDomain" code:-1 userInfo:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"暂不支持此方法'%@'请求",method] forKey:NSLocalizedDescriptionKey]];
            nativeResBlock(nil, error);
        }
    } else {
        WJLogError(@"HTTP validateParams Fail");
        NSError *error = [NSError errorWithDomain:@"AFWJHttpEngineDomain" code:-1 userInfo:[NSDictionary dictionaryWithObject:@"网络忙！" forKey:NSLocalizedDescriptionKey]];
        nativeResBlock(nil, error);
    }
}

/**
 *  同步调用
 */
-(id<IWJHttpResponse>) syncRequest:(id<IWJHttpRequest>) request
                     responseClass:(Class) resClass
                             error:(NSError**) error {
    
    __block id<IWJHttpResponse> responseObject = nil;
    
    WJLogDebug(@"HTTP Asyn Request");
    BOOL validateResult = NO;
    if ([request respondsToSelector:@selector(validateParamsByError:)]) {
        [request validateParamsByError:error];
        if (nil == error) {
            validateResult = YES;
        }
    } else {
        validateResult = [request validateParams];
    }
    
    if (request && resClass != Nil && [resClass conformsToProtocol:@protocol(IWJHttpResponse)] && validateResult && ![self hasLoading]) {
        WJLogDebug(@"HTTP validateParams SUCCESS");
        NSString *method = [[request getMethod] uppercaseString];
        NSString *url = [request getURL];
        NSDictionary *params = [request getParams];
        NSDictionary *headers = [request getHeaders];
        NSDictionary *uploadFiles = [request getUploadFiles];
        BOOL existUploadFile = [request existUploadFile];
        BOOL hideNetworkActivityIndicator = [request hideNetworkActivityIndicator];
        long timeoutDuration = [request getTimeoutDuration] <= 0 ? [[WJHttpEngineConfig sharedInstance] defaultTimeoutDuration] : [request getTimeoutDuration];
        
        AFHTTPSessionManager *manager = [[WJHTTPSessionManagerStorage sharedInstance] defaultSessionManager];
        
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager.requestSerializer setTimeoutInterval:timeoutDuration];
        if ([headers count] > 0) {
            WJLogDebug(@"HTTP Headers:%@",headers);
            NSArray *keys = [headers allKeys];
            for (NSString *key in keys) {
                if ([[headers objectForKey:key] isKindOfClass:[NSString class]]) {
                    [manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
                }
            }
        }
        
        WJ_BLOCK_WEAK AFWJHttpEngine *selfObjectRef = self;
        
        if (WJ_STRING_EQUAL(method, HTTP_METHOD_GET)) {
            if (!hideNetworkActivityIndicator) {
                [[WJNetworkActivityService sharedInstance] start];
            }
            self.loading = YES;
            WJLogDebug(@"HTTP GET url:%@ params:%@",url,params);
            
            self.sessionTask = [manager GET:url parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (!hideNetworkActivityIndicator) {
                    [[WJNetworkActivityService sharedInstance] stop];
                }
                selfObjectRef.loading = NO;
                WJLogDebug(@"HTTP Response SUCCESS~");
                responseObject = [resClass parseResult:responseObject];
                [[WJHttpFilterCore sharedInstance] filter:responseObject];
                dispatch_semaphore_signal(_sem);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull err) {
                if (!hideNetworkActivityIndicator) {
                    [[WJNetworkActivityService sharedInstance] stop];
                }
                WJLogDebug(@"HTTP Response Error:%@",err);
                selfObjectRef.loading = NO;
                *error = err;
                dispatch_semaphore_signal(_sem);
            }];
            dispatch_semaphore_wait(_sem, DISPATCH_TIME_FOREVER);
            
        } else if (WJ_STRING_EQUAL(method, HTTP_METHOD_POST)) {
            self.loading = YES;
            if (![request hideNetworkActivityIndicator]) {
                [[WJNetworkActivityService sharedInstance] start];
            }
            WJLogDebug(@"HTTP %@ url:%@",method,url);
            WJLogDebug(@"HTTP Params:%@",params);
            if (existUploadFile) {
                
                self.sessionTask = [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    NSArray *allKeys = [uploadFiles allKeys];
                    for (NSString *key in allKeys) {
                        id val = uploadFiles[key];
                        if ([val conformsToProtocol:@protocol(IWJUploadFileInfo)]) {
                            id<IWJUploadFileInfo> fileInfo = (id<IWJUploadFileInfo>)val;
                            NSString *fileName = [fileInfo fileName];
                            NSString *filePath = [fileInfo filePath];
                            NSString *miniType = [fileInfo mimeType];
                            if ([WJFileUtils existFile:filePath]) {
                                [formData appendPartWithFileData:[NSData dataWithContentsOfFile:filePath] name:key fileName:fileName mimeType:miniType];
                            }
                        } else if ([val isKindOfClass:[NSString class]]) {
                            NSString *filePath = (NSString*)val;
                            if ([WJFileUtils existFile:filePath]) {
                                [formData appendPartWithFormData:[NSData dataWithContentsOfFile:filePath] name:key];
                            }
                        }
                    }
                } progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if (!hideNetworkActivityIndicator) {
                        [[WJNetworkActivityService sharedInstance] stop];
                    }
                    selfObjectRef.loading = NO;
                    WJLogDebug(@"HTTP Response SUCCESS~");
                    responseObject = [resClass parseResult:responseObject];
                    [[WJHttpFilterCore sharedInstance] filter:responseObject];
                    dispatch_semaphore_signal(_sem);
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull err) {
                    if (!hideNetworkActivityIndicator) {
                        [[WJNetworkActivityService sharedInstance] stop];
                    }
                    WJLogDebug(@"HTTP Response Error:%@",err);
                    selfObjectRef.loading = NO;
                    *error = err;
                    dispatch_semaphore_signal(_sem);
                }];
                dispatch_semaphore_wait(_sem, DISPATCH_TIME_FOREVER);
            } else {
                
                self.sessionTask = [manager POST:url parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if (!hideNetworkActivityIndicator) {
                        [[WJNetworkActivityService sharedInstance] stop];
                    }
                    selfObjectRef.loading = NO;
                    WJLogDebug(@"HTTP Response SUCCESS~");
                    responseObject = [resClass parseResult:responseObject];
                    [[WJHttpFilterCore sharedInstance] filter:responseObject];
                    dispatch_semaphore_signal(_sem);
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull err) {
                    if (!hideNetworkActivityIndicator) {
                        [[WJNetworkActivityService sharedInstance] stop];
                    }
                    selfObjectRef.loading = NO;
                    WJLogDebug(@"HTTP Response Error:%@",err);
                    *error = err;
                    dispatch_semaphore_signal(_sem);
                }];
                
                dispatch_semaphore_wait(_sem, DISPATCH_TIME_FOREVER);
            }
        } else {
            WJLogError(@"暂时不支持%@请求",method);
            *error = [NSError errorWithDomain:@"AFWJHttpEngineDomain" code:-1 userInfo:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"暂不支持此方法'%@'请求",method] forKey:NSLocalizedDescriptionKey]];
        }
    } else {
        if (*error == nil) {
            *error = [NSError errorWithDomain:@"AFWJHttpEngineDomain" code:-1 userInfo:[NSDictionary dictionaryWithObject:@"不符合请求条件" forKey:NSLocalizedDescriptionKey]];
        }
    }
    return responseObject;
}

-(NSData*) syncRequestURL:(NSString*) url
                   method:(NSString*) method
                   params:(NSDictionary*) params
                    error:(NSError**) error {
    return [self syncRequestURL:url method:method params:params headers:nil error:error];
}

-(NSData*) syncRequestURL:(NSString*) url
                   method:(NSString*) method
                   params:(NSDictionary*) params
                  headers:(NSDictionary*) headers
                    error:(NSError**) error {
    
    __block NSData *responseData = nil;
    
    WJLogDebug(@"HTTP Asyn Request");
    if (WJ_STRING_IS_NOT_EMPTY(url) && ![self hasLoading]) {
        WJLogDebug(@"HTTP validateParams SUCCESS");
        
        //        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        AFHTTPSessionManager *manager = [[WJHTTPSessionManagerStorage sharedInstance] defaultSessionManager];
        
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager.requestSerializer setTimeoutInterval:(NSTimeInterval)[[WJHttpEngineConfig sharedInstance] defaultTimeoutDuration]];
        if ([headers count] > 0) {
            WJLogDebug(@"HTTP Headers:%@",headers);
            NSArray *keys = [headers allKeys];
            for (NSString *key in keys) {
                if ([[headers objectForKey:key] isKindOfClass:[NSString class]]) {
                    [manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
                }
            }
        }
        
        WJ_BLOCK_WEAK AFWJHttpEngine *selfObjectRef = self;
        if (WJ_STRING_EQUAL(method, HTTP_METHOD_GET)) {
            
            if ([[WJHttpEngineConfig sharedInstance] defaultNetworkActivityEnabled]) {
                [[WJNetworkActivityService sharedInstance] start];
            }
            self.loading = YES;
            WJLogDebug(@"HTTP GET url:%@ params:%@",url,params);
            self.sessionTask = [manager GET:url parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if ([[WJHttpEngineConfig sharedInstance] defaultNetworkActivityEnabled]) {
                    [[WJNetworkActivityService sharedInstance] stop];
                }
                selfObjectRef.loading = NO;
                WJLogDebug(@"HTTP Response SUCCESS~");
                if (responseObject && [responseObject  isKindOfClass:[NSData class]]) {
                    responseData = [[NSData alloc] initWithData:responseObject];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull err) {
                if ([[WJHttpEngineConfig sharedInstance] defaultNetworkActivityEnabled]) {
                    [[WJNetworkActivityService sharedInstance] stop];
                }
                WJLogDebug(@"HTTP Response Error:%@",err);
                selfObjectRef.loading = NO;
                *error = err;
            }];
        } else if (WJ_STRING_EQUAL(method, HTTP_METHOD_POST)) {
            
            self.loading = YES;
            if ([[WJHttpEngineConfig sharedInstance] defaultNetworkActivityEnabled]) {
                [[WJNetworkActivityService sharedInstance] start];
            }
            WJLogDebug(@"HTTP %@ url:%@",method,url);
            WJLogDebug(@"HTTP Params:%@",params);
            self.sessionTask = [manager POST:url parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if ([[WJHttpEngineConfig sharedInstance] defaultNetworkActivityEnabled]) {
                    [[WJNetworkActivityService sharedInstance] stop];
                }
                selfObjectRef.loading = NO;
                WJLogDebug(@"HTTP Response SUCCESS~");
                if (responseObject && [responseObject  isKindOfClass:[NSData class]]) {
                    responseData = [[NSData alloc] initWithData:responseObject];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull err) {
                if ([[WJHttpEngineConfig sharedInstance] defaultNetworkActivityEnabled]) {
                    [[WJNetworkActivityService sharedInstance] stop];
                }
                selfObjectRef.loading = NO;
                WJLogDebug(@"HTTP Response Error:%@",err);
                *error = err;
            }];
        } else {
            WJLogError(@"暂时不支持%@请求",method);
            *error = [NSError errorWithDomain:@"AFWJHttpEngineDomain" code:-1 userInfo:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"暂不支持此方法'%@'请求",method] forKey:NSLocalizedDescriptionKey]];
        }
    } else {
        WJLogError(@"HTTP validateParams Fail");
        *error = [NSError errorWithDomain:@"AFWJHttpEngineDomain" code:-1 userInfo:[NSDictionary dictionaryWithObject:@"不符合请求条件" forKey:NSLocalizedDescriptionKey]];
        
    }
    return responseData;
}



-(void)asynDownloadByURL:(NSString *)url responseBlock:(WJHttpEngineDownloadResponseBlock)resBlock progress:(WJHttpEngineProgressBlock)progressBlock {
    
    if (WJ_STRING_IS_EMPTY(url)) {
        NSError *error = [NSError errorWithDomain:@"AFWJHttpEngineDomain" code:-1 userInfo:[NSDictionary dictionaryWithObject:@"不符合请求条件" forKey:NSLocalizedDescriptionKey]];
        resBlock(nil, error);
        return;
    }
    if ([self hasLoading]) {
        NSError *error = [NSError errorWithDomain:@"AFWJHttpEngineDomain" code:-1 userInfo:[NSDictionary dictionaryWithObject:@"网络忙~" forKey:NSLocalizedDescriptionKey]];
        resBlock(nil, error);
        return;
    }
    self.loading = YES;
    self.progressBlock = progressBlock;
    self.downloadResBlock = resBlock;
    WJ_BLOCK_WEAK AFWJHttpEngine *selfObject = self;
    AFHTTPSessionManager *manager = [[WJHTTPSessionManagerStorage sharedInstance] defaultSessionManager];
    NSURL *fileURL = [NSURL URLWithString:url];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:fileURL];
    self.sessionTask = [manager downloadTaskWithRequest:urlRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        if (selfObject.progressBlock != NULL) {
            selfObject.progressBlock([downloadProgress fractionCompleted]);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *filePath = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:[response suggestedFilename]]];
        [[NSFileManager defaultManager] removeItemAtURL:filePath error:NULL];
        return filePath;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (selfObject.downloadResBlock != NULL) {
            if (error) {
                selfObject.downloadResBlock(nil, error);
            } else {
                selfObject.downloadResBlock(filePath.path, error);
            }
        }
        selfObject.downloadResBlock = NULL;
        selfObject.progressBlock = NULL;
        selfObject.loading = NO;
    }];
    [self.sessionTask resume];
}

-(void)cancel {
    if (_sessionTask && [self hasLoading]) {
        [_sessionTask cancel];
    }
}

@end
