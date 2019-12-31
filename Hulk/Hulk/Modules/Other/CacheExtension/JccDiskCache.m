//
//  JccDiskCache.m
//  ios-jucaicat
//
//  Created by 吴云海 on 16/9/28.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "JccDiskCache.h"
#import "JccCacheType.h"
#import "YYDiskCache.h"

#define JCC_CACHE_DISK_FILE_NAME @"jcc-disk-cache-data"

@interface JccDiskCache ()

@property(nonatomic, strong) dispatch_queue_t access_queue;

@property(nonatomic, strong) YYDiskCache *cache;

@end

@implementation JccDiskCache


DEF_SINGLETON_INIT(JccDiskCache)
 
-(void) singleInit {
    //单利初始化
    self.access_queue = dispatch_queue_create("com.jucaicat.cache.disk.queue", NULL);
    NSString *filePath = [WJ_FILE_DIR_CACHE stringByAppendingPathComponent:JCC_CACHE_DISK_FILE_NAME];
    self.cache = [[YYDiskCache alloc] initWithPath:filePath];
    
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
    WJ_WEAK_REF_TYPE weakSelf = self;
    if (key) {
        dispatch_async(_access_queue, ^{
            [weakSelf.cache setObject:@(value) forKey:key];
        });
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
        WJ_WEAK_REF_TYPE weakSelf = self;
        dispatch_async(_access_queue, ^{
            [weakSelf.cache setObject:value forKey:key];
        });
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
        WJ_WEAK_REF_TYPE weakSelf = self;
        dispatch_async(_access_queue, ^{
            [weakSelf.cache setObject:data forKey:key];
        });
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
        dispatch_async(_access_queue, ^{
            [self.cache setObject:object forKey:key];
        });
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
    return JccCacheTypeDisk;
}

+(id<IWJCache>)getInstance {
    return [JccDiskCache sharedInstance];
}


@end
