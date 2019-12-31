//
//  JCCPullRefreshFooterStateView.m
//
//  Created by Yunhai.Wu on 16/2/18.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "JCCPullRefreshFooterStateView.h"

@interface JCCPullRefreshFooterStateView ()

@property (nonatomic, assign) WJPullRefreshState state;
@property (nonatomic, weak) UILabel *refLabel;
@property (nonatomic, weak) UIActivityIndicatorView *refActivityView;

@end

@implementation JCCPullRefreshFooterStateView

- (void)wj_loadSubViews {
    [super wj_loadSubViews];
    if (!_refActivityView) {
        UIActivityIndicatorView *v = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [v setHidesWhenStopped:YES];
        [self addSubview:v];
        _refActivityView = v;
    }
    if (!_refLabel) {
        UILabel *lab = [[UILabel alloc] init];
        [lab setTextColor:[UIColor grayColor]];
        [lab setFont:[UIFont fontWithName:APP_FONT_NAME size:11.0f]];
        [lab setBackgroundColor:[UIColor clearColor]];
        [lab setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:lab];
        _refLabel = lab;
    }
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_refActivityView setCenter:CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f)];
    [_refLabel setFrame:self.bounds];
}

#pragma mark IWJPullRefreshStateView
- (void)setState:(WJPullRefreshState) aState scrollView:(UIScrollView*) scrollView {
    
    if (aState == WJPullRefreshStateLoading) {
        [_refLabel setHidden:YES];
        [_refActivityView setHidden:NO];
        [_refActivityView startAnimating];
    } else {
        [_refLabel setHidden:NO];
        [_refActivityView setHidden:YES];
    }
    
    switch (aState) {
        case WJPullRefreshStatePulling:
            //[_refLabel setText:@"松手加载更多数据"];
            break;
        case WJPullRefreshStateNormal:
            //[_refLabel setText:@"上拉加载"];
            break;
        case WJPullRefreshStateFinish:
            //[_refLabel setText:@"加载成功~"];
            break;
        case WJPullRefreshStateFail:
            //[_refLabel setText:@"加载失败~"];
            break;
        case WJPullRefreshStateFull:
            //[_refLabel setText:@"已全部加载"];
            break;
        default:
            break;
    }
    
    _state = aState;
}

@end
