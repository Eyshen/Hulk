//
//  WJUIRoutable.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/8/24.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJRouterOptions.h"
#import "IWJRouterViewController.h"
#import "IWJRouterViewControllerDelegate.h"


#define WJ_ROUTER_URL_KEY   @"routerUrlKey"

typedef void(^UIWJCompletionBlock)();


/**
 *  UI 路由器
 *
 *  注意：UIRoutable打开UI是使用 - (id)initWithURL:routerParams: 初始化，所以如果VC带有XIB，需要重写此方法
 */
@interface WJUIRoutable : NSObject

/**
 *  忽略异常
 *  Default YES
 */
@property (readwrite, nonatomic, assign) BOOL ignoresExceptions;


/**
 *  导航控制器,回到上一个控制器
 *
 *  @param animated 是否动画
 */
- (void) pop:(BOOL) animated;

/**
 *  导航控制器，回到root
 *
 *  @param animated 是否动画
 */
- (void) popRoot:(BOOL) animated;

/**
 *  导航控制器，回到指定控制器索引
 *
 *  @param index    索引
 *  @param animated 是否动画
 */
- (void) popAtIndex:(NSUInteger) index animated:(BOOL) animated;

/**
 *  关闭最上层模态视图控制器
 *
 *  @param animated        是否动画
 *  @param completionBlock 完成动画block
 */
- (void) dismiss:(BOOL)animated completion:(UIWJCompletionBlock)completionBlock;

/**
 *  关闭rootviewcontroller上所有的视图控制器
 *
 *  @param animated        是否动画
 *  @param completionBlock 完成动画block
 */
- (void) dismissAll:(BOOL)animated completion:(UIWJCompletionBlock)completionBlock;
- (void) dismissAtIndex:(NSUInteger) index animated:(BOOL)animated completion:(UIWJCompletionBlock)completionBlock;//index 不许大于等于0，index指模态打开的数据控制器集合

/**
 *  关闭视图控制器（当导航控制器[viewControllers count] == 1时，执行dismiss:completion: 否则执行 pop:）
 *
 *  @param animated 动画
 */
- (void) close:(BOOL) animated;

/**
 *  关闭所有视图控制器（当rootViewController有模态视图控制器打开时则关闭模态，否则执行popRoot）
 */
- (void) closeAll:(BOOL) animated;

/**
 *  碰到这个format的url就回调这个block
 *
 *  @param format   跳转key
 *  @param callback 打开回调block
 *  注意：
 *   1、http://www.test.com/user/:userId  匹配 http://www.test.com/user/12134
 *   2、http://www.test.com/user          匹配 http://www.test.com/user?userid=123452
 */
- (void)map:(NSString *)format toCallback:(WJRouterOpenCallback)callback;
- (void)maps:(NSArray *)formats toCallback:(WJRouterOpenCallback)callback;
- (void)map:(NSString *)format toCallback:(WJRouterOpenCallback)callback withOptions:(WJRouterOptions *)options;
- (void)maps:(NSArray *)formats toCallback:(WJRouterOpenCallback)callback withOptions:(WJRouterOptions *)options;
- (void)map:(NSString *)format toController:(Class)controllerClass;
- (void)maps:(NSArray *)formats toController:(Class)controllerClass;
- (void)map:(NSString *)format toController:(Class)controllerClass withOptions:(WJRouterOptions *)options;
- (void)maps:(NSArray *)formats toController:(Class)controllerClass withOptions:(WJRouterOptions *)options;

/**
 *  拨打电话
 */
- (void)callTel:(NSString*)tel;

/**
 *  设置回退节点
 */
- (void)settingReturnNode:(UIViewController<IWJRouterViewController>*)returnNode;

/**
 *  打开回退节点
 */
- (BOOL)openReturnNode:(BOOL)animated;

/**
 *  打开外部url
 */
- (void)openExternal:(NSString *)url;

/**
 *  打开url
 */
- (void)open:(NSString *)url;
- (void)open:(NSString *)url animated:(BOOL)animated;
- (void)open:(NSString *)url animated:(BOOL)animated extraParams:(NSDictionary *)extraParams;
- (void)openRoot:(UIViewController*) rootViewController;

//app当前页面导航控制器
-(UINavigationController*) currentNavigationController;

/**
 *  得到url中的参数包含链接参数
 */
- (NSDictionary*)paramsOfUrl:(NSString*)url;

+(instancetype) sharedInstance;

@end
