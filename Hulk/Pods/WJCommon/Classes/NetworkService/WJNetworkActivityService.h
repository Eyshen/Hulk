//
//  WJNetworkActivityManager.h
//  117goFramework
//
//  Created by Yunhai.Wu on 15/7/30.
//  Copyright (c) 2015年 117go. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJSingleton.h"

@interface WJNetworkActivityService : NSObject

AS_SINGLETON(WJNetworkActivityService)

/**
 *  开始让状态栏中的数据标示旋转
 */
-(void)start;

/**
 *  停止让状态栏中的数据标示旋转
 */
-(void)stop;

/**
 *  立即停止状态栏中的数据标示旋转
 */
-(void)stopAll;

@end
