//
//  BaseWJTableViewController.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/7/30.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import "BaseWJTableViewController.h"
#import "WJStringUtils.h"
#import "BaseWJTableView.h"

@interface BaseWJTableViewController ()<IWJPullRefreshViewDelegate>

@end

@implementation BaseWJTableViewController

-(UITableViewStyle)wj_tableViewStyle {
    return UITableViewStylePlain;
}

#pragma mark UITableViewDataSource
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark ViewController Overriding
- (void)viewDidLoad {
    [super viewDidLoad];
    if (!_tableView) {
        __weak typeof(self) selfObject = self;
        BaseWJTableView *t = [[BaseWJTableView alloc] initWithFrame:self.wjView.bounds style:[self wj_tableViewStyle]];
        [t setBackgroundColor:[UIColor clearColor]];
        [t setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [t setEditing:self.isEditing];
        [t setDelegate:self];
        [t setDataSource:self];
        [self.wjView addSubview:t];
        [t mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(selfObject.wjView);
        }];
        _tableView = t;
    }
    if (self.wjLoadingView && ![self.wjLoadingView isHidden]) {
        [self.wjView bringSubviewToFront:self.wjLoadingView];
    }
}

#pragma mark Overriding superClass
-(void)wj_execLoadDataAction {
    
    [self wj_execRefreshNewDataAction];
}

#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_wjPullRefreshHeaderView) [_wjPullRefreshHeaderView refreshScrollViewDidScroll:scrollView];
    if (_wjPullRefreshFooterView) [_wjPullRefreshFooterView refreshScrollViewDidScroll:scrollView];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (_wjPullRefreshHeaderView) [_wjPullRefreshHeaderView refreshScrollViewDidEndDragging:scrollView];
    if (_wjPullRefreshFooterView) [_wjPullRefreshFooterView refreshScrollViewDidEndDragging:scrollView];
}

#pragma mark IWJPullRefreshViewDelegate
-(BOOL)refreshDidTriggerRefresh:(UIView<IWJPullRefreshView> *)view {
    if (_wjPullRefreshHeaderView == view) {
        [self performSelectorOnMainThread:@selector(wj_execRefreshNewDataAction) withObject:nil waitUntilDone:NO];
        return YES;
    }
    if (_wjPullRefreshFooterView == view) {
        [self performSelectorOnMainThread:@selector(wj_execRefreshMoreDataAction) withObject:nil waitUntilDone:NO];
        return YES;
    }
    return NO;
}

#pragma mark load data exec method
-(void)wj_execRefreshNewDataAction {}

-(void)wj_execRefreshMoreDataAction {}

#pragma mark Instance PullRefreshView
-(UIView<IWJPullRefreshView> *)wj_instancePullRefreshHeaderView {
    return nil;
}

-(UIView<IWJPullRefreshFooterView> *)wj_instancePullRefreshFooterView {
    return nil;
}



#pragma mark enable change
-(void) wj_changeEnabledHeaderRefreshUI {
    if (_enabledHeaderRefresh) {
        WJLogDebug(@"启用 下拉刷新数据");
        if (!_wjPullRefreshHeaderView) {
            UIView<IWJPullRefreshView> *v = [self wj_instancePullRefreshHeaderView];
            [v setDelegate:self];
            [_tableView addSubview:v];
            _wjPullRefreshHeaderView = v;
            
            [(BaseWJTableView*)_tableView setPullRefreshHeaderView:v];
        }
    } else {
        WJLogDebug(@"禁用 下拉刷新数据");
        if ([_wjPullRefreshHeaderView superview]) {
            [_wjPullRefreshHeaderView removeFromSuperview];
        }
    }
}

-(void) wj_changeEnabledFooterRefreshUI {
    if (_enabledFooterRefresh) {
        WJLogDebug(@"启用 加载更多数据");
        if (!_wjPullRefreshFooterView) {
            UIView<IWJPullRefreshFooterView> *v = [self wj_instancePullRefreshFooterView];
            [v setDelegate:self];
            [_tableView addSubview:v];
            _wjPullRefreshFooterView = v;
            
            [(BaseWJTableView*)_tableView setPullRefreshFooterView:v];
        }
    } else {
        WJLogDebug(@"禁用 加载更多数据");
        if ([_wjPullRefreshFooterView superview]) {
            [_wjPullRefreshFooterView removeFromSuperview];
        }
    }
}

#pragma mark KVO
-(NSArray *)wj_observableKeypaths {
    return @[@"enabledHeaderRefresh",@"enabledFooterRefresh"];
}

-(void)wj_changeForKeypath:(NSString *)keypath {
    if (WJ_STRING_EQUAL(keypath, @"enabledHeaderRefresh")) {
        [self performSelectorOnMainThread:@selector(wj_changeEnabledHeaderRefreshUI) withObject:nil waitUntilDone:NO];
    } else if (WJ_STRING_EQUAL(keypath, @"enabledFooterRefresh")) {
        [self performSelectorOnMainThread:@selector(wj_changeEnabledFooterRefreshUI) withObject:nil waitUntilDone:NO];
    }
}

@end
