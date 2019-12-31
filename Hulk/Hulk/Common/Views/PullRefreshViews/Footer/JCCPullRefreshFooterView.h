//
//  JCCPullRefreshFooterView.h
//
//  Created by Yunhai.Wu on 16/2/18.
//  Copyright © 2016年 WJ. All rights reserved.
//


#import "BaseWJView.h"
#import "IWJPullRefreshView.h"

/**
 *  通用上拉刷新视图
 */
@interface JCCPullRefreshFooterView : BaseWJView<IWJPullRefreshFooterView>


#pragma mark IWJPullRefreshFooterView
@property (nonatomic, assign) CGFloat regionHeight;

@property (nonatomic, weak) id<IWJPullRefreshViewDelegate> delegate;

@property (nonatomic, assign) BOOL isFullData;


@end
