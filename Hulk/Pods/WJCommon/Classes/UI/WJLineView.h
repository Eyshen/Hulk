//
//  BaseWJView.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by 吴云海 on 16-2-27.
//  Copyright (c) 2016年 WJ. All rights reserved.
//

#import "BaseWJView.h"

/**
 *  线条绘制位置
 */
typedef NS_ENUM(NSInteger, WJLineDrawPosition) {
    
    /**
     *  垂直居中
     */
    WJLineDrawPositionVerticalCenter = 0,
    
    /**
     *  水平居中
     */
    WJLineDrawPositionHorizontalCenter = 1,
    
    /**
     *  底部
     */
    WJLineDrawPositionBottom = 2,
    
    /**
     *  顶部
     */
    WJLineDrawPositionTop = 3,
    
    /**
     * 左边
     */
    WJLineDrawPositionLeft = 4,
    
    /**
     * 右边
     */
    WJLineDrawPositionRight = 5,
};

/**
 *  线条样式
 */
typedef NS_ENUM(NSInteger, WJLineStyle) {
    
    /**
     * 实线
     */
    WJLineStyleSolid = 0,
    
    /**
     * 虚线
     */
    WJLineStyleDotted = 1,
};


/**
 *  线条视图
 */
@interface WJLineView : BaseWJView

/**
 *  线条颜色
 */
@property (nonatomic, strong) UIColor *lineColor;

/**
 *  是否水平
 */
@property (nonatomic, assign) WJLineDrawPosition drawPosition;

/**
 *  线条样式
 */
@property (nonatomic, assign) WJLineStyle lineStyle;

/**
 *  线条宽度
 *  default     1/scale
 */
@property (nonatomic, assign) CGFloat lineWidth;

@end
