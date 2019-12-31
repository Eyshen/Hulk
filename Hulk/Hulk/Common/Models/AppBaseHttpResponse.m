//
//  AppBaseHttpResponse.m
//  Hulk
//
//  Created by zhangyi on 16/4/21.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "AppBaseHttpResponse.h"

@implementation AppBaseHttpResponse


-(NSString *)errorCode {
    return _retCode;
}

-(NSString *)errorMsg {
    return _retMsg;
}

#pragma mark Override
-(BOOL)isError {
    if ([_retCode integerValue] > 0) {
        return NO;
    }
    return YES;
}

@end
