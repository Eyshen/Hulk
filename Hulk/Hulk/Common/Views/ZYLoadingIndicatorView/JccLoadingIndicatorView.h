//
//  JccLoadingIndicatorView.h
//  ios-jucaicat
//
//  Created by 吴云海 on 16/9/1.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import <WJCommon/WJCommon.h>

/**
 *  聚财猫加载标识视图
 */
@interface JccLoadingIndicatorView : BaseWJView

/**
 *  开始动画(主线程中调用)
 */
- (void)startAnimating;

/**
 *  停止动画(主线程中调用)
 */
- (void)stopAnimating;

/**
 *  是否在动画(主线程中调用)
 */
- (BOOL)isAnimating;


@end

