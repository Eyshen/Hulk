//
//  ServerContext.m
//  Hulk
//
//  Created by 张一 on 17/5/23.
//  Copyright © 2017年 eason. All rights reserved.
//

#import "ServerContext.h"
#import "WJCacheFactory.h"
#import "WJCacheType.h"

#define JCC_CURRENT_SERVERS_CACHE_KEY   @"JCC_CURRENT_SERVERS_CACHE_KEY"
#define JCC_DEBUG_SERVERS_CACHE_KEY     @"JCC_DEBUG_SERVERS_CACHE_KEY"

@interface ServerContext ()

@property(nonatomic, strong) NSMutableDictionary *currentServers;

#ifdef DEBUG
@property(nonatomic, strong) NSMutableDictionary *debugServers;
@property(nonatomic, weak) id<IWJCache> userDefaultCache;
#endif

@end

@implementation ServerContext

DEF_SINGLETON_INIT(JccUserContext)

- (void)singleInit {
    self.currentServers = [[NSMutableDictionary alloc] init];
    [_currentServers setObject:API_RELEASE_SERVER_TC_DOMAIN forKey:[NSString stringWithFormat:@"%li", (long)ApiServerTC]];
    [_currentServers setObject:API_RELEASE_SERVER_ACT_DOMAIN forKey:[NSString stringWithFormat:@"%li", (long)ApiServerACT]];
    
#ifdef DEBUG
    self.debugServers = [[NSMutableDictionary alloc] init];
    self.userDefaultCache = WJ_CACHE_OBJECT(WJCacheTypeUserDefaults);
    NSData *cacheCurrentServersJsonData = [_userDefaultCache dataForKey:JCC_CURRENT_SERVERS_CACHE_KEY];
    id cacheCurrentServers = nil;
    if (cacheCurrentServersJsonData) {
        cacheCurrentServers = [WJJSON fromJsonData:cacheCurrentServersJsonData];
    }
    
    if (cacheCurrentServers && [cacheCurrentServers isKindOfClass:[NSDictionary class]]) {
        [_currentServers addEntriesFromDictionary:cacheCurrentServers];
    }
    
    NSData *cacheDebugServersJsonData = [_userDefaultCache dataForKey:JCC_DEBUG_SERVERS_CACHE_KEY];
    id cacheDebugServers = nil;
    if (cacheDebugServersJsonData) {
        cacheDebugServers = [WJJSON fromJsonData:cacheDebugServersJsonData];
    }
    if (cacheDebugServers && [cacheDebugServers isKindOfClass:[NSDictionary class]]) {
        NSEnumerator *enumerator = [(NSDictionary*)cacheDebugServers keyEnumerator];
        id k;
        while (k = [enumerator nextObject]) {
            id o = cacheDebugServers[k];
            if ([o isKindOfClass:[NSArray class]]) {
                NSMutableArray *v = [[NSMutableArray alloc] initWithArray:o];
                [_debugServers setObject:v forKey:k];
            }
        }
    } else {
        NSMutableArray *tcServers = [[NSMutableArray alloc] init];
        [tcServers addObject:API_RELEASE_SERVER_TC_DOMAIN];
        //添加debug TC 服务环境
        [_debugServers setObject:tcServers forKey:[NSString stringWithFormat:@"%li", (long)ApiServerTC]];
        
        NSMutableArray *actServers = [[NSMutableArray alloc] init];
        [actServers addObject:API_RELEASE_SERVER_ACT_DOMAIN];
        //添加debug ACT 服务环境
        [_debugServers setObject:actServers forKey:[NSString stringWithFormat:@"%li", (long)ApiServerACT]];
        [self.userDefaultCache setData:[WJJSON toJson:_debugServers] forKey:JCC_DEBUG_SERVERS_CACHE_KEY];
    }
#endif
}




- (NSString *)format:(NSString *)apiName server:(ApiServer)server {
    NSString *result = nil;
    NSString *apiDomain = [_currentServers objectForKey:[NSString stringWithFormat:@"%li", (long)server]];
    if ([apiDomain hasSuffix:@"/"]) {
        if ([apiName hasPrefix:@"/"]) {
            result = [NSString stringWithFormat:@"%@%@", apiDomain, [apiName substringFromIndex:1]];
        } else {
            result = [NSString stringWithFormat:@"%@%@", apiDomain, apiName];
        }
    } else {
        if ([apiName hasPrefix:@"/"]) {
            result = [NSString stringWithFormat:@"%@%@", apiDomain, apiName];
        } else {
            result = [NSString stringWithFormat:@"%@/%@", apiDomain, apiName];
        }
    }
    return result;
}

- (NSString *)currentApiPrefix:(ApiServer)server {
    return [_currentServers objectForKey:[NSString stringWithFormat:@"%li", (long)server]];
}

- (void)removeApiServer:(NSString *)apiServerPrefix server:(ApiServer)server {
#ifdef DEBUG
    NSString *serverKey = [NSString stringWithFormat:@"%li", (long)server];
    if (WJ_STRING_EQUAL(apiServerPrefix, [_currentServers objectForKey:serverKey])) {
        return;
    }
    NSMutableArray *prefixs = [_debugServers objectForKey:serverKey];
    if ([prefixs containsObject:apiServerPrefix]) {
        [prefixs removeObject:apiServerPrefix];
        
        [_userDefaultCache setData:[WJJSON toJson:_debugServers] forKey:JCC_DEBUG_SERVERS_CACHE_KEY];
        [self performSelectorOnMainThread:@selector(incrCounter) withObject:nil waitUntilDone:NO];
    }
#endif
}


-(void)incrCounter {
    self.changeCounter = _changeCounter + 1;
}


- (void)chooseApiServer:(NSString *)apiServerPrefix server:(ApiServer)server {
#ifdef DEBUG
    NSString *serverKey = [NSString stringWithFormat:@"%li", (long)server];
    NSString *oldApiServerPrefix = [_currentServers objectForKey:serverKey];
    NSMutableArray *apiServerPrefixs = [_debugServers objectForKey:serverKey];
    if (!WJ_STRING_EQUAL(apiServerPrefix, oldApiServerPrefix) && [apiServerPrefixs containsObject:apiServerPrefix]) {
        [_currentServers setObject:apiServerPrefix forKey:serverKey];
        
        [_userDefaultCache setData:[WJJSON toJson:_currentServers] forKey:JCC_CURRENT_SERVERS_CACHE_KEY];
        [self performSelectorOnMainThread:@selector(incrCounter) withObject:nil waitUntilDone:NO];
    }
#endif
}

- (BOOL)addApiServer:(NSString *)apiServerPrefix server:(ApiServer)server {
#ifdef DEBUG
    NSMutableArray *prefixs = [_debugServers objectForKey:[NSString stringWithFormat:@"%li", (long)server]];
    if (![prefixs containsObject:apiServerPrefix]) {
        [prefixs addObject:apiServerPrefix];
        
        [_userDefaultCache setData:[WJJSON toJson:_debugServers] forKey:JCC_DEBUG_SERVERS_CACHE_KEY];
        [self performSelectorOnMainThread:@selector(incrCounter) withObject:nil waitUntilDone:NO];
        return YES;
    }
    return NO;
#endif
    return NO;
}

- (NSDictionary *)getDebugServers {
#ifdef DEBUG
    return _debugServers;
#endif
    return nil;
}

- (NSDictionary *)getCurrentServers {
#ifdef DEBUG
    return _currentServers;
#endif
    return nil;
}

@end
