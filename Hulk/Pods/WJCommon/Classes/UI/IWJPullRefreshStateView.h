//
//  IWJPullRefreshLoadingView.h
//  WJPullRefreshView-example
//
//  Created by Yunhai.Wu on 16/2/18.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  上下拉刷新状态
 */
typedef NS_ENUM(NSInteger, WJPullRefreshState) {
    
    /**
     *  无
     */
    WJPullRefreshStateNone = 0,
    
    /**
     *  拉动状态
     */
    WJPullRefreshStatePulling = 1,
    
    /**
     *  正常状态
     */
    WJPullRefreshStateNormal = 2,
    
    /**
     *  加载状态
     */
    WJPullRefreshStateLoading = 3,
    
    /**
     *  加载成功
     */
    WJPullRefreshStateFinish = 4,
    
    /**
     *  加载失败
     */
    WJPullRefreshStateFail = 5,
    
    /**
     *  数据全部加载完成（只有加载更多数据才有）
     */
    WJPullRefreshStateFull,
};


/**
 *  加载状态视图
 */
@protocol IWJPullRefreshStateView <NSObject>

/**
 *  设置状态
 *
 *  @param aState     状态
 *  @param scrollView 滚动视图
 */
-(void) setState:(WJPullRefreshState) aState scrollView:(UIScrollView*) scrollView;

@end
