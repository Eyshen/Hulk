//
//  AppTabBarViewModel.h
//  ios-jucaicat
//
//  Created by 张学超 on 16/9/18.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "AppBaseViewModel.h"
#import "ITabBarAppearance.h"

@interface AppTabBarViewModel : AppBaseViewModel

/**
 *  tabbar 外观
 */
@property(nonatomic, copy, readonly) id<ITabBarAppearance> tabBarAppearance;

/**
 *  主会场地址
 */
@property(nonatomic, copy) NSString *venueURL;

@property(nonatomic, assign) BOOL isCommunity;

@end
