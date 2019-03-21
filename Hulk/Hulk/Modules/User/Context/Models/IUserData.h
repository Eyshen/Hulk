//
//  IUserData.h
//  Hulk
//
//  Created by 张学超 on 2018/10/31.
//  Copyright © 2018 张学超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ILoginData.h"
#import "IUserDetailData.h"
#import "IRealUserData.h"


@protocol IUserData <NSObject>

@property (nonatomic, assign, readonly) long serializationUserDataCounter;

//变更计数器
@property (nonatomic, assign, readonly) long changeCounter;

//操作token
-(NSString*)accessToken;

//手机号
-(NSString*)phoneNumber;

//身份证号
-(NSString*)idNumber;

//真实姓名
-(NSString*)realName;

//邮箱
-(NSString*)emailDress;

//用户码
-(NSString*)userCode;

//填充数据
-(void) fillLoginData: (id<ILoginData>) loginData;

//填充用户详情数据
-(void) fillUserDetailData: (id<IUserDetailData>) userDetailData;

//真实身份
-(void) fillRealUserData: (id<IRealUserData>) realUserData;
@end
