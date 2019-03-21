//
//  JccTabBarItem.h
//  ios-jucaicat
//
//  Created by 吴云海 on 16/9/19.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "AppBaseView.h"
#import "ITabBarItemAppearance.h"

/**
 *  模拟UITabBarItem
 */
@interface JccTabBarItem : AppBaseView

/**
 *  外观
 */
@property(nonatomic, copy) id<ITabBarItemAppearance> appearance;

/**
 *  当前状态是否为选择状态
 */
@property(nonatomic, assign) BOOL selected;

/**
 *  添加点击事件
 */
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
