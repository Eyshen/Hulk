//
//  UserContext.m
//  Hulk
//
//  Created by 张学超 on 2018/10/31.
//  Copyright © 2018 张学超. All rights reserved.
//

#import "UserContext.h"
#import "WJSession.h"
#import "WJHttpFactory.h"
#import "WJCacheAPI.h"
#import "UserTokenVO.h"
#import "ZYUserInfoVO.h"
#import "WJNetworkContext.h"
#import "UserDetailHttpApi.h"

#define ZY_STORE_USER_INFO_KEY   @"appUserInfokey"

#define ZY_USER_DETAIL_SYNC_INTERVAL   60*3

@interface UserContext ()

/**
 *  用户信息
 */
@property (nonatomic, copy) ZYUserInfoVO *currentUserInfo;

/**
 *  最后同步用户详情数据时间
 */
@property (nonatomic, assign) NSTimeInterval lastSyncUserDetailTime;

@property (nonatomic, strong) id<IWJHttpEngine> httpEngine,syncIntegralHttpEngine;

@property (nonatomic, weak) id<IWJCache> cache;

@end

@implementation UserContext

DEF_SINGLETON_INIT(UserContext)

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)handleNetworkContextNotification:(NSNotification*)notification{
    if([[WJNetworkContext sharedInstance] isConnection]){
        WJ_WEAK_REF_TYPE weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf syncUserDetail:YES];
        });
    }
}

-(void) singleInit {
    self.lastSyncUserDetailTime = 0.0f;
    self.cache = WJ_CACHE_OBJECT(WJCacheTypeKeychain);
    //注册用户登录和注销通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUserChangeNotification:) name:UserLogoutNotification object:[WJSession sharedInstance]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUserChangeNotification:) name:UserLoginedNotification object:[WJSession sharedInstance]];
    [[WJNetworkContext sharedInstance] addNotification:self selector:@selector(handleNetworkContextNotification:)];
    
    //获取用户信息数据
    NSData *data = [self.cache dataForKey:ZY_STORE_USER_INFO_KEY];
    if(data) {
        ZYUserInfoVO *userInfo = nil;
        @try {
            userInfo = [WJJSON fromJsonData:data type:[ZYUserInfoVO class]];
        }@catch (NSException *exception){
            userInfo = nil;
        }
        if(WJ_STRING_EQUAL(userInfo.userCode, [[[WJSession sharedInstance] getToken] currentUid])){
            self.currentUserInfo = userInfo;
        } else {
            [self.cache removeObjectForKey:ZY_STORE_USER_INFO_KEY];
        }
    }
    
    if([self isLogined] && !data){
        [self logout];
    }

    if(!_currentUserInfo){
        self.currentUserInfo = [[ZYUserInfoVO alloc] init];
    }
    self.httpEngine = [WJHttpFactory buildHttpEngine];
    self.syncIntegralHttpEngine = [WJHttpFactory buildHttpEngine];
    
    WJ_WEAK_REF_TYPE weakSelf = self;
    
    [self.KVOController observe:_currentUserInfo keyPath:@"serializationUserDataCounter" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        [weakSelf saveUserInfo];
    }];
}

-(BOOL)isLogined{
    return [[WJSession sharedInstance] isLogined];
}

-(void)logout{
    [[WJSession sharedInstance] logout];
}

-(void)logined:(id<ILoginData>)loginData{
    if([self isLogined] && loginData){
        [self logout];
    }
    //只有用户在未登录状态下才可以登录
    if(![self isLogined] && loginData){
        [self.userInfo fillLoginData:loginData];
        UserTokenVO * token = [[UserTokenVO alloc] init];
        [token setUserCode:[loginData userCode]];
        [token setUserToken:[loginData accessToken]];
        [[WJSession sharedInstance] logined:token];
    }
}

-(id<IUserData>)userInfo{
    return _currentUserInfo;
}

-(void)syncUserDetail:(BOOL)force{
    if(USER_IS_LOGINED && ![_httpEngine hasLoading]){
        if(!force){
            //对比时间(大于多久时间间隔才可以同步)
            if([[NSDate date] timeIntervalSince1970] - _lastSyncUserDetailTime < ZY_USER_DETAIL_SYNC_INTERVAL){
                return;
            }
        }
        WJ_WEAK_REF_TYPE  weakSelf = self;
        UserDetailHttpRequest *request = [[UserDetailHttpRequest alloc] init];
        [request setUserCode:@"Helloworld"];
        [_httpEngine asynRequest:request responseClass:[UserDetailHttpResponse class] responseBlock:^(id<IWJHttpResponse> res, NSError *error) {
            if(error){
                WJLogDebug(@"同步用户详情发生错误:%@",[error localizedDescription]);
            }else if ([res isError]){
                WJLogDebug(@"同步用户详情失败:%@ %@",[res errorCode], [res errorMsg]);
            }else{
                WJLogDebug(@"同步数据详情成功");
                if(WJ_STRING_EQUAL([request userCode],USER_CODE)){
                    UserDetailDTO *userInfoDTO = [(UserDetailHttpResponse *)res data];
                    [weakSelf.userInfo fillUserDetailData:userInfoDTO];
                    WJLogDebug(@"用户详情数据: %@",userInfoDTO);
                    weakSelf.lastSyncUserDetailTime = [[NSDate date] timeIntervalSince1970];
                }
            }
        }];
    }
}

-(void) saveUserInfo {
    if ([self isLogined]){
        NSData *data = nil;
        @try {
            data = [WJJSON toJson:_currentUserInfo];
        } @catch (NSException *exception){
            data = nil;
        }
        if(data){
            [self.cache setData:data forKey:ZY_STORE_USER_INFO_KEY];
        }
    }
}

/**
 *  处理用户变更通知
 */
-(void) handleUserChangeNotification:(NSNotification *) notification{
    if ([self isLogined]){
        //同步用户详情
        WJ_WEAK_REF_TYPE weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf syncUserDetail:YES];
        });
    }else{
        self.lastSyncUserDetailTime = 0.0f;
        [self.cache removeObjectForKey:ZY_STORE_USER_INFO_KEY];
        [self.currentUserInfo cleanData];
    }
}

@end
