//
//  LoginViewModel.m
//  Hulk
//
//  Created by 张学超 on 2018/11/1.
//  Copyright © 2018 张学超. All rights reserved.
//

#import "LoginViewModel.h"
#import "WJHttpFactory.h"
#import "WJCacheAPI.h"
#import "UserContext.h"
#import "UserLoginHttpAPi.h"

@interface LoginViewModel ()

@property (nonatomic, strong) id<IWJHttpEngine> httpEngine;

@end

@implementation LoginViewModel

-(instancetype)init{
    self = [super init];
    if (self) {
        self.httpEngine = [WJHttpFactory buildHttpEngine];
    }
    return self;
}

-(void)changePwdText:(NSString *)text{
    self.loginEnable = ([text length] >= 6);
}

-(void)changePwdLook{
    self.isLook = !_isLook;
}

-(void)login:(NSString *)password resBlock:(void (^)(NSString *))block{
    if(![_httpEngine hasLoading]){
        UserLoginHttpRequest *request = [[UserLoginHttpRequest alloc] init];
        [_httpEngine asynRequest:request responseClass:[UserLoginHttpResponse class] responseBlock:^(id<IWJHttpResponse> res, NSError *error) {
            if(error){
                block([error userInfo][NSLocalizedDescriptionKey]);
            } else {
                if([res isError]){
                    block([res errorMsg]);
                }else{
                    UserLoginHttpResponse *response = (UserLoginHttpResponse *)res;
                    UserLoginDTO *userLoginDto = [response data];
                    [[UserContext sharedInstance] logined:userLoginDto];
                    //获取用户详情
                    block(nil);
                }
            }
        }];
    }
}
@end
