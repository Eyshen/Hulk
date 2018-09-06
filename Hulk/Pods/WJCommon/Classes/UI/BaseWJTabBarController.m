//
//  BaseWJTabBarController.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/8/6.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import "BaseWJTabBarController.h"

@implementation BaseWJTabBarController

+(instancetype)wj_instance {
    BaseWJTabBarController *tabBarController = nil;
    @try {
        NSString *className = NSStringFromClass(self);
        NSString *nibFilePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.nib",className]];
        NSString *iphoneNibFilePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@~iphone.nib",className]];
        NSString *ipadNibFilePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@~ipad.nib",className]];
        if ([[NSFileManager defaultManager] fileExistsAtPath:iphoneNibFilePath] || [[NSFileManager defaultManager] fileExistsAtPath:nibFilePath] || [[NSFileManager defaultManager] fileExistsAtPath:ipadNibFilePath]) {
            tabBarController = [[self alloc] initWithNibName:className bundle:[NSBundle mainBundle]];
        } else {
            tabBarController = [[self alloc] init];
        }
    }
    @catch (NSException *exception) {
        tabBarController = [[self alloc] init];
    }
    return tabBarController;
}

@end
