//
//  IconUrlUtils.m
//  ios-jucaicat
//
//  Created by 吴云海 on 17/7/10.
//  Copyright © 2017年 wuyunhai. All rights reserved.
//

#import "IconUrlUtils.h"

@implementation IconUrlUtils

+(NSString *)formatSuitableUrl:(NSString *)iconUrl {
    if (WJ_SCREEN_SCALE > 2 && WJ_STRING_IS_NOT_EMPTY(iconUrl)) {
        NSString *pathExtension = [NSString stringWithFormat:@".%@",[iconUrl pathExtension]];
        return [iconUrl stringByReplacingOccurrencesOfString:pathExtension withString:[NSString stringWithFormat:@"-x3%@",pathExtension]];
    }
    return iconUrl;
}

@end
