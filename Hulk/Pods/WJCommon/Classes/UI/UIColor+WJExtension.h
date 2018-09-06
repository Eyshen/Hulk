//
//  UIColor+WJExtension.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by 吴云海 on 16-2-27.
//  Copyright (c) 2016年 WJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WJ_COLOR_RGBA(r,g,b,a)              ([UIColor wj_colorWithRed:r green:g blue:b alpha:a])
#define WJ_COLOR_HEX(hex)                   ([UIColor wj_colorWithHex:hex])
#define WJ_COLOR_HEX_STRING(hexString)      ([UIColor wj_colorWithHexString:hexString])

@interface UIColor (WJExtension)

+(UIColor*) wj_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

+(UIColor*) wj_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

//0x66377A
+(UIColor*) wj_colorWithHex:(int) hex;

//支持 @“#123456”、 @“0X123456”、 @“123456” 格式
+(UIColor*) wj_colorWithHexString:(NSString*) hexString;

@end
