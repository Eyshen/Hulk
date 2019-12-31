//
//  ServerContext.h
//  Hulk
//
//  Created by 张一 on 17/5/23.
//  Copyright © 2017年 wuyunhai. All rights reserved.
//

#import <WJCommon/WJCommon.h>
#import "WJSingleton.h"


typedef NS_ENUM(NSInteger, ApiServer) {
    
    //服务
    ApiServerTC = 0,
    
    //活动
    ApiServerACT = 1,
    
};

#define ZY_SERVER_FORMAT_API(A, S)  [[ServerContext sharedInstance] format:A server:S]
#define ZY_SERVER_CURRENT_API(A)    [[ServerContext sharedInstance] currentApiPrefix:A]

@interface ServerContext : AbstractWJBusinessObject


AS_SINGLETON(JccUserContext)

@property(nonatomic, assign) long changeCounter;

//格式化
- (NSString*)format:(NSString*)apiName server:(ApiServer)server;

//当前api前缀
- (NSString*)currentApiPrefix:(ApiServer)server;

//删除
- (void)removeApiServer:(NSString*)apiServerPrefix server:(ApiServer)server;

//切换
- (void)chooseApiServer:(NSString*)apiServerPrefix server:(ApiServer)server;

//添加
- (BOOL)addApiServer:(NSString*)apiServerPrefix server:(ApiServer)server;

//当前服务环境列表
- (NSDictionary*)getCurrentServers;

//当前debug 环境列表
- (NSDictionary*)getDebugServers;


@end
