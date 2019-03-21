//
//  JccLoadingView.h
//  ios-jucaicat
//
//  Created by 吴云海 on 16/7/10.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import <WJCommon/WJCommon.h>
#import "IWJLoadingView.h"

@interface JccLoadingView : BaseWJView<IWJLoadingView>

/**
 *  当前加载状态
 *
 *  default WJLoadingStateLoading
 */
@property (nonatomic, assign) WJLoadingState state;

/**
 *  自定义状态图片
 */
@property(nonatomic, copy) NSString *customStateImageName;

/**
 *  自定义状态文本
 */
@property(nonatomic, copy) NSString *customStateText;

/**
 *  加载状态图片名称
 */
@property(nonatomic, copy) NSString *loadingStateImageName;

/**
 *  加载状态时文本
 */
@property(nonatomic, copy) NSString *loadingStateText;

/**
 *  空值图片名称
 */
@property (nonatomic, copy) NSString *emptyDataStateImageName;

/**
 *  空值显示文本
 */
@property (nonatomic, copy) NSString *emptyDataStateText;

/**
 *  无网络图片名称
 */
@property(nonatomic, copy) NSString *networkOffStateImageName;

/**
 *  无网络文本
 */
@property(nonatomic, copy) NSString *networkOffStateText;

/**
 *  委托
 */
@property (nonatomic, weak) id<IWJLoadingViewDelegate> delegate;

/**
 *  偏移Y default 0.0f
 */
@property (nonatomic, assign) CGFloat offsetY;


@end
