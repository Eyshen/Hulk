//
//  IWJLoadingView.h
//  WJLoadingView-example
//
//  Created by Yunhai.Wu on 16/2/18.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWJLoadingViewDelegate.h"

/**
 *  加载状态
 */
typedef NS_ENUM(NSInteger, WJLoadingState) {
    
    /**
     *  加载中
     */
    WJLoadingStateLoading = 0,
    
    /**
     *  自定义 img msg
     */
    WJLoadingStateCustom = 1,
    
    /**
     *  无网络
     */
    WJLoadingStateNetworkOff = 2,
    
    /**
     *  无数据
     */
    WJLoadingStateEmptyData = 3,
    
    /**
     *  加载完成
     */
    WJLoadingStateFinished = 4,
};

/**
 *  加载数据视图
 */
@protocol IWJLoadingView <NSObject>

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



