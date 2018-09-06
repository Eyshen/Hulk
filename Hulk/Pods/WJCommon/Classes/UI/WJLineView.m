//
//  WJLineView.m
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

#import "WJLineView.h"

@implementation WJLineView

-(void)wj_loadSubViews {
    [super wj_loadSubViews];
    [self setBackgroundColor:[UIColor clearColor]];
    _lineWidth = 1.0f / [[UIScreen mainScreen] scale];
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapButt);
    
    if (_lineStyle == WJLineStyleDotted) {
        CGFloat lenghts[] = {5, 5};
        CGContextSetLineDash(context, 0, lenghts, 2);
    }
    
    CGContextSetLineWidth(context, _lineWidth);
    if (!_lineColor) {
        _lineColor = [UIColor grayColor];
    }
    CGContextSetStrokeColorWithColor(context, _lineColor.CGColor);
    CGContextBeginPath(context);
    
    switch (_drawPosition) {
        case WJLineDrawPositionVerticalCenter:
            CGContextMoveToPoint(context, (self.bounds.size.width-_lineWidth)/2.0f, 0);
            CGContextAddLineToPoint(context, (self.bounds.size.width-_lineWidth)/2.0f, self.bounds.size.height);
            break;
        case WJLineDrawPositionHorizontalCenter:
            CGContextMoveToPoint(context, 0, (self.bounds.size.height-_lineWidth)/2.0f);
            CGContextAddLineToPoint(context, self.bounds.size.width, (self.bounds.size.height-_lineWidth)/2.0f);
            break;
        case WJLineDrawPositionTop:
            CGContextMoveToPoint(context, 0, _lineWidth/2.0f);
            CGContextAddLineToPoint(context, self.bounds.size.width, _lineWidth/2.0f);
            break;
        case WJLineDrawPositionLeft:
            CGContextMoveToPoint(context, _lineWidth/2.0f, 0);
            CGContextAddLineToPoint(context, _lineWidth/2.0f, self.bounds.size.height);
            break;
        case WJLineDrawPositionRight:
            CGContextMoveToPoint(context, self.bounds.size.width-_lineWidth/2.0f, 0);
            CGContextAddLineToPoint(context, self.bounds.size.width-_lineWidth/2.0f, self.bounds.size.height);
            break;
        case WJLineDrawPositionBottom:
            CGContextMoveToPoint(context, 0, self.bounds.size.height-_lineWidth/2.0f);
            CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height-_lineWidth/2.0f);
            break;
        default:
            break;
    }
    
    CGContextStrokePath(context);
}


-(void)setLineWidth:(CGFloat)lineWidth {
    if (_lineWidth == lineWidth) {
        return;
    }
    _lineWidth = MAX(0, lineWidth);
    [self setNeedsDisplay];
}

-(NSArray *)wj_observableKeypaths {
    return @[@"lineColor",@"drawPosition",@"lineWidth"];
}

-(void)wj_changeForKeypath:(NSString *)keyPath {
    [self setNeedsDisplay];
}

@end
