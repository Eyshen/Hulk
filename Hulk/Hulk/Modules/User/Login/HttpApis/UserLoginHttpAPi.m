//
//  UserLoginHttpAPi.m
//  Hulk
//
//  Created by 张学超 on 2018/11/1.
//  Copyright © 2018 张学超. All rights reserved.
//

#import "UserLoginHttpAPi.h"

@implementation UserLoginHttpRequest
#pragma mark Overridings
-(NSString *)getURL{
    return ZY_SERVER_FORMAT_API(@"user/login", ApiServerTC);
}

-(NSString *)getMethod{
    return HTTP_METHOD_POST;
}

@end

@implementation UserLoginHttpResponse

#pragma mark Overridings
+(id<IWJHttpResponse>)parseResult:(NSData *)responseData{
    UserLoginHttpResponse *res = nil;
#ifdef DEUBG
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    WJLogDebug(@"userLoginResponseData:%@",responseString);
#endif
    @try {
        res = [WJJSON fromJsonData:responseData type:[UserLoginHttpResponse class]];
    } @catch (NSException *exception){
        res = [[UserLoginHttpResponse alloc] init];
        [res setRetMsg:JCC_HTTP_RES_DATA_ERROR_MSG];
    }
    return res;
}

@end
