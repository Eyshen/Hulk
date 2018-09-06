//
//  IWJRouterViewControllerCallback.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/8/21.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  委托回调
 */
@protocol IWJRouterViewControllerDelegate <NSObject>

/**
 *  试图控制器间回调委托
 *  回调委托
 */
-(void) viewController:(UIViewController*) viewController routerParams:(NSDictionary*) params;

@end
