//
//  AppBaseHttpRequest.h
//  Hulk
//
//  Created by zhangyi on 16/4/21.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "BaseWJHttpRequest.h"
//#import "HttpUtils.h"

/**
 *  http 请求基类
 */
@interface AppBaseHttpRequest : BaseWJHttpRequest



-(void)formatError:(NSError **)error reason:(NSString*)reason;

@end
