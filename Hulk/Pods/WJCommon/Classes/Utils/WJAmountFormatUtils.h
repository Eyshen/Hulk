//
//  WJAmountFormatUtils.h
//  WJCommon-master
//
//  Created by 吴云海 on 17/6/21.
//  Copyright © 2017年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJAmountFormatUtils : NSObject

//格式化金额字符串
+(NSString*)formatAmountStr:(NSString*)origNum;

//强制保留两位小数
+(NSString*)formatAmount2Decimal:(NSString*)origNum;

//无小数
+(NSString*)formatAmountNoDecimal:(NSString*)origNum;

@end
