//
//  IWJLoadingViewDelegate.h
//  WJLoadingView-example
//
//  Created by Yunhai.Wu on 16/2/18.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IWJLoadingView;

/**
 *  加载视图委托
 */
@protocol IWJLoadingViewDelegate <NSObject>

/**
 *  加载刷新
 */
-(void) loadingRefresh:(UIView<IWJLoadingView>*) loadingView;

@end
