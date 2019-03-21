//
//  AmountStrUtils.h
//  ios-jucaicat
//
//  Created by 吴云海 on 17/6/24.
//  Copyright © 2017年 wuyunhai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AmountStrUtils : NSObject

//格式化金额字符串
+(NSString*)formatAmountString:(int)amount;

//格式化金额字符串扩展
+(NSString *)formatAmountStringExpand:(int)num ;

//截取金额
+(NSString *)notRounding:(float)price afterPoint:(int)position;

@end
