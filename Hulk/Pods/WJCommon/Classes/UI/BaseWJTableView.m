//
//  BaseWJTableView.m
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

#import "BaseWJTableView.h"

@interface BaseWJTableView ()
@property (nonatomic, assign) BOOL initTag;
@end

@implementation BaseWJTableView

#pragma mark Observer tableView contentSize
-(void) addContentSizeChangeKVO {
    [self addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"]) {
        [_pullRefreshFooterView refreshContentSize];
    }
}

-(void) removeContentSizeKVO {
    [self removeObserver:self forKeyPath:@"contentSize"];
}

-(void) wjTableInit {
    if (!_initTag) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
//        self.canCancelContentTouches = YES;
//        UIView *wrapView = self.subviews.firstObject;
//        if (wrapView && [NSStringFromClass(wrapView.class) hasSuffix:@"WrapperView"]) {
//            for (UIGestureRecognizer *gesture in wrapView.gestureRecognizers) {
//                if ([NSStringFromClass(gesture.class) containsString:@"DelayedTouchesBegan"] ) {
//                    gesture.enabled = NO;
//                    break;
//                }
//            }
//        }
//        
//        self.delaysContentTouches = NO;
        [self addContentSizeChangeKVO];
        _initTag = YES;
    }
}


-(void)dealloc {
    [self removeContentSizeKVO];
}

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

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self wjTableInit];
    }
    return self;
}

@end
