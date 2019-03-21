//
//  H5ConfigAPI.m
//  ios-jucaicat
//
//  Created by 张大宗 on 16/8/12.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "FetchH5ConfigAPI.h"

@implementation FetchH5ConfigRequest

#pragma mark Overridings
-(NSString*) getURL {
    return ZY_SERVER_FORMAT_API(@"queryH5Config", ApiServerTC);
}

-(NSString*) getMethod {
    return HTTP_METHOD_POST;
}

-(NSDictionary *)getParams {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:WJ_APPLICATION_SHORT_VERSION forKey:@"app_version_h5"];
    [params setObject:@(_lastUpdateTime) forKey:@"lastUpdateTime"];
    return [HttpUtils generateSignParams:params];
}

@end

@implementation FetchH5ConfigResDTO

+(NSDictionary *)wjContainerPropertysGenericClass {
    return @{@"h5PageDataList":[H5ConfigDTO class]};
}

@end


@implementation FetchH5ConfigResponse

#pragma mark Overridings
+(id<IWJHttpResponse>)parseResult:(NSData*)responseData {
    FetchH5ConfigResponse *res = nil;
#ifdef DEBUG
    NSString *resString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    WJLogDebug(@"%@",resString);
#endif
    @try {
        res = [WJJSON fromJsonData:responseData type:[FetchH5ConfigResponse class]];
    } @catch (NSException *exception) {
        res = [[FetchH5ConfigResponse alloc] init];
        [res setRetMsg:JCC_HTTP_RES_DATA_ERROR_MSG];
    }
    return res;
}

@end
