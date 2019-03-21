//
//  UserContext.h
//  Hulk
//
//  Created by 张学超 on 2018/10/31.
//  Copyright © 2018 张学超. All rights reserved.
//

#import "AbstractWJBusinessObject.h"
#import "WJSingleton.h"
#import "ILoginData.h"
#import "IUserData.h"


#define USER_TOKEN                  ([[[UserContext sharedInstance] userInfo] accessToken])
#define USER_CODE                   ([[[UserContext sharedInstance] userInfo] userCode])
#define USER_IS_LOGINED             ([[UserContext sharedInstance] isLogined])
#define USER_REAL_NAME              ([[[UserContext sharedInstance] userInfo] realName])
#define USER_IDENTITY_NUMBER        ([[[UserContext sharedInstance] userInfo] idNumber])
#define USER_PHONE_NUMBER           ([[[UserContext sharedInstance] userInfo] phoneNumber])
#define USER_EMAIL_DRESS            ([[[UserContext sharedInstance] userInfo] emailDress])

@interface UserContext : AbstractWJBusinessObject

AS_SINGLETON(UserContext)

/**
 *  用户是否登录
 */
-(BOOL) isLogined;

/**
 *  注销用户
 */
-(void) logout;

/**
 *  登录
 */
-(void) logined:(id<ILoginData>) loginData;

/**
 *  用户信息(如果用户未登录,返回nil)
 */
-(id<IUserData>) userInfo;

/***
 *  同步用户详情信息
 *
 *  @param force 是否强制同步
 */
-(void)syncUserDetail:(BOOL)force;

@end
