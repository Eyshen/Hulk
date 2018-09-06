//
//  BaseWJTableViewController.h
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

#import "BaseWJViewController.h"
#import "IWJPullRefreshView.h"

/**
 *  表视图控制器 基类
 */
@interface BaseWJTableViewController : BaseWJViewController<UITableViewDataSource,UITableViewDelegate>

/**
 *  表引用
 */
@property (nonatomic, weak, readonly) UITableView *tableView;

/**
 *  加载更多视图
 */
@property (nonatomic, weak, readonly) UIView<IWJPullRefreshFooterView> *wjPullRefreshFooterView;

/**
 *  下拉刷新视图
 */
@property (nonatomic, weak, readonly) UIView<IWJPullRefreshView> *wjPullRefreshHeaderView;

/**
 *  是否启用下拉刷新
 */
@property (nonatomic, assign) BOOL enabledHeaderRefresh;

/**
 *  是否启用加载更多
 */
@property (nonatomic, assign) BOOL enabledFooterRefresh;

/**
 *  tableView 样式
 */
-(UITableViewStyle) wj_tableViewStyle;

/**
 *  加载新数据操作方法
 */
-(void) wj_execRefreshNewDataAction;

/**
 *  加载更多数据操作方法
 */
-(void) wj_execRefreshMoreDataAction;

/**
 *  实例化一个下拉刷新数据视图
 */
-(UIView<IWJPullRefreshView> *) wj_instancePullRefreshHeaderView;

/**
 *  实例化一个上拉刷新数据视图
 */
-(UIView<IWJPullRefreshFooterView> *) wj_instancePullRefreshFooterView;

@end
