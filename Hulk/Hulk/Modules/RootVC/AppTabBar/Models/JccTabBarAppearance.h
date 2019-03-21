//
//  JccTabBarAppearance.h
//  ios-jucaicat
//
//  Created by 吴云海 on 16/9/14.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "AppBaseDTO.h"
#import "ITabBarAppearance.h"

/**
 *  tabbar外观
 */
@interface JccTabBarAppearance : AppBaseDTO<ITabBarAppearance>

/**
 *  背景图片
 */
@property(nonatomic, copy) NSString *backgroundPath;

/**
 *  背景颜色
 */
@property(nonatomic, copy) NSString *backgroundColorHexString;

/**
 *  TabBarItemUIConfig
 */
@property(nonatomic, copy) NSArray *tabBarItemAppearances;


@end