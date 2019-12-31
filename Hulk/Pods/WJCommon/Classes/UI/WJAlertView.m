//
//  WJAlertView.m
//  WJCommon-master
//
//  Created by 吴云海 on 16/6/16.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "WJAlertView.h"
#import "BaseWJObject.h"
#import "Masonry.h"
#import "UIApplication+WJExtension.h"
#import "UIScreen+WJExtension.h"

/**
 *  外观参数
 */
@interface WJAlertContentViewAppearanceParams : BaseWJObject
/**
 *  内容大小
 */
@property (nonatomic, assign) CGSize contentSize;

/**
 *  背景透明度
 */
@property (nonatomic, assign) CGFloat backgroundAlpha;
/**
 *  动画时长
 */
@property (nonatomic, assign) NSTimeInterval animatedDuration;

/**
 *  内容视图偏移量
 */
@property (nonatomic, assign) CGPoint contentOffset;

/**
 *  键盘显示后内容视图偏移量Y
 */
@property (nonatomic, assign) CGFloat keyboardShowContentViewOffsetY;

/**
 *  重置到默认参数
 */
-(void) resetDefault;

@end

@implementation WJAlertContentViewAppearanceParams

-(instancetype)init {
    self = [super init];
    if (self) {
        [self resetDefault];
    }
    return self;
}

-(void) resetDefault {
    self.contentSize = CGSizeMake(270.0f, 200);
    self.backgroundAlpha = 0.3f;
    self.animatedDuration = 0.2f;
    self.keyboardShowContentViewOffsetY = 0.0f;
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface WJAlertView ()

/**
 *  背景视图
 */
@property(nonatomic, weak) UIView *backgroundView;

/**
 *  内容视图
 */
@property(nonatomic, weak) UIView<IWJAlertContentView> *pContentView;

/**
 *  外观参数
 */
@property(nonatomic, strong) WJAlertContentViewAppearanceParams *params;

/**
 *  是否键盘通知关闭
 */
@property(nonatomic, assign) BOOL closekeybardNotification;

@end

static NSHashTable *alertViewCaches;

@implementation WJAlertView

+(void)initialize {
    if (!alertViewCaches) {
        alertViewCaches = [NSHashTable weakObjectsHashTable];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handleKeyboardHideNotification:(NSNotification*)notification {
    NSTimeInterval animationDuration = [notification.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    if (_pContentView) {
        [_pContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).with.offset(self.params.contentOffset.y);
        }];
        [UIView animateWithDuration:animationDuration animations:^{
            [self layoutIfNeeded];
        }];
    }
}

- (void)handleKeyboardShowNotification:(NSNotification*)notification {
    NSValue *val = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGFloat keyboardHight = [val CGRectValue].size.height;
    NSTimeInterval animationDuration = [notification.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    if (_pContentView) {
        CGFloat centerY = WJ_SCREEN_HEIGHT - keyboardHight - self.params.contentSize.height/2.0f + self.params.contentOffset.y;
        CGFloat offset = centerY - WJ_SCREEN_HEIGHT/2.0f + self.params.keyboardShowContentViewOffsetY;
        [_pContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).with.offset(offset);
        }];
        [UIView animateWithDuration:animationDuration animations:^{
            [self layoutIfNeeded];
        }];
    }
}

- (void)wj_loadSubViews {
    [super wj_loadSubViews];
    if (!_params) {
        self.params = [[WJAlertContentViewAppearanceParams alloc] init];
        
        UIView *v = [[UIView alloc] init];
        [v setBackgroundColor:[UIColor blackColor]];
        [v setAlpha:self.params.backgroundAlpha];
        [self addSubview:v];
        __weak typeof(self) selfObject = self;
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(selfObject);
        }];
        _backgroundView = v;
        
        if (!_closekeybardNotification) {
            //注册通知
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardShowNotification:) name:UIKeyboardWillShowNotification object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardHideNotification:) name:UIKeyboardWillHideNotification object:nil];
        }
        
    }
}

#pragma mark IWJAlertView
-(instancetype)initWithContentView:(UIView<IWJAlertContentView> *)contentView {
    self = [super init];
    if (self) {
        if (contentView) {
            if ([contentView superview]) [contentView removeFromSuperview];
            [self addSubview:contentView];
            _pContentView = contentView;
            [_pContentView setContainerView:self];
        }
        [self configAppearanceParams];
    }
    return self;
}

- (instancetype)initWithContentView:(UIView<IWJAlertContentView>*)contentView nokeyboardNotification:(BOOL)noNotification{
    self = [super init];
    if (self) {
        if (contentView) {
            if ([contentView superview]) [contentView removeFromSuperview];
            [self addSubview:contentView];
            _pContentView = contentView;
            _closekeybardNotification = noNotification;
            if (noNotification) {
                [[NSNotificationCenter defaultCenter] removeObserver:self];
            }
            [_pContentView setContainerView:self];
        }
        [self configAppearanceParams];
    }
    return self;
}



- (void)close:(BOOL)animated {
    if (self.superview) {
        if (animated) {
            CGAffineTransform origTransform = [self.pContentView transform];
            [UIView animateKeyframesWithDuration:0.25f delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
                [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:1/4.0f animations:^{
                    [self.pContentView setTransform:CGAffineTransformScale(origTransform, 1.1f, 1.1f)];
                }];
                [UIView addKeyframeWithRelativeStartTime:1/4.0f relativeDuration:3/4.0f animations:^{
                    [self.pContentView setTransform:CGAffineTransformScale(origTransform, 0.8f, 0.8f)];
                }];
                [UIView addKeyframeWithRelativeStartTime:1/4.0f relativeDuration:3/4.0f animations:^{
                    [self.pContentView setAlpha:0.0f];
                }];
                [UIView addKeyframeWithRelativeStartTime:3/4.0f relativeDuration:1/4.0f animations:^{
                    [self.backgroundView setAlpha:0.0f];
                }];
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        } else {
            [self removeFromSuperview];
        }
    }
}

- (void)show:(BOOL)animated {
    [self showInView:WJ_APPLICATION_WINDOW animated:animated];
}

- (void)showInView:(UIView*)view animated:(BOOL)animated {
    if (!self.superview && view) {
        [view addSubview:self];
        [alertViewCaches addObject:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(view);
        }];
        [self.backgroundView setAlpha:self.params.backgroundAlpha];
        if (animated) {
            CGAffineTransform origTransform = [self.pContentView transform];
            [UIView animateKeyframesWithDuration:0.25f delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
                [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:1/4.0f animations:^{
                    [self.pContentView setTransform:CGAffineTransformScale(origTransform, 1.1f, 1.1f)];
                }];
                [UIView addKeyframeWithRelativeStartTime:1/4.0f relativeDuration:3/4.0f animations:^{
                    [self.pContentView setTransform:origTransform];
                }];
            } completion:NULL];
        }
    }
}

+(BOOL) existAlertView {
    return [[alertViewCaches allObjects] count] > 0;
}

+(void) closeAllAlertView {
    for (UIView<IWJAlertView> *v in alertViewCaches) {
        [v removeFromSuperview];
    }
}

-(void) configAppearanceParams {
    [self.params resetDefault];
    if (_pContentView) {
        __weak typeof(self) selfObject = self;
        if ([_pContentView respondsToSelector:@selector(backgroundAlpha)])
            [self.params setBackgroundAlpha:[_pContentView backgroundAlpha]];
        if ([_pContentView respondsToSelector:@selector(animatedDuration)])
            [self.params setAnimatedDuration:[_pContentView animatedDuration]];
        if ([_pContentView respondsToSelector:@selector(keyboardShowContentViewOffsetY)])
            [self.params setKeyboardShowContentViewOffsetY:[_pContentView keyboardShowContentViewOffsetY]];
        [self.params setContentSize:[_pContentView contentViewSize]];
        if ([_pContentView respondsToSelector:@selector(contentViewOffset)])
            [self.params setContentOffset:[_pContentView contentViewOffset]];
        [_pContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo([NSValue valueWithCGSize:self.params.contentSize]);
            make.centerX.equalTo(selfObject.mas_centerX).with.offset(selfObject.params.contentOffset.x);
            make.centerY.equalTo(selfObject.mas_centerY).with.offset(selfObject.params.contentOffset.y);
        }];
        [self layoutIfNeeded];
    }
    [self.backgroundView setAlpha:self.params.backgroundAlpha];
}

@end
