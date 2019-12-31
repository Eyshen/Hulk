//
//  IWJNotify.h
//  WJNotifyAPI-example
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by 吴云海 on 16/10/31.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  通知类型(可自定义扩展)
 */
typedef NS_ENUM(NSInteger, WJNotifyType) {
    
    /**
     *  APNs通知
     */
    WJNotifyTypeAPNs = 0,
    
    /**
     *  本地通知
     */
    WJNotifyTypeLocal = 1,
    
    /**
     *  通用链接通知
     */
    WJNotifyTypeUniversalLinks = 2,
};




@protocol IWJNotify <NSObject>

/**
 *  通知类型
 */
- (NSInteger)notifyType;

/**
 *  通知数据
 */
- (id)notifyData;

@optional
/**
 *  是否支持异步处理（default NO）如果为非异步，表示在主线程中执行
 */
- (BOOL)isAsyn;

@end
