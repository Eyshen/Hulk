//
//  BaseWJHttpRequest.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/7/30.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import "BaseWJHttpRequest.h"
#import "WJHttpEngineConfig.h"

@implementation BaseWJHttpRequest

-(NSString*) getURL {
    return nil;
}

-(BOOL) validateParams {
    return YES;
}

-(NSDictionary*) getHeaders {
    return nil;
}

-(NSDictionary*) getParams {
    return nil;
}

-(NSData*) getBodyData {
    return nil;
}

-(NSString*) getMethod {
    return HTTP_METHOD_GET;
}

-(long) getTimeoutDuration {
    return [[WJHttpEngineConfig sharedInstance] defaultTimeoutDuration];
}

-(NSDictionary*) getUploadFiles {
    return nil;
}

-(BOOL) existUploadFile {
    if ([[self getUploadFiles] count] > 0) {
        return YES;
    }
    return NO;
}

-(BOOL)hideNetworkActivityIndicator {
    return [[WJHttpEngineConfig sharedInstance] defaultNetworkActivityEnabled];
}

@end
