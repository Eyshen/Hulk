//
//  AppBaseTableViewController.m
//  WJCommon-master
//
//  Created by 吴云海 on 16-2-27.
//  Copyright (c) 2016年 WJ. All rights reserved.
//

#import "AppBaseTableViewController.h"
#import "JCCPullRefreshFooterStateView.h"
#import "JCCPullRefreshFooterView.h"
#import "JCCPullRefreshHeaderStateView.h"
#import "JCCPullRefreshHeaderView.h"

@interface AppBaseTableViewController ()

@end

@implementation AppBaseTableViewController

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.KVOController unobserveAll];
    
    UIColor *defaultViewColor = APP_VIEW_CONTROLLER_VIEW_DEFAULT_COLOR;
    if (defaultViewColor) {
        [self.wjView setBackgroundColor:defaultViewColor];
    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.swipeBackEnabled = YES;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (UIView<IWJLoadingView> *)wj_instanceLoadingView {
    /**
     *  添加加载视图
     */
    return nil;
}

- (UIView<IWJPullRefreshFooterView> *)wj_instancePullRefreshFooterView {
    
    /**
     * 上拉加载更多
     */
    return [[JCCPullRefreshFooterView alloc] initWithScrollView:self.tableView stateView:[JCCPullRefreshFooterStateView wj_instance]];
    
}

- (UIView<IWJPullRefreshView> *)wj_instancePullRefreshHeaderView {
    /**
     *  下拉刷新控件
     */
    
    return [[JCCPullRefreshHeaderView alloc] initWithScrollView:self.tableView stateView:[JCCPullRefreshHeaderStateView wj_instance]];
}

- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}

@end
