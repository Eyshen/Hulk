//
//  AmountStrUtils.m
//  ios-jucaicat
//
//  Created by 吴云海 on 17/6/24.
//  Copyright © 2017年 wuyunhai. All rights reserved.
//

#import "AmountStrUtils.h"

@implementation AmountStrUtils

+(NSString *)formatAmountString:(int)num {
    double douNum=(double)num;
    if (douNum>=10000.0) {
        float fNum=douNum/10000.0;
        float d=fNum;
        int a= (int) d/1;
        if (d-a>0) {
            WJLogDebug(@"小数");
            return [NSString stringWithFormat:@"%.1f万",fNum];
        }else{
            WJLogDebug(@"整数");
            return [NSString stringWithFormat:@"%.0f万",fNum];
        }
    }else{
        return [NSString stringWithFormat:@"%.0f",douNum];
    }
    return nil;
}

+(NSString *)formatAmountString:(int)num  format:(NSString*)format baseNumber:(double)basenNumber{
    double douNum=(double)num;
    if (douNum>=basenNumber) {
        float fNum=douNum/basenNumber;
        float d=fNum;
        int a= (int) d/1;
        if (d-a>0) {
            WJLogDebug(@"小数");
            return [NSString stringWithFormat:@"%.1f%@",fNum,format];
        }else{
            WJLogDebug(@"整数");
            return [NSString stringWithFormat:@"%.0f%@",fNum,format];
        }
    }else{
        return [NSString stringWithFormat:@"%.0f",douNum];
    }
    return nil;
}

+(NSString *)formatAmountStringExpand:(int)num {
    double douNum=(double)num;
    if (douNum>=10000.0) {
        return [self formatAmountString:num format:@"万" baseNumber:10000.0];
    }else{
        return [WJAmountFormatUtils formatAmountStr:[NSString stringWithFormat:@"%.0f",douNum]];
    }
    return nil;
}


+(NSString *)notRounding:(float)price afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return [NSString stringWithFormat:@"%@",roundedOunces];
}
@end
