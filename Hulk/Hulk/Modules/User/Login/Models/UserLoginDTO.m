//
//  UserDetailDTO.m
//  Hulk
//
//  Created by 张学超 on 2018/11/1.
//  Copyright © 2018 张学超. All rights reserved.
//

#import "UserLoginDTO.h"

@implementation UserLoginDTO

//手机号
-(NSString *)phoneNumber{
    return _phoneNumber?:@"";
}

//身份证号码
-(NSString *)idNumber{
    return _idNumber?:@"";
}

//真实姓名
-(NSString *)realName{
    return _realName?:@"";
}

//邮箱
-(NSString *)emailDress{
    return _emailDress?:@"";
}

//accessToken
-(NSString *)accessToken{
    return _accessToken?:@"";
}

//用户码
-(NSString *)userCode{
    return _userCode?:@"";
}


@end
