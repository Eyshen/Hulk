//
//  UIScreen+WJE.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 16/1/5.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import <UIKit/UIKit.h>


#define WJ_SCREEN_SIZE              [UIScreen size]
#define WJ_SCREEN_SCALE             [UIScreen scale]
#define WJ_SCREEN_WIDTH             [UIScreen width]
#define WJ_SCREEN_HEIGHT            [UIScreen height]
#define WJ_SCREEN_APPLICATION_Frame [UIScreen applicationFrame]
#define WJ_SCREEN_BOUNDS            [UIScreen bounds]
#define WJ_IS_IPHONEX               ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

/**
 *  @author 吴云海
 *
 *  UIScreen 扩展
 */
@interface UIScreen (WJExtension)

/**
 *  屏幕 bounds
 */
+(CGRect) bounds;

+(CGRect) applicationFrame;

/**
 *  屏幕宽
 */
+(CGFloat) width;

/**
 *  屏幕高
 */
+(CGFloat) height;

/**
 *  屏幕比例
 */
+(CGFloat) scale;

/**
 *  屏幕大小
 */
+(CGSize) size;

@end
