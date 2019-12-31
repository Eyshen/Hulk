//
//  IWJPullRefreshView.h
//  WJPullRefreshView-example
//
//  Created by Yunhai.Wu on 16/2/18.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWJPullRefreshStateView.h"


#define WJ_PULL_REFRESH_REGION_HEIGHT   60.0f


@protocol IWJPullRefreshViewDelegate;


/**
 *  下拉刷新视图
 */
@protocol IWJPullRefreshView <NSObject>

/**
 *  区域大小
 *
 *  default QW_REFRESH_REGION_HEIGHT
 */
@property (nonatomic, assign) CGFloat regionHeight;

/**
 *  委托
 */
@property (nonatomic, weak) id<IWJPullRefreshViewDelegate> delegate;

/**
 *  初始化方法
 *
 *  @param scrollView  滚动视图
 *  @param stateView   加载状态视图
 *
 *  @return 实例
 */
-(instancetype) initWithScrollView:(UIScrollView*) scrollView stateView:(UIView<IWJPullRefreshStateView>*) stateView;

/**
 *  模拟拖拽加载效果
 */
-(void) refreshScrollViewDidBeginLoading:(UIScrollView*) scrollView animated:(BOOL) animated;

/**
 *  UIScrollViewDelegate中 scrollViewDidScroll: 方法回调调用
 *
 *  @param scrollView 滚动视图
 */
-(void) refreshScrollViewDidScroll:(UIScrollView*) scrollView;

/**
 *  UIScrollViewDelegate中 scrollViewDidEndDragging:willDecelerate: 方法回调调用
 *
 *  @param scrollView 滚动视图
 */
-(void) refreshScrollViewDidEndDragging:(UIScrollView*) scrollView;

/**
 *  完成数据加载
 */
-(void) refreshScrollViewDidFinishedLoading:(UIScrollView *)scrollView;

/**
 *  数据加载完成
 *
 *  @param scrollView 所在滚动视图
 *  @param success    是否加载成功
 *  @param delay      加载结果显示时间
 */
-(void) refreshScrollViewDidFinishedLoading:(UIScrollView *)scrollView success:(BOOL) success delay:(NSTimeInterval) delay;

@end






/**
 *  上拉加载视图
 */
@protocol IWJPullRefreshFooterView <IWJPullRefreshView>

/**
 *  数据加载完成(数据是否已经全部加载完成)
 *
 *  default NO
 */
@property (nonatomic, assign) BOOL isFullData;

/**
 *  content size 更新
 */
-(void) refreshContentSize;

@end









/**
 *  上拉、下拉刷新委托
 */
@protocol IWJPullRefreshViewDelegate <NSObject>

/**
 *  触发刷新（开始刷新）
 */
- (BOOL) refreshDidTriggerRefresh:(UIView<IWJPullRefreshView>*)view;

@end