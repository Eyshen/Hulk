//
//  WJAmountFormatUtils.m
//  WJCommon-master
//
//  Created by 吴云海 on 17/6/21.
//  Copyright © 2017年 WJ. All rights reserved.
//

#import "WJAmountFormatUtils.h"

@implementation WJAmountFormatUtils

+(NSString *)formatAmountStr:(NSString *)origNum {
    if (origNum) {
        NSRange range = [origNum rangeOfString:@"." options:NSCaseInsensitiveSearch];
        if (range.location != NSNotFound) {
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            [formatter setPositiveFormat:@"###,##0.00;"];
            NSDecimalNumber *decimalNumber = [NSDecimalNumber decimalNumberWithString:origNum];
            return [formatter stringFromNumber:decimalNumber];
        } else {
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            formatter.numberStyle = NSNumberFormatterDecimalStyle;
            NSNumber *orginalNum = [NSNumber numberWithLongLong:[origNum longLongValue]];
            NSString *string = [formatter stringFromNumber:orginalNum];
            return string;
        }
    }
    return origNum;
}

+(NSString*)formatAmount2Decimal:(NSString*)origNum {
    if (origNum) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setPositiveFormat:@"###,##0.00;"];
        NSDecimalNumber *decimalNumber = [NSDecimalNumber decimalNumberWithString:origNum];
        return [formatter stringFromNumber:decimalNumber];
    }
    return origNum;
}

//无小数
+(NSString*)formatAmountNoDecimal:(NSString*)origNum {
    if (origNum) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setPositiveFormat:@"###,##0;"];
        NSDecimalNumber *decimalNumber = [NSDecimalNumber decimalNumberWithString:origNum];
        return [formatter stringFromNumber:decimalNumber];
    }
    return origNum;
}

@end
