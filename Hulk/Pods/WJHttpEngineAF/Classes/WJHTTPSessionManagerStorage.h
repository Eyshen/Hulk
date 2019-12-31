//
//  WJHTTPSessionManager.h
//  WJHttpEngineAF-example
//
//  Created by wuyunhai on 16/4/25.
//  Copyright © 2016年 jucaicat. All rights reserved.
//

#import "AbstractWJBusinessObject.h"
#import "WJSingleton.h"
#import "AFHTTPSessionManager.h"

/**
 *  AFHTTPSessionManager 管理
 */
@interface WJHTTPSessionManagerStorage : AbstractWJBusinessObject

AS_SINGLETON(WJHTTPSessionManagerStorage)

/**
 *  最大并发数(default 5)
 */
-(void) setMaxConcurrentCount:(NSInteger) concurrentCount;

-(AFHTTPSessionManager*) defaultSessionManager;

@end
