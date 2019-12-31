//
//  IWJHttpEngine.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/7/29.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IWJHttpRequest;
@protocol IWJHttpResponse;

/**
 *  回调block
 *
 *  @param res   http response
 *  @param error error
 */
typedef void(^WJHttpEngineResponseBlock)(id<IWJHttpResponse> res, NSError *error);

/**
 *  响应block
 */
typedef void(^WJHttpEngineNativeResponseBlock)(NSData* resData, NSError *error);


/**
 *  下载响应block
 *
 *  @param filePath 下载文件名
 *  @param error    错误
 */
typedef void (^WJHttpEngineDownloadResponseBlock)(NSString* filePath, NSError *error);

/**
 *  进度条
 *
 *  @param progress 进度（0.0f~1.0f）
 */
typedef void (^WJHttpEngineProgressBlock)(float progress);



@protocol IWJHttpEngine <NSObject>

/**
 *  是否在请求中
 */
- (BOOL)hasLoading;

/**
 *  异步请求
 *
 *  @param request  http request
 *  @param resClass http response Class
 *  @param resBlock response block
 */
- (void)asynRequest:(id<IWJHttpRequest>) request
      responseClass:(Class) resClass
      responseBlock:(WJHttpEngineResponseBlock) resBlock;


/**
 *  异步调用
 *
 *  @param url          url
 *  @param method       method
 *  @param params       请求参数
 *  @param failBlock    失败block
 */
- (void)asynRequestURL:(NSString*) url
                method:(NSString*) method
                params:(NSDictionary*) params
         responseBlock:(WJHttpEngineNativeResponseBlock) nativeResBlock;



/**
 *  异步调用
 *
 *  @param url          url
 *  @param method       method
 *  @param params       请求参数
 *  @param headers      头
 *  @param successBlock 成功block
 *  @param failBlock    失败block
 */
- (void)asynRequestURL:(NSString*) url
                method:(NSString*) method
                params:(NSDictionary*) params
               headers:(NSDictionary*) headers
         responseBlock:(WJHttpEngineNativeResponseBlock) nativeResBlock;


/**
 *  同步请求(使用dispatch_semaphore_t阻塞达到同步效果,不要在主线程调用)
 *
 *  @param request  http request
 *  @param resClass http response Class
 *  @param error    error
 *
 *  @return http response
 */
- (id<IWJHttpResponse>)syncRequest:(id<IWJHttpRequest>) request
                     responseClass:(Class) resClass
                             error:(NSError**) error;

/**
 *  同步调用(使用dispatch_semaphore_t阻塞达到同步效果,不要在主线程调用)
 *
 *  @param url          url
 *  @param method       method
 *  @param params       请求参数
 *  @param error        错误信息
 *
 *  @return response data
 */
- (NSData*)syncRequestURL:(NSString*) url
                method:(NSString*) method
                params:(NSDictionary*) params
                 error:(NSError**) error;


/**
 *  同步调用(使用dispatch_semaphore_t阻塞达到同步效果,不要在主线程调用)
 *
 *  @param url          url
 *  @param method       method
 *  @param params       请求参数
 *  @param headers      头
 *  @param error        错误信息
 *
 *  @return response data
 */
- (NSData*)syncRequestURL:(NSString*) url
                   method:(NSString*) method
                   params:(NSDictionary*) params
                  headers:(NSDictionary*) headers
                    error:(NSError**) error;



/**
 *  异步下载
 *
 *  @param url           下载文件url
 *  @param resBlock      响应block
 *  @param progressBlock 下载进度block
 */
- (void)asynDownloadByURL:(NSString*)url
             responseBlock:(WJHttpEngineDownloadResponseBlock)resBlock
                  progress:(WJHttpEngineProgressBlock)progressBlock;



/**
 *  取消任务
 */
-(void) cancel;

@end
