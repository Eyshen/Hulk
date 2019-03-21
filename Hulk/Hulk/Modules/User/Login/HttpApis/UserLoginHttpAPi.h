//
//  UserLoginHttpAPi.h
//  Hulk
//
//  Created by 张学超 on 2018/11/1.
//  Copyright © 2018 张学超. All rights reserved.
//

#import "AppBaseHttpRequest.h"
#import "AppBaseHttpResponse.h"
#import "ZYUserInfoVO.h"
#import "UserLoginDTO.h"

//用户详情
@interface UserLoginHttpRequest : AppBaseHttpRequest

@property (nonatomic, copy) NSString *userCode;

@end

//用户详情响应
@interface UserLoginHttpResponse: AppBaseHttpResponse

@property (nonatomic, copy) UserLoginDTO *data;

@end
