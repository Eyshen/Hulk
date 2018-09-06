//
//  BaseWJButton.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/7/29.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJLoggingMacros.h"

/**
 *  自定义UIButton 基类
 */
@interface BaseWJButton : UIButton

/**
 * 加载子视图
 */
-(void) wj_loadSubViews;


/**
 *  观察变化属性值列表（子类继承）
 *
 *  @return 属性值列表
 */
-(NSArray*) wj_observableKeypaths;

/**
 *  KVO options
 *
 *  @param keyPath 属性名称
 *
 *  @return options
 */
-(NSKeyValueObservingOptions) wj_observerOptionsForKeypath:(NSString*) keyPath;

/**
 *  属性发生变化调用方法（子类继承实现）
 *
 *  @param keyPath 属性名称
 */
-(void) wj_changeForKeypath:(NSString*) keyPath;

/**
 *  创建一个实例
 *
 *  @return 实例对象
 */
+(instancetype) wj_instance;

@end
