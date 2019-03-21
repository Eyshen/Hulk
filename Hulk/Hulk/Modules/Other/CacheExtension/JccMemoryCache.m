//
//  JccMemoryCache.m
//  ios-jucaicat
//
//  Created by 吴云海 on 16/9/28.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "JccMemoryCache.h"
#import "JccCacheType.h"
#import "YYMemoryCache.h"


@interface JccMemoryCache ()

@property(nonatomic, strong) YYMemoryCache *cache;

@end

@implementation JccMemoryCache

DEF_SINGLETON_INIT(JccMemoryCache)
 
-(void) singleInit {
    //单利初始化
    self.cache = [[YYMemoryCache alloc] init];
}


#pragma MARK IWJCache
- (BOOL)hasObjectForKey:(NSString*)key {
    if (key) {
        return [_cache containsObjectForKey:key];
    }
    return NO;
}

- (BOOL)boolForKey:(NSString*)key {
    if (key) {
        id val = [_cache objectForKey:key];
        if ([val isKindOfClass:[NSNumber class]]) {
            return [val boolValue];
        }
    }
    return NO;
}

- (void)setBool:(BOOL)value forKey:(NSString*)key {
    if (key) {
        [_cache setObject:@(value) forKey:key];
    }
}

- (NSString*)stringForKey:(NSString*)key {
    if (key) {
        id value = [_cache objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            return value;
        }
    }
    return nil;
}

- (void)setString:(NSString*)value forKey:(NSString*)key {
    if (value && key) {
        [_cache setObject:value forKey:key];
    }
}

- (NSData*)dataForKey:(NSString*)key {
    if (key) {
        id value = [_cache objectForKey:key];
        if ([value isKindOfClass:[NSData class]]) {
            return value;
        }
    }
    return nil;
}

- (void)setData:(NSData*)data forKey:(NSString*)key {
    if (data && key) {
        [_cache setObject:data forKey:key];
    }
}


- (id<NSCoding>)objectForKey:(NSString*)key {
    if (key) {
        return [_cache objectForKey:key];
    }
    return nil;
}

- (void)setObject:(id<NSCoding>)object forKey:(NSString*)key {
    if (object && key) {
        [self.cache setObject:object forKey:key];
    }
}

- (void)removeObjectForKey:(NSString*)key {
    if (key) {
        [_cache removeObjectForKey:key];
    }
}

- (void)removeAllObjects {
    [_cache removeAllObjects];
}

-(NSInteger)cacheType {
    return JccCacheTypeMemory;
}

+(id<IWJCache>)getInstance {
    return [JccMemoryCache sharedInstance];
}


@end
