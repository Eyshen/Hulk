//
//  JccTabBarItemAppearance.h
//  ios-jucaicat
//
//  Created by 吴云海 on 16/9/14.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "AppBaseDTO.h"
#import "ITabBarItemAppearance.h"

/**
 *  TabBarItem外观
 */
@interface JccTabBarItemAppearance : AppBaseDTO<ITabBarItemAppearance>

/**
 *  正常状态icon
 */
@property(nonatomic, copy) NSString *normalIconName;

/**
 *  选择状态icon
 */
@property(nonatomic, copy) NSString *selectedIconName;

/**
 *  正常状态icon path
 */
@property(nonatomic, copy) NSString *normalIconPath;

/**
 *  选择状态icon path
 */
@property(nonatomic, copy) NSString *selectedIconPath;

/**
 *  正常状态标题
 */
@property(nonatomic, copy) NSString *normalTitle;

/**
 *  选择状态标题
 */
@property(nonatomic, copy) NSString *selectedTitle;

/**
 *  是否是主会场
 */
@property(nonatomic, assign) BOOL isVenue;

/**
 *  未读消息数
 */
@property(nonatomic, assign) NSUInteger unreadMsgCount;

@end
