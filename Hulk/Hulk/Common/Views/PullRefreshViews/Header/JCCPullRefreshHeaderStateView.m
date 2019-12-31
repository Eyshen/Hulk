//
//  WJPullRefreshHeaderStateView.m
//  WJPullRefreshView-example
//
//  Created by Yunhai.Wu on 16/2/18.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "JCCPullRefreshHeaderStateView.h"

@interface JCCPullRefreshHeaderStateView ()
@property (nonatomic, assign) WJPullRefreshState state;
@property (nonatomic, weak) IBOutlet UILabel *refLabel;
@property (nonatomic, weak) IBOutlet UIImageView *refImgView;
@end

@implementation JCCPullRefreshHeaderStateView

static NSArray *loadingTexts = nil;

+(void)initialize {
    if (!loadingTexts) {
        loadingTexts = @[
                         @"MornWallet沫宁钱包",
                         @"投资不仅是一种行为，也是一种哲学",
                         @"一分耕耘一分收获，一分投资一分回报",
                         @"早安科技"];
        
    }
}

#pragma mark IWJPullRefreshStateView
- (void)setState:(WJPullRefreshState)aState scrollView:(UIScrollView *)scrollView {
    
    if (aState == WJPullRefreshStateLoading) {
        //换文本
        if (![_refImgView isAnimating]) {
            [_refImgView setAnimationImages:@[[UIImage imageNamed:@"refresh-loading-state-0"],[UIImage imageNamed:@"refresh-loading-state-1"],[UIImage imageNamed:@"refresh-loading-state-2"]]];
            [_refImgView setAnimationRepeatCount:100000000];
            [_refImgView setAnimationDuration:0.5f];
            [_refImgView startAnimating];
        }
    } else {
        if ([_refImgView isAnimating]) {
            [_refImgView stopAnimating];
        }
        [_refImgView setImage:[UIImage imageNamed:@"refresh-loading-state-normal"]];
    }
    
    if (aState == WJPullRefreshStateNormal) {
        [_refLabel setText:[loadingTexts wj_sample]];
    }
    _state = aState;
    
}

@end
