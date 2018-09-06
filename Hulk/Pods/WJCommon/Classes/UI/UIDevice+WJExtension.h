//
//  UIDevice+WJExtension.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 16/1/5.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WJ_DEVICE_OS_VERSION                            [UIDevice osVersion]
#define WJ_DEVICE_IS_DEVICE_PHONE                       [UIDevice isDevicePhone]
#define WJ_DEVICE_IS_PHONE                              [UIDevice isPhone]
#define WJ_DEVICE_IS_POD                                [UIDevice isPod]
#define WJ_DEVICE_IS_TOUCH                              [UIDevice isTouch]
#define WJ_DEVICE_IS_PAD                                [UIDevice isPad]

@interface UIDevice (WJExtension)

/**
 *  iOS 系统版本
 */
+(NSString*) osVersion;

/**
 *  是否为手机设备设备(iPhone、iPod、iTouch)
 */
+ (BOOL)isDevicePhone;

/**
 *  是否为iPhone
 */
+ (BOOL) isPhone;

/**
 *  是否为iPod
 */
+ (BOOL) isPod;

/**
 *  是否为iTouch
 */
+ (BOOL) isTouch;

/**
 *  是否为iPad设备
 */
+ (BOOL)isPad;

@end
