//
//  JccUserInfoVO.h
//  ios-jucaicat
//
//  Created by wuyunhai on 16/5/16.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import <WJCommon/WJCommon.h>
#import "AppBaseVO.h"
#import "IUserData.h"

/**
 *  用户信息（不包含token信息）
 */

@interface ZYUserInfoVO : AppBaseVO<IUserData>

@property(nonatomic, assign, readonly) long serializationUserDataCounter;

@property(nonatomic, assign, readonly) long changeCounter;

@property(nonatomic, copy) NSString *phoneNumber;

@property(nonatomic, copy) NSString *idNumber;

@property(nonatomic, copy) NSString *realName;

@property(nonatomic, copy) NSString *userCode;

@property(nonatomic, copy) NSString *emailDress;

/**
 *  清空数据
 */
-(void)cleanData;


@end
