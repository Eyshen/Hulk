//
//  RootVCModule.m
//  Hulk
//
//  Created by 张一 on 17/5/23.
//  Copyright © 2017年 eason. All rights reserved.
//

#import "RootVCModule.h"
#import "AppTabBarController.h"


@implementation RootVCModule

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self routerMapAction];
    [[[application delegate] window] setRootViewController:[AppTabBarController wj_instance]];
    
    return YES;
}

-(void)changeSelectedIndex:(NSNumber*)index {
    [(UITabBarController*)WJ_APPLICATION_ROOT_VIEWCONTROLLER setSelectedIndex:[index integerValue]];
}

-(void)routerMapAction {
    WJ_WEAK_REF_TYPE weakSelf = self;
    //首页
    [[WJUIRoutable sharedInstance] map:UI_ROUTER_URL_ROOT_HOME toCallback:^(NSDictionary *params) {
        [[WJUIRoutable sharedInstance] closeAll:NO];
        NSArray *rootChildViewControllers = [WJ_APPLICATION_ROOT_VIEWCONTROLLER childViewControllers];
        for (UIViewController *vc in rootChildViewControllers) {
            if ([vc isKindOfClass:[UINavigationController class]] && [[vc childViewControllers] count] > 1) {
                [(UINavigationController*)vc popToRootViewControllerAnimated:NO];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf performSelector:@selector(changeSelectedIndex:) withObject:@(0) afterDelay:0.03f];
        });
    }];
    
    //产品列表
    [[WJUIRoutable sharedInstance] map:UI_ROUTER_URL_ROOT_PRODUCT_LIST toCallback:^(NSDictionary *params) {
        [[WJUIRoutable sharedInstance] closeAll:NO];
        NSArray *rootChildViewControllers = [WJ_APPLICATION_ROOT_VIEWCONTROLLER childViewControllers];
        for (UIViewController *vc in rootChildViewControllers) {
            if ([vc isKindOfClass:[UINavigationController class]] && [[vc childViewControllers] count] > 1) {
                [(UINavigationController*)vc popToRootViewControllerAnimated:NO];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf performSelector:@selector(changeSelectedIndex:) withObject:@(1) afterDelay:0.03f];
        });
    }];
    
    //主会场
    [[WJUIRoutable sharedInstance] map:UI_ROUTER_URL_ROOT_VENUE toCallback:^(NSDictionary *params) {
        NSArray *rootChildViewControllers = [WJ_APPLICATION_ROOT_VIEWCONTROLLER childViewControllers];
        if ([rootChildViewControllers count] == 5) {
            [[WJUIRoutable sharedInstance] closeAll:NO];
            for (UIViewController *vc in rootChildViewControllers) {
                if ([vc isKindOfClass:[UINavigationController class]] && [[vc childViewControllers] count] > 1) {
                    [(UINavigationController*)vc popToRootViewControllerAnimated:NO];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf performSelector:@selector(changeSelectedIndex:) withObject:@(2) afterDelay:0.03f];
            });
        }
    }];
    
    //资产
    [[WJUIRoutable sharedInstance] map:UI_ROUTER_URL_ROOT_ASSET toCallback:^(NSDictionary *params) {
        NSArray *rootChildViewControllers = [WJ_APPLICATION_ROOT_VIEWCONTROLLER childViewControllers];
        [[WJUIRoutable sharedInstance] closeAll:NO];
        for (UIViewController *vc in rootChildViewControllers) {
            if ([vc isKindOfClass:[UINavigationController class]] && [[vc childViewControllers] count] > 1) {
                [(UINavigationController*)vc popToRootViewControllerAnimated:NO];
            }
        }
        if ([rootChildViewControllers count] == 5) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf performSelector:@selector(changeSelectedIndex:) withObject:@(3) afterDelay:0.03f];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf performSelector:@selector(changeSelectedIndex:) withObject:@(2) afterDelay:0.03f];
            });
        }
    }];
    //我
    [[WJUIRoutable sharedInstance] map:UI_ROUTER_URL_ROOT_MY toCallback:^(NSDictionary *params) {
        NSArray *rootChildViewControllers = [WJ_APPLICATION_ROOT_VIEWCONTROLLER childViewControllers];
        [[WJUIRoutable sharedInstance] closeAll:NO];
        for (UIViewController *vc in rootChildViewControllers) {
            if ([vc isKindOfClass:[UINavigationController class]] && [[vc childViewControllers] count] > 1) {
                [(UINavigationController*)vc popToRootViewControllerAnimated:NO];
            }
        }
        if ([rootChildViewControllers count] == 5) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf performSelector:@selector(changeSelectedIndex:) withObject:@(4) afterDelay:0.03f];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf performSelector:@selector(changeSelectedIndex:) withObject:@(3) afterDelay:0.03f];
            });
        }
    }];
    
    //打开Appstore
    [[WJUIRoutable sharedInstance] map:UI_ROUTER_URL_ROOT_ENCOURAGE toCallback:^(NSDictionary *params) {
        [[WJUIRoutable sharedInstance] openExternal:@"https://itunes.apple.com/cn/app/ju-cai-mao-li-cai/id916475073?mt=8"];
    }];
}

@end
