//
//  UIDevice+WJUDID.m
//  Hulk
//
//  Created by zhangyi on 16/5/10.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "UIDevice+WJUDID.h"
#import <AdSupport/ASIdentifierManager.h>

@implementation UIDevice (WJUDID)

+(NSString *)currentUDID {
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}



@end
