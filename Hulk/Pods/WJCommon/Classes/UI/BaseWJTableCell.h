//
//  BaseWJTableCell.h
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
 *  自定义UITableCell 基类
 */
@interface BaseWJTableCell : UITableViewCell

/**
 * 加载子视图
 */
-(void) wj_loadSubViews;

/**
 *  计算行高
 *
 *  @param info 计算行高数据
 *
 *  @return 行高
 */
+(CGFloat) wj_getDefaultRowHeight:(id) info;

/**
 *  得到重用标示
 *
 *  @return 标示符
 */
+(NSString*) wj_tableCellIdentifier;

/**
 *  重用cell（当cell被重用时调用）
 */
-(void) wj_reuseTableCell;//重用Cell

/**
 *  观察变化属性值列表（子类继承）
 *
 *  @return 属性值列表
 */
-(NSArray*) wj_observableKeypaths;//子类继承

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
-(void) wj_changeForKeypath:(NSString*) keyPath;//子类继承

/**
 *  创建一个实例
 *
 *  @return 实例对象
 */
+(instancetype) wj_instance;

@end