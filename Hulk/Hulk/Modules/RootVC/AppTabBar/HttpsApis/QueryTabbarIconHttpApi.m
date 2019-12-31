//
//  QueryTabbarIconHttpApi.m
//
//  Created by 吴云海 on 17/6/7.
//  Copyright © 2017年 wuyunhai. All rights reserved.
//

#import "QueryTabbarIconHttpApi.h"

@implementation QueryTabbarIconHttpRequest

#pragma mark Overridings
-(NSString*) getURL {
    return ZY_SERVER_FORMAT_API(@"queryTabbarIcons", ApiServerTC);
}

-(NSString *)getMethod {
    return HTTP_METHOD_POST;
}

-(NSDictionary *)getParams {
    return [HttpUtils generateSignParams:@{@"change_tag":@(_changeTag)}];
}

@end


@implementation QueryTabbarIconHttpResponse

#pragma mark Overridings
+(id<IWJHttpResponse>)parseResult:(NSData*)responseData {
    QueryTabbarIconHttpResponse *res=nil;
#ifdef DEBUG
    NSString *resString=[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
    WJLogDebug(@"%@",resString);
#endif
    @try {
        res=[WJJSON fromJsonData:responseData type:[QueryTabbarIconHttpResponse class]];
    } @catch (NSException *exception) {
        res=[[QueryTabbarIconHttpResponse alloc]init];
        [res setRetMsg:@"请检查网络是否已连接~"];
    }
    return res;
}

@end



