//
//  JccTabBar.h
//  ios-jucaicat
//
//  Created by 吴云海 on 16/9/14.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "AppBaseView.h"
#import "ITabBarAppearance.h"

typedef void(^JccTabBarActionBlock)(NSInteger selectedIndex);


@interface JccTabBar : AppBaseView

/**
 *  所属TabBarController
 */
@property(nonatomic, weak) UITabBarController *ownerTabBarController;

/**
 *  外观配置
 */
@property(nonatomic, copy) id<ITabBarAppearance> appearance;

//设置block
-(void)setActionBlock:(JccTabBarActionBlock)actionBlock;

@end
