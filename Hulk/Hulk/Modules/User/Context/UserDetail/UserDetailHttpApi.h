//
//  UserDetailHttpApi.h
//
//
//  Created by eason on 16/5/16.
//  Copyright © 2018年 zhangyi. All rights reserved.
//

#import "AppBaseHttpRequest.h"
#import "AppBaseHttpResponse.h"
#import "ZYUserInfoVO.h"
#import "UserDetailDTO.h"


/**
 *  用户详情
 */
@interface UserDetailHttpRequest : AppBaseHttpRequest

@property(nonatomic, copy) NSString *userCode;

@end


/**
 *  用户详情响应
 */
@interface UserDetailHttpResponse : AppBaseHttpResponse

@property (nonatomic, copy) UserDetailDTO *data;

@end
