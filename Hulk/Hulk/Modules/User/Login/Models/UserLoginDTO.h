//
//  UserDetailDTO.h
//  Hulk
//
//  Created by 张学超 on 2018/11/1.
//  Copyright © 2018 张学超. All rights reserved.
//

#import "AppBaseDTO.h"
#import "ZYUserInfoVO.h"
#import "ILoginData.h"

@interface UserLoginDTO : AppBaseDTO<ILoginData>
/**
 *  手机号
 */
@property (nonatomic, copy) NSString *phoneNumber;

//accessToken
@property (nonatomic, copy) NSString *accessToken;

//用户码
@property (nonatomic, copy) NSString *userCode;

/**
 *  邮箱
 */
@property (nonatomic, copy) NSString *emailDress;

/**
 *  身份证号码
 */
@property (nonatomic, copy) NSString *idNumber;

/**
 *  用户真实姓名
 */
@property (nonatomic, copy) NSString *realName;

@end
