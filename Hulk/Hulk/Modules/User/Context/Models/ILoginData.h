//
//  ILoginData.h
//  Hulk
//
//  Created by 张学超 on 2018/10/31.
//  Copyright © 2018 张学超. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  用户登录数据
 */
@protocol ILoginData <NSObject>

//手机号
-(NSString *)phoneNumber;

//accessToken
-(NSString *)accessToken;

//身份证号码
-(NSString *)idNumber;

//真实姓名
-(NSString *)realName;

//邮箱
-(NSString *)emailDress;

//用户码
-(NSString *)userCode;

@end
