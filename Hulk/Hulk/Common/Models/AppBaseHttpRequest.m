//
//  AppBaseHttpRequest.m
//  Hulk
//
//  Created by zhangyi on 16/4/21.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "AppBaseHttpRequest.h"


@implementation AppBaseHttpRequest

-(NSDictionary *)getHeaders{
//    return [HttpUtils generateHeaders];
    return nil;
}

-(NSString *)getMethod {
    return HTTP_METHOD_POST;
}

-(BOOL)validateParams {
    return YES;
}

-(void)formatError:(NSError *__autoreleasing *)error reason:(NSString *)reason {
    if (error != NULL && reason) {
        *error = [NSError errorWithDomain:@"HttpApiParamsError" code:-1200 userInfo:@{NSLocalizedDescriptionKey:reason}];
    }
}

@end
