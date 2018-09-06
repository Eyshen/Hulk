//
//  UIView+Frame.m
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

#import "UIView+WJFrame.h"

@implementation UIView (WJFrame)
-(CGFloat)leftTopX {
    return self.frame.origin.x;
}
-(void)setLeftTopX:(CGFloat)leftTopX {
    CGRect oframe = self.frame;
    oframe.origin.x = leftTopX;
    [self setFrame:oframe];
}
-(CGFloat)leftTopY {
    return self.frame.origin.y;
}
-(void)setLeftTopY:(CGFloat)leftTopY {
    CGRect oframe = self.frame;
    oframe.origin.y = leftTopY;
    [self setFrame:oframe];
}
-(CGFloat)leftBottomX {
    return self.frame.origin.x;
}
-(void)setLeftBottomX:(CGFloat)leftBottomX {
    CGRect oframe = self.frame;
    oframe.origin.x = leftBottomX;
    [self setFrame:oframe];
}
-(CGFloat)leftBottomY {
    return self.frame.origin.y + self.frame.size.height;
}
-(void)setLeftBottomY:(CGFloat)leftBottomY {
    CGRect oframe = self.frame;
    oframe.origin.y = leftBottomY - oframe.size.height;
    [self setFrame:oframe];
}
-(CGFloat)rightTopX {
    return self.frame.origin.x+self.frame.size.width;
}
-(void)setRightTopX:(CGFloat)rightTopX {
    CGRect oframe = self.frame;
    oframe.origin.x = rightTopX - oframe.size.width;
    [self setFrame:oframe];
}
-(CGFloat)rightTopY {
    return self.frame.origin.y;
}
-(void)setRightTopY:(CGFloat)rightTopY {
    CGRect oframe = self.frame;
    oframe.origin.y = rightTopY;
    [self setFrame:oframe];
}
-(CGFloat)rightBottomX {
    return self.frame.origin.x+self.frame.size.width;
}
-(void)setRightBottomX:(CGFloat)rightBottomX {
    CGRect oframe = self.frame;
    oframe.origin.x = rightBottomX - oframe.size.width;
    [self setFrame:oframe];
}
-(CGFloat)rightBottomY {
    return self.frame.origin.y+self.frame.size.height;
}
-(void)setRightBottomY:(CGFloat)rightBottomY {
    CGRect oframe = self.frame;
    oframe.origin.y = rightBottomY - oframe.size.height;
    [self setFrame:oframe];
}
-(CGFloat)width {
    return self.frame.size.width;
}
-(void)setWidth:(CGFloat)width {
    CGRect oframe = self.frame;
    oframe.size.width = width;
    [self setFrame:oframe];
}
-(CGFloat)height {
    return self.frame.size.height;
}
-(void)setHeight:(CGFloat)height {
    CGRect oframe = self.frame;
    oframe.size.height = height;
    [self setFrame:oframe];
}
-(CGFloat)centerX {
    return self.center.x;
}
-(void)setCenterX:(CGFloat)centerX {
    CGPoint oCenter = self.center;
    oCenter.x = centerX;
    [self setCenter:oCenter];
}
-(CGFloat)centerY {
    return self.center.y;
}
-(void)setCenterY:(CGFloat)centerY {
    CGPoint oCenter = self.center;
    oCenter.y = centerY;
    [self setCenter:oCenter];
}
-(CGPoint)origin {
    return self.frame.origin;
}
-(void)setOrigin:(CGPoint)origin {
    CGRect oframe = self.frame;
    oframe.origin = origin;
    [self setFrame:oframe];
}
-(CGSize)size {
    return self.frame.size;
}
@end
