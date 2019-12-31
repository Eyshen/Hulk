//
//  JCCPullRefreshHeaderView.m
//
//  Created by Yunhai.Wu on 16/2/18.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "JCCPullRefreshHeaderView.h"

@interface JCCPullRefreshHeaderView ()

@property (nonatomic, weak) UIScrollView *refScrollView;
@property (nonatomic, assign) WJPullRefreshState state;
@property (nonatomic, weak) UIView<IWJPullRefreshStateView> *refStateView;
@property (nonatomic, assign) BOOL isLoading;


@property (nonatomic, weak) UIImageView *refImgLogo;

@end

@implementation JCCPullRefreshHeaderView

- (void)setState:(WJPullRefreshState) aState {
    if (_state == aState) {
        return;
    }
    [_refStateView setState:aState scrollView:_refScrollView];
    _state = aState;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_refImgLogo setFrame:CGRectMake(0, self.bounds.size.height - _regionHeight - 50, self.bounds.size.width, 50)];
    [_refStateView setFrame:CGRectMake(0, self.bounds.size.height - _regionHeight, self.bounds.size.width, _regionHeight)];
}

- (void)wj_loadSubViews {
    [super wj_loadSubViews];
    [self setState:WJPullRefreshStateNormal];
    [self setBackgroundColor:[UIColor clearColor]];
    
    if (!_refImgLogo) {
//        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"refresh-loading-logo"]];
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        [img setContentMode:UIViewContentModeCenter];
        [self addSubview:img];
        _refImgLogo = img;
    }
}

#pragma mark IWJPullRefreshView
- (instancetype) initWithScrollView:(UIScrollView*) scrollView stateView:(UIView<IWJPullRefreshStateView>*) stateView {
    self = [super initWithFrame:CGRectMake(0.0f, -scrollView.bounds.size.height, scrollView.bounds.size.width, scrollView.bounds.size.height)];
    if (self) {
        [self addSubview:stateView];
        _refStateView = stateView;
        [_refStateView setState:_state scrollView:scrollView];
        _regionHeight = WJ_PULL_REFRESH_REGION_HEIGHT;
        _refScrollView = scrollView;
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin];
    }
    return self;
}

- (void)refreshScrollViewDidBeginLoading:(UIScrollView*) scrollView animated:(BOOL) animated {
    if (_state == WJPullRefreshStateNormal && !_isLoading && scrollView.wj_contentInsetTop == 0.0f) {
        
        _isLoading = [_delegate refreshDidTriggerRefresh:self];
        if (_isLoading) {
            scrollView.wj_contentInsetTop = _regionHeight;
            [self setState:WJPullRefreshStateLoading];
            [_refScrollView setContentOffset:CGPointMake(0, -_regionHeight) animated:animated];
        }
    }
}

- (void)refreshScrollViewDidScroll:(UIScrollView*) scrollView {
    if (_state == WJPullRefreshStateLoading && _isLoading) {
        CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
        offset = MIN(offset, _regionHeight);
        scrollView.wj_contentInsetTop = offset;
    } else if (scrollView.isDragging) {
        if (_state == WJPullRefreshStatePulling && scrollView.contentOffset.y > -_regionHeight && scrollView.contentOffset.y < 0.0f && !_isLoading ) {
            [self setState:WJPullRefreshStateNormal];
        } else if (_state == WJPullRefreshStateNormal && scrollView.contentOffset.y < -_regionHeight && !_isLoading) {
            [self setState:WJPullRefreshStatePulling];
        }
        
        if (scrollView.contentInset.top != 0) {
            scrollView.wj_contentInsetTop = 0.0f;
        }
    }
}

- (void)refreshScrollViewDidEndDragging:(UIScrollView*) scrollView {
    WJ_WEAK_REF_TYPE weakSelf = self;
    if (scrollView.contentOffset.y <= -_regionHeight && !_isLoading) {
        _isLoading = [_delegate refreshDidTriggerRefresh:self];
        if (_isLoading) {
            [self setState:WJPullRefreshStateLoading];
            [UIView animateWithDuration:0.2f animations:^{
                scrollView.wj_contentInsetTop = weakSelf.regionHeight;
            }];
        }
    }
    
}

- (void)refreshScrollViewDidFinishedLoading:(UIScrollView *)scrollView {
    
    if (scrollView.wj_contentInsetTop != 0.0f) {
        _isLoading = NO;
        [self setState:WJPullRefreshStateNormal];
        [UIView animateWithDuration:0.25f animations:^{
            scrollView.wj_contentInsetTop = 0.0f;
        }];
    } else {
        _isLoading = NO;
        [self setState:WJPullRefreshStateNormal];
    }
}

- (void)refreshScrollViewDidFinishedLoading:(UIScrollView *)scrollView success:(BOOL) success delay:(NSTimeInterval) delay {
    
    if (scrollView.wj_contentInsetTop != 0.0f) {
        if (success) {
            [self setState:WJPullRefreshStateFinish];
        } else {
            [self setState:WJPullRefreshStateFail];
        }
        _isLoading = NO;
        WJ_WEAK_REF_TYPE weakSelf = self;
        [UIView animateWithDuration:0.25f delay:delay options:UIViewAnimationOptionTransitionNone animations:^{
            scrollView.wj_contentInsetTop = 0.0f;
        } completion:^(BOOL finished) {
            [weakSelf setState:WJPullRefreshStateNormal];
        }];
    } else {
        _isLoading = NO;
        [self setState:WJPullRefreshStateNormal];
    }
}



@end
