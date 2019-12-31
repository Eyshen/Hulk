//
//  UserDetailHttpApi.m
//
//  Created by eason on 16/5/16.
//  Copyright © 2018年 zhangyi. All rights reserved.
//

#import "UserDetailHttpApi.h"
#import "UserContext.h"

@interface UserDetailHttpRequest ()

@end

@implementation UserDetailHttpRequest

#pragma mark Overridings
-(NSString*) getURL {
    return ZY_SERVER_FORMAT_API(@"queryUserDetail", ApiServerTC);
}

-(NSString *)getMethod {
    return HTTP_METHOD_POST;
}

@end

@implementation UserDetailHttpResponse

#pragma mark Overridings
+(id<IWJHttpResponse>)parseResult:(NSData*)responseData {
    UserDetailHttpResponse *res = nil;
#ifdef DEBUG
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    WJLogDebug(@"userDetailResponseData:%@",responseString);
#endif
    @try {
        res = [WJJSON fromJsonData:responseData type:[UserDetailHttpResponse class]];
    } @catch (NSException *exception) {
        res = [[UserDetailHttpResponse alloc] init];
        [res setRetMsg:JCC_HTTP_RES_DATA_ERROR_MSG];
    }
    return res;
}

@end



