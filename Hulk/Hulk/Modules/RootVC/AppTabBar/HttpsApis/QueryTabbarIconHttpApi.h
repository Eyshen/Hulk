//
//  QueryTabbarIconHttpApi.h
//
//
//  Created by 吴云海 on 17/6/7.
//  Copyright © 2017年 wuyunhai. All rights reserved.
//

#import "AppBaseHttpRequest.h"
#import "AppBaseHttpResponse.h"
#import "QueryTabbarIconResDTO.h"

@interface QueryTabbarIconHttpRequest : AppBaseHttpRequest

@property(nonatomic, assign) int changeTag;

@end


@interface QueryTabbarIconHttpResponse : AppBaseHttpResponse

@property(nonatomic, copy) QueryTabbarIconResDTO *data;

@end
