//
//  WJActionSheetView.m
//  WJCommon-master
//
//  Created by 吴云海 on 16/6/15.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "WJActionSheetView.h"
#import "Masonry.h"
#import "BaseWJObject.h"


@interface WJActionSheetViewAppearanceParams : BaseWJObject
/**
 *  背景透明度 0.0f ~ 1.0f
 */
@property(nonatomic, assign) CGFloat backgroundAlpha;

/**
 *  触摸背景是否消失
 */
@property(nonatomic, assign) BOOL touchBackgroundDismiss;

/**
 *  动画时长
 */
@property(nonatomic, assign) NSTimeInterval animatedDuration;

/**
 *  内容视图高
 */
@property(nonatomic, assign) CGFloat contentViewHeight;

/**
 *  重置到默认参数
 */
- (void)resetDefault;

@end

@implementation WJActionSheetViewAppearanceParams

-(instancetype)init {
    self = [super init];
    if (self) {
        [self resetDefault];
    }
    return self;
}

-(void)resetDefault {
    self.backgroundAlpha = 0.3f;
    self.touchBackgroundDismiss = NO;
    self.animatedDuration = 0.2f;
    self.contentViewHeight = 0.0f;
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface WJActionSheetView ()

@property(nonatomic, weak) UIView *backgroundView;

@property(nonatomic, weak) UIView<IWJActionSheetContentView> *contentView;

@property (nonatomic, assign) BOOL isHide;

@property (nonatomic, strong) WJActionSheetViewAppearanceParams *params;

@end

@implementation WJActionSheetView

-(void)wj_loadSubViews {
    [super wj_loadSubViews];
    if (!_params) {
        self.params = [[WJActionSheetViewAppearanceParams alloc] init];
    }
    self.isHide = YES;
    if (!_backgroundView) {
        UIView *v = [[UIView alloc] init];
        [v setAlpha:self.params.backgroundAlpha];
        [v setBackgroundColor:[UIColor blackColor]];
        [self insertSubview:v atIndex:0];
        _backgroundView = v;
        __weak typeof(self) selfObject = self;
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(selfObject);
        }];
        [v addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapExec:)]];
    }
}

- (void)tapExec:(UIGestureRecognizer*) gestureRecognizer {
    if (self.params.touchBackgroundDismiss && gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [self hide:YES];
    }
}

#pragma mark
-(BOOL)isHide {
    return _isHide;
}

- (void)hide:(BOOL)animated {
    if (![self isHide] && self.superview && self.contentView) {
        self.isHide = YES;
        [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_bottom);
        }];
        if (animated) {
            [UIView animateWithDuration:self.params.animatedDuration animations:^{
                [self layoutIfNeeded];
                [self.backgroundView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self setHidden:YES];
                [self.superview sendSubviewToBack:self];
            }];
        } else {
            [self.backgroundView setAlpha:0.0f];
            [self layoutIfNeeded];
            [self setHidden:YES];
            [self.superview sendSubviewToBack:self];
        }
    }
}

- (void)show:(BOOL)animated {
    if ([self isHide] && self.superview && self.contentView) {
        [self.superview bringSubviewToFront:self];
        self.isHide = NO;
        [self setHidden:NO];
        CGFloat h = _contentView.bounds.size.height;
        [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_bottom).with.offset(-h);
        }];
        if (animated) {
            [self.backgroundView setAlpha:0.0f];
            [UIView animateWithDuration:self.params.animatedDuration animations:^{
                [self layoutIfNeeded];
                [self.backgroundView setAlpha:self.params.backgroundAlpha];
            }];
        } else {
            [self.backgroundView setAlpha:self.params.backgroundAlpha];
            [self layoutIfNeeded];
        }
    }
}

- (void)relayoutContentView {
    if (_contentView) {
        [self configAppearanceParams];
        [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(self.params.contentViewHeight));
            if (![self isHide]) {
                make.top.equalTo(self.mas_bottom).with.offset(-self.params.contentViewHeight);
            }
        }];
        [self layoutIfNeeded];
    }
}

- (instancetype)initWithContentView:(UIView<IWJActionSheetContentView>*)contentView {
    self = [super init];
    if (self) {
        if (!contentView) {
            @throw [NSException exceptionWithName:@"WJActionSheetViewException" reason:@"contentView not is nil" userInfo:nil];
        }
        [self addSubview:contentView];
        [contentView setContainerView:self];
        _contentView = contentView;
        [self configAppearanceParams];
        __weak typeof(self) selfObject = self;
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(selfObject.mas_left);
            make.right.equalTo(selfObject.mas_right);
            make.height.equalTo(@(selfObject.params.contentViewHeight));
            make.top.equalTo(selfObject.mas_bottom);
        }];
        
        [self setHidden:_isHide];
    }
    return self;
}

-(void) configAppearanceParams {
    [self.params resetDefault];
    if (_contentView) {
        if ([_contentView respondsToSelector:@selector(backgroundAlpha)]) {
            CGFloat t = [_contentView backgroundAlpha];
            t = MIN(1.0f, t);
            t = MAX(0.0f, t);
            self.params.backgroundAlpha = t;
        }
        
        if ([_contentView respondsToSelector:@selector(touchBackgroundDismiss)]) {
            self.params.touchBackgroundDismiss = [_contentView touchBackgroundDismiss];
        }
        
        if ([_contentView respondsToSelector:@selector(animatedDuration)]) {
            NSTimeInterval t = [_contentView animatedDuration];
            t = MIN(10.0f, t);
            t = MAX(0.0f, t);
            self.params.animatedDuration = t;
        }
        self.params.contentViewHeight = [_contentView contentViewHeight];
    }
}

-(void)didMoveToSuperview {
    [super didMoveToSuperview];
    if (self.superview) {
        if ([self isHide]) {
            [self.superview sendSubviewToBack:self];
        } else {
            [self.superview bringSubviewToFront:self];
        }
    }
}

@end
