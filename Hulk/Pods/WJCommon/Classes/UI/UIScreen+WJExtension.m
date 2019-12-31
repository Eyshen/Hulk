//
//  UIScreen+WJE.m
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

#import "UIScreen+WJExtension.h"

@implementation UIScreen (WJExtension)

+(CGRect) bounds {
    return [[UIScreen mainScreen] bounds];
}

+(CGRect) applicationFrame {
    return [[UIScreen mainScreen] applicationFrame];
}

+(CGFloat) width {
    return [[UIScreen mainScreen] bounds].size.width;
}

+(CGFloat) height {
    return [[UIScreen mainScreen] bounds].size.height;
}

+(CGFloat) scale {
    return [[UIScreen mainScreen] scale];
}

+(CGSize) size {
    return [[UIScreen mainScreen] bounds].size;
}

@end
