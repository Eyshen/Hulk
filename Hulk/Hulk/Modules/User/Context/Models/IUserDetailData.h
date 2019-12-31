//
//  IUserDetailData.h
//  ios-jucaicat
//
//  Created by 吴云海 on 16/6/22.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  用户详情数据
 */
@protocol IUserDetailData <NSObject>

//手机号
-(NSString *)phoneNumber;

//身份证号码
-(NSString *)idNumber;

//真实姓名
-(NSString *)realName;

//邮箱
-(NSString *)emailDress;

@end
