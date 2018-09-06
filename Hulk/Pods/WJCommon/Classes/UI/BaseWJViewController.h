//
//  BaseWJViewController.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/7/30.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJLoggingMacros.h"
#import "IWJRouterViewController.h"
#import "IWJLoadingView.h"
#import "IWJViewModel.h"
#import "Masonry.h"

/**
 *  视图控制器标题名称
 */
extern NSString * const WJViewControllerTitleKey;


/**
 *  视图控制器基类
 */
@interface BaseWJViewController : UIViewController<IWJRouterViewController>

#pragma mark IWJRouterViewController
/**
 *  路由委托
 */
@property (nonatomic, weak) id<IWJRouterViewControllerDelegate> routerDelegate;


#pragma mark custom
/**
 *  路由参数
 */
@property (nonatomic, strong) NSDictionary *routerParams;

/**
 *  加载视图
 */
@property (nonatomic, weak, readonly) UIView<IWJLoadingView> *wjLoadingView;

/**
 *  替代self.navigationItem 设置navTitle请修改wjNavTitle属性
 */
@property (nonatomic, weak, readonly) UINavigationItem *wjNavigationItem;

/**
 *  替代 self.navigationController.navigationBar
 */
@property (nonatomic, weak) IBOutlet UINavigationBar *wjNavigationBar;

/**
 *  替代 self.view
 */
@property (nonatomic, weak) IBOutlet UIView *wjView;

/**
 *  wjView 顶部约束(兼容老xib文件中配置为64 如果不设置，则找约束值为64的约束)
 */
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *wjViewTopLayoutConstraint;

/**
 *  导航栏标题
 */
@property (nonatomic, copy) NSString *wjNavTitle;

/**
 *  当前界面是否存在导航栏
 */
-(BOOL) wj_existNavigationBar;

/**
 *  视图控制器初始方法(init初始化完成调用),子类重写后需要[super wj_vcInit]
 */
-(void) wj_vcInit;

/**
 *  加载数据操作方法
 */
-(void) wj_execLoadDataAction;

/**
 *  实例化一个加载视图
 *
 *  @return 加载视图
 */
-(UIView<IWJLoadingView>*) wj_instanceLoadingView;

/**
 *  需要观察的keypath 列表(子类重写实现)
 */
-(NSArray*) wj_observableKeypaths;

/**
 *  指定keypath有修改(子类重写实现)
 */
-(void) wj_changeForKeypath:(NSString*) keypath;

/**
 *  当前视图控制器ViewModel
 */
-(NSArray*) wj_viewModels;

/**
 *  实例化一个视图控制器方法
 */
+(instancetype) wj_instance;


@end
