//
//  JCCPullRefreshHeaderView.h
//
//  Created by Yunhai.Wu on 16/2/18.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "BaseWJView.h"
#import "IWJPullRefreshView.h"

/**
 *  通用下拉刷新视图
 */
@interface JCCPullRefreshHeaderView : BaseWJView<IWJPullRefreshView>


#pragma mark IWJPullRefreshView
@property (nonatomic, assign) CGFloat regionHeight;

@property (nonatomic, weak) id<IWJPullRefreshViewDelegate> delegate;


@end
