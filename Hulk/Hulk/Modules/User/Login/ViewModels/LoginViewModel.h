//
//  LoginViewModel.h
//  Hulk
//
//  Created by 张学超 on 2018/11/1.
//  Copyright © 2018 张学超. All rights reserved.
//

#import "AppBaseViewModel.h"

@interface LoginViewModel : AppBaseViewModel

@property (nonatomic,copy)NSString *phoneNumber;

@property (nonatomic,copy)NSString *emailDress;

@property (nonatomic,assign) int loginType;

//下一步按钮是否可用  default NO
@property (nonatomic,assign) BOOL loginEnable;

//密码是否可见
@property (nonatomic,assign) BOOL isLook;

/**
 *  登录
 */
-(void)login:(NSString *) password resBlock:(void(^)(NSString *errMsg)) block;

-(void) changePwdText:(NSString *) text;

-(void)changePwdLook;

@end
