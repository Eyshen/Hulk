//
//  HttpUtils.m
//  ios-jucaicat
//
//  Created by 吴云海 on 17/7/12.
//  Copyright © 2017年 wuyunhai. All rights reserved.
//

#import "HttpUtils.h"


static NSArray *safeKeys = nil;

@implementation HttpUtils

+(void)load {
    safeKeys = @[@"real_name",
                 @"id_card_no",
                 @"bank_card_number",
                 @"trade_pwd",
                 @"phone_number"];
}

+(NSDictionary *)generateHeaders {
    NSMutableDictionary *headers = [[NSMutableDictionary alloc] initWithDictionary:@{}];
    return headers;
}

//生成带签名参数集合
+(NSDictionary *)generateSignParams:(NSDictionary *)params {
    /*
    if (USER_IS_LOGINED) {
        NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
        [result setObject:[self currentTimestamp] forKey:@"timestamp"];
        NSArray *keys = [params allKeys];
        for (NSString *k in keys) {
            if ([safeKeys containsObject:k]) {
                NSString *val = nil;
                id o = params[k];
                if ([o isKindOfClass:[NSString class]]) {
                    val = [self encryptAction:[o dataUsingEncoding:NSUTF8StringEncoding] key:USER_SECRET_KEY];
                } else {
                    val = [self encryptAction:[[NSString stringWithFormat:@"%@",o] dataUsingEncoding:NSUTF8StringEncoding] key:USER_SECRET_KEY];
                }
                if (val) {
                    [result setObject:val forKey:k];
                }
            } else {
                [result setObject:params[k] forKey:k];
            }
        }
        NSString *sign = [self generateSign:[result copy]];
        [result setObject:sign forKey:@"sign"];
        return result;
    }
     */
    return params;
}

+(NSString*)encryptAction:(NSData*)value key:(NSString*)key {
    NSData *data = data = WJ_SECURITY_DES_ENCRY(value, key);
    return [WJSecurityUtils base64:data];
}

+(NSString*)generateSign:(NSDictionary*)params {
    /*
    NSString *timestamp = params[@"timestamp"];
    NSArray *sortedKeys = [[params allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    NSMutableString *signContent = [[NSMutableString alloc] init];
    [signContent appendString:timestamp];
    for (int i=0; i<[sortedKeys count]; i++) {
        NSString *key = sortedKeys[i];
        [signContent appendString:key];
        id o = params[key];
        if ([o isKindOfClass:[NSString class]]) {
            [signContent appendString:o];
        } else {
            [signContent appendFormat:@"%@",o];
        }
    }
    [signContent appendString:timestamp];
    [signContent appendString:USER_SECRET_KEY];
    return WJ_SECURITY_HMACSHA256(signContent, USER_SECRET_KEY);
     */
    return @"";
}

+(NSString*)currentTimestamp {
    return [NSString stringWithFormat:@"%0.0f",[[NSDate date] timeIntervalSince1970] * 1000];
}

@end
