//
//  JCCPullRefreshFooterView.m
//
//  Created by Yunhai.Wu on 16/2/18.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "JCCPullRefreshFooterView.h"

@interface JCCPullRefreshFooterView ()

@property (nonatomic, weak) UIScrollView *refScrollView;
@property (nonatomic, assign) WJPullRefreshState state;
@property (nonatomic, weak) UIView<IWJPullRefreshStateView> *refStateView;
@property (nonatomic, assign) BOOL isLoading;//default no

@end

@implementation JCCPullRefreshFooterView

- (void)setState:(WJPullRefreshState) aState {
    if (_state == aState) {
        return;
    }
    [_refStateView setState:aState scrollView:_refScrollView];
    _state = aState;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_refStateView setFrame:CGRectMake(0, 0, self.bounds.size.width, _regionHeight)];
    
}
- (void)wj_loadSubViews {
    [super wj_loadSubViews];
    
    if (_isFullData) {
        [self setState:WJPullRefreshStateFull];
    } else {
        [self setState:WJPullRefreshStateNormal];
    }
    [self setBackgroundColor:[UIColor clearColor]];
    
}

#pragma mark IWJPullRefreshFooterView
- (void)refreshContentSize {
    [self setFrame:CGRectMake(0, _refScrollView.contentSize.height, _refScrollView.bounds.size.width, _refScrollView.bounds.size.height)];
}

- (void)setIsFullData:(BOOL)isFullData {
    if (_isFullData == isFullData) {
        return;
    }
    _isFullData = isFullData;
    if (_isFullData) {
        [self setState:WJPullRefreshStateFull];
        if (_refScrollView.wj_contentInsetBottom != 0.0f) {
            _refScrollView.wj_contentInsetBottom = 0.0f;
        }
    } else {
        [self setState:WJPullRefreshStateNormal];
        if (_refScrollView.wj_contentInsetBottom != 0.0f) {
            _refScrollView.wj_contentInsetBottom = 0.0f;
        }
    }
    _isLoading = NO;
}



- (instancetype) initWithScrollView:(UIScrollView*) scrollView stateView:(UIView<IWJPullRefreshStateView> *)stateView {
    
    self = [super initWithFrame:CGRectMake(0.0f, scrollView.contentSize.height, scrollView.bounds.size.width, scrollView.bounds.size.height)];
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

/**
 *  **************************************************
 *  **************************************************
 *  **************************************************
 *  **************************************************
 *  **************************************************
 *  **************************************************
 */
- (void)refreshScrollViewDidBeginLoading:(UIScrollView*) scrollView animated:(BOOL) animated {
    
    if (_state == WJPullRefreshStateNormal && !_isLoading && scrollView.wj_contentInsetBottom == 0.0f) {
        _isLoading = [_delegate refreshDidTriggerRefresh:self];
        if (_isLoading) {
            scrollView.wj_contentInsetBottom = _regionHeight;
            [self setState:WJPullRefreshStateLoading];
            [_refScrollView setContentOffset:CGPointMake(0, _refScrollView.contentSize.height - _refScrollView.bounds.size.height + _regionHeight) animated:animated];
        }
    }
    
}

- (void)refreshScrollViewDidScroll:(UIScrollView*) scrollView {
    if (_state == WJPullRefreshStateLoading && _isLoading) {
        CGFloat offset = scrollView.contentSize.height - (scrollView.contentOffset.y + scrollView.bounds.size.height);
        offset = MIN(offset, 0);
        if (offset < 0) {
            offset = MIN(offset * -1, _regionHeight);
        }
        scrollView.wj_contentInsetBottom = offset;
    } else if (scrollView.isDragging) {
        CGFloat space = scrollView.contentSize.height - scrollView.contentOffset.y - scrollView.bounds.size.height;
        
        if (_state == WJPullRefreshStatePulling && space >= -_regionHeight && !_isLoading && _state != WJPullRefreshStateFull) {
            [self setState:WJPullRefreshStateNormal];
        } else if (_state == WJPullRefreshStateNormal && space < -_regionHeight && !_isLoading && _state != WJPullRefreshStateFull) {
            [self setState:WJPullRefreshStatePulling];
        }
        if (scrollView.contentInset.bottom != 0) {
            scrollView.wj_contentInsetBottom = 0.0f;
        }
    }
}

- (void)refreshScrollViewDidEndDragging:(UIScrollView*) scrollView {
    if (scrollView.contentOffset.y + scrollView.bounds.size.height - scrollView.contentSize.height >= _regionHeight && !_isLoading && _state != WJPullRefreshStateFull) {
        _isLoading = [_delegate refreshDidTriggerRefresh:self];
        WJ_WEAK_REF_TYPE weakSelf = self;
        if (_isLoading) {
            [self setState:WJPullRefreshStateLoading];
            [UIView animateWithDuration:0.2f animations:^{
                scrollView.wj_contentInsetBottom = weakSelf.regionHeight;
            }];
        }
    }
    
}

- (void)refreshScrollViewDidFinishedLoading:(UIScrollView *)scrollView {
    
    if (scrollView.wj_contentInsetBottom != 0.0f && _state != WJPullRefreshStateFull) {
        
        WJ_WEAK_REF_TYPE weakSelf = self;
        _isLoading = NO;
        [UIView animateWithDuration:0.20f animations:^{
            scrollView.wj_contentInsetBottom = 0.0f;
        } completion:^(BOOL finished) {
            [weakSelf setState:WJPullRefreshStateNormal];
        }];
    }
}

- (void)refreshScrollViewDidFinishedLoading:(UIScrollView *)scrollView success:(BOOL)success delay:(NSTimeInterval)delay {
    [self refreshScrollViewDidFinishedLoading:scrollView];
}

@end
