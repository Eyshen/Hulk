//
//  ITabBarItemAppearance.h
//  ios-jucaicat
//
//  Created by 吴云海 on 16/9/19.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  TabBarItem 外观
 */
@protocol ITabBarItemAppearance <NSObject>

/**
 *  正常图片
 */
-(UIImage*)normalIcon;

/**
 *  选择状态icon
 */
-(UIImage*)selectedIcon;

/**
 *  正常状态标题
 */
-(NSString*)normalTitle;

/**
 *  选择状态标题
 */
-(NSString*)selectedTitle;

/**
 *  是否为主会场
 */
-(BOOL)isVenue;

/**
 *  未读消息数
 *  default 0
 */
-(NSUInteger)unreadMsgCount;

@end
