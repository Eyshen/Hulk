//
//  AppBaseViewController.m
//  WJCommon-master
//
//  Created by 吴云海 on 16-2-27.
//  Copyright (c) 2016年 WJ. All rights reserved.
//

#import "AppBaseViewController.h"
#import "UIColor+WJExtension.h"

@interface AppBaseViewController ()

@end

@implementation AppBaseViewController

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

- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}

@end
