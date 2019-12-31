//
//  IUserTrueIdentityData.h
//  ios-jucaicat
//
//  Created by 吴云海 on 16/6/27.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  用户真实身份数据
 */
@protocol IRealUserData <NSObject>

/**
 *  真实姓名
 */
-(NSString*) realName;

/**
 *  身份证号码
 */
-(NSString*) idNumber;

@end
