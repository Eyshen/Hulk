//
//  AppTabBarController.m
//  ios-jucaicat
//
//  Created by wuyunhai on 16/4/21.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "AppTabBarController.h"
#import "AppBaseNavigationController.h"
#import "JccTabBar.h"
#import "AppTabBarViewModel.h"
#import <Bugly/Bugly.h>
#import "HomeViewController.h"
#import "OrdersViewController.h"
#import "MineViewController.h"

@interface AppTabBarController ()

@property(nonatomic, strong) AppTabBarViewModel *viewModel;

@property(nonatomic, weak) JccTabBar *jccTabBar;

@end

@implementation AppTabBarController

//-(void)CustomTabbarViewSelectAction:(int)selectIndex{
//    self.selectedIndex = selectIndex;
//}

-(id)init{
    self=[super init];
    if (self) {
        self.viewModel =[[AppTabBarViewModel alloc]init];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_viewModel wj_viewWillAppear];
    if (!_jccTabBar && self.tabBar) {
        for (UITabBarItem *item in self.tabBar.items) {
            [item setEnabled:NO];
        }
        JccTabBar *jccTabBar = [JccTabBar wj_instance];
        [jccTabBar setFrame:self.tabBar.bounds];
        [jccTabBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [jccTabBar setOwnerTabBarController:self];
        [self.tabBar addSubview:jccTabBar];
        _jccTabBar = jccTabBar;
        WJ_WEAK_REF_TYPE weakSelf = self;
        [jccTabBar setActionBlock:^void(NSInteger selectedIndex) {
            BLYLogError(@"selectedIndex:%li",(long)selectedIndex);
            if (selectedIndex < [[weakSelf viewControllers] count]) {
                [weakSelf setSelectedIndex:selectedIndex];
            }
        }];
        
        //添加关注
        [self.KVOController unobserveAll];
        
        [self.KVOController observe:_viewModel keyPath:@"tabBarAppearance" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
            [weakSelf.jccTabBar setAppearance:weakSelf.viewModel.tabBarAppearance];
        }];
        
//        [self.KVOController observe:_viewModel keyPath:@"isCommunity" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
//            [weakSelf refreshTabbarUI];
//        }];
    }
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_viewModel wj_viewDidAppear];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_viewModel wj_viewWillDisappear];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_viewModel wj_viewDidDisappear];
}

-(void)refreshTabbarUI{
//    if (self.viewModel.isCommunity) {
//        AppBaseNavigationController* navController = (AppBaseNavigationController*)self.viewControllers[2];
//        [navController setViewControllers:[NSArray arrayWithObjects:[BBSHomePageViewController wj_instance], nil]];
//    }else{
//        AppBaseNavigationController* navController = (AppBaseNavigationController*)self.viewControllers[2];
//        JccCommonWebViewController *webVC = [JccCommonWebViewController wj_instance];
//        [navController setViewControllers:[NSArray arrayWithObjects:webVC, nil]];
//        [self setCommonWebVC:webVC];
//        [self.commonWebVC reloadURL:self.viewModel.venueURL];
//
//    }
}

+(instancetype)wj_instance {
    AppTabBarController *tabBarController = [[AppTabBarController alloc] init];
    AppBaseNavigationController *nav1 = [AppBaseNavigationController wj_instance:[HomeViewController wj_instance]];
//    AppBaseNavigationController *nav2 = [AppBaseNavigationController wj_instance:[InvestViewController wj_instance]];
    //主会场
//    JccCommonWebViewController *webVC = [JccCommonWebViewController wj_instance];
//    AppBaseNavigationController *nav3= [AppBaseNavigationController wj_instance:webVC];
//    [tabBarController setCommonWebVC:webVC];
    AppBaseNavigationController *nav4 = [AppBaseNavigationController wj_instance:[OrdersViewController wj_instance]];
    
    AppBaseNavigationController *nav5 = [AppBaseNavigationController wj_instance:[MineViewController wj_instance]];
//    [tabBarController setViewControllers:@[nav1,nav2,nav3,nav4,nav5]];
    [tabBarController setViewControllers:@[nav1,nav4,nav5]];
    return tabBarController;
}

@end
