//
//  UIApplication+WJExtension.h
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

#define WJ_APPLICATION_DELEGATE                 [UIApplication appDelegate]
#define WJ_APPLICATION_WINDOW                   [UIApplication appWindow]
#define WJ_APPLICATION_ROOT_VIEWCONTROLLER      [UIApplication appRootViewController]
#define WJ_APPLICATION_IDENTIFIER               [UIApplication appIdentifier]
#define WJ_APPLICATION_VERSION                  [UIApplication appVersion]
#define WJ_APPLICATION_SHORT_VERSION            [UIApplication appShortVersion]
#define WJ_APPLICATION_SCHEME                   [UIApplication appScheme]
#define WJ_APPLICATION_SCHEME_BY_NAME(name)     [UIApplication appScheme:name]


@interface UIApplication (WJExtension)

/**
 *  应用程序委托
 */
+(id<UIApplicationDelegate>) appDelegate;

/**
 *  应用程序Window
 */
+(UIWindow*) appWindow;

/**
 *  应用程序主视图控制器
 */
+(UIViewController*) appRootViewController;

/**
 *  应用程序Bundle Identifier
 */
+ (NSString*) appIdentifier;

/**
 *  应用程序版本
 */
+ (NSString *)appVersion;

/**
 *  应用程序short version
 */
+ (NSString *)appShortVersion;

/**
 *  应用程序Scheme
 */
+ (NSString *)appScheme;

+ (NSString *)appScheme:(NSString *)name;

@end
