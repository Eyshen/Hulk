//
//  UIScrollView+WJFrame.h
//  WJCommon-master
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by 吴云海 on 16/7/4.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (WJFrame)

/**
 *  contentSize.width
 */
@property(nonatomic, assign) CGFloat wj_contnetWidth;

/**
 *  contentSize.height
 */
@property(nonatomic, assign) CGFloat wj_contentHeight;

/**
 *  contentOffset.x
 */
@property(nonatomic, assign) CGFloat wj_contentOffsetX;

/**
 *  contentOffset.y
 */
@property(nonatomic, assign) CGFloat wj_contentOffsetY;

/**
 *  contentInset.top
 */
@property(nonatomic, assign) CGFloat wj_contentInsetTop;

/**
 *  contentInset.bottom
 */
@property(nonatomic, assign) CGFloat wj_contentInsetBottom;

/**
 *  contentInset.left
 */
@property(nonatomic, assign) CGFloat wj_contentInsetLeft;

/**
 *  contentInset.right
 */
@property(nonatomic, assign) CGFloat wj_contentInsetRight;

@end
