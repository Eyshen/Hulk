//
//  BaseWJScrollView.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 16/2/18.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "BaseWJScrollView.h"

@interface BaseWJScrollView ()
@property (nonatomic, assign) BOOL initTag;
@end

@implementation BaseWJScrollView

-(instancetype)init {
    self = [super init];
    if (self) {
        [self wjTableInit];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self wjTableInit];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self wjTableInit];
    }
    return self;
}


-(void) wjTableInit {
    if (!_initTag) {
        //去除子视图响应延时问题
        self.canCancelContentTouches = YES;
        UIView *wrapView = self.subviews.firstObject;
        if (wrapView && [NSStringFromClass(wrapView.class) hasSuffix:@"WrapperView"]) {
            for (UIGestureRecognizer *gesture in wrapView.gestureRecognizers) {
                if ([NSStringFromClass(gesture.class) containsString:@"DelayedTouchesBegan"] ) {
                    gesture.enabled = NO;
                    break;
                }
            }
        }
        self.delaysContentTouches = NO;
        _initTag = YES;
    }
}

@end
