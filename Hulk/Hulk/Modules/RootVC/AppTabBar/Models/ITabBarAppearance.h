//
//  ITabBarAppearance.h
//  ios-jucaicat
//
//  Created by 吴云海 on 16/9/19.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITabBarItemAppearance.h"

/**
 *  TabBar 外观
 */
@protocol ITabBarAppearance <NSObject>

/**
 *  背景图片
 */
-(UIImage*)backgroundImage;

/**
 *  背景颜色
 */
-(UIColor*)backgroundColor;

/**
 *  tabbaritem 外观
 */
-(NSArray*)tabBarItemAppearances;

@end
