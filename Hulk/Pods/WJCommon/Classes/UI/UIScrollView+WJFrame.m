//
//  UIScrollView+WJFrame.m
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

#import "UIScrollView+WJFrame.h"

@implementation UIScrollView (WJFrame)

-(CGFloat)wj_contnetWidth {
    return self.contentSize.width;
}

-(void)setWj_contnetWidth:(CGFloat)wj_contnetWidth {
    if (self.contentSize.width == wj_contnetWidth) return;
    self.contentSize = CGSizeMake(wj_contnetWidth, self.contentSize.height);
}

-(CGFloat)wj_contentHeight {
    return self.contentSize.height;
}

-(void)setWj_contentHeight:(CGFloat)wj_contentHeight {
    if (self.contentSize.height == wj_contentHeight) return;
    self.contentSize = CGSizeMake(self.contentSize.width, wj_contentHeight);
}

-(CGFloat)wj_contentOffsetX {
    return self.contentOffset.x;
}

-(void)setWj_contentOffsetX:(CGFloat)wj_contentOffsetX {
    if (self.contentOffset.x == wj_contentOffsetX) return;
    self.contentOffset = CGPointMake(wj_contentOffsetX, self.contentOffset.y);
}

-(CGFloat)wj_contentOffsetY {
    return self.contentOffset.y;
}

-(void)setWj_contentOffsetY:(CGFloat)wj_contentOffsetY {
    if (self.contentOffset.y == wj_contentOffsetY) return;
    self.contentOffset = CGPointMake(self.contentOffset.x, wj_contentOffsetY);
}

-(CGFloat)wj_contentInsetTop {
    return self.contentInset.top;
}

-(void)setWj_contentInsetTop:(CGFloat)wj_contentInsetTop {
    if (self.contentInset.top == wj_contentInsetTop) return;
    self.contentInset = UIEdgeInsetsMake(wj_contentInsetTop, self.contentInset.left, self.contentInset.bottom, self.contentInset.right);
}

-(CGFloat)wj_contentInsetBottom {
    return self.contentInset.bottom;
}

-(void)setWj_contentInsetBottom:(CGFloat)wj_contentInsetBottom {
    if (self.contentInset.bottom == wj_contentInsetBottom) return;
    self.contentInset = UIEdgeInsetsMake(self.contentInset.top, self.contentInset.left, wj_contentInsetBottom, self.contentInset.right);
}

-(CGFloat)wj_contentInsetLeft {
    return self.contentInset.left;
}

-(void)setWj_contentInsetLeft:(CGFloat)wj_contentInsetLeft {
    if (self.contentInset.left == wj_contentInsetLeft) return;
    self.contentInset = UIEdgeInsetsMake(self.contentInset.top, wj_contentInsetLeft, self.contentInset.bottom, self.contentInset.right);
}

-(CGFloat)wj_contentInsetRight {
    return self.contentInset.right;
}

-(void)setWj_contentInsetRight:(CGFloat)wj_contentInsetRight {
    if (self.contentInset.right == wj_contentInsetRight) return;
    self.contentInset = UIEdgeInsetsMake(self.contentInset.top, self.contentInset.left, self.contentInset.bottom, wj_contentInsetRight);
}


@end
