//
//  UIView+Frame.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/12/16.
//  Copyright © 2015年 WJ. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  UIView 扩展
 */
@interface UIView (WJFrame)

/**
 *  左上角x
 */
@property (nonatomic) CGFloat leftTopX;

/**
 *  左上角y
 */
@property (nonatomic) CGFloat leftTopY;

/**
 *  左下角x
 */
@property (nonatomic) CGFloat leftBottomX;

/**
 *  左下角y
 */
@property (nonatomic) CGFloat leftBottomY;

/**
 *  右上角x
 */
@property (nonatomic) CGFloat rightTopX;

/**
 *  右上角y
 */
@property (nonatomic) CGFloat rightTopY;

/**
 *  右下角x
 */
@property (nonatomic) CGFloat rightBottomX;

/**
 *  右下角y
 */
@property (nonatomic) CGFloat rightBottomY;

/**
 *  宽
 */
@property (nonatomic) CGFloat width;

/**
 *  高
 */
@property (nonatomic) CGFloat height;

/**
 *  中点x
 */
@property (nonatomic) CGFloat centerX;

/**
 *  中点y
 */
@property (nonatomic) CGFloat centerY;

/**
 *  frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 *  大小
 */
@property (nonatomic, readonly) CGSize  size;

@end
