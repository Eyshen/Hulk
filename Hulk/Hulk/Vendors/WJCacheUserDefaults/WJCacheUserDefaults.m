//
//  WJCacheUserDefaults.m
//  WJCacheUserDefaults-example
//
//  Created by 吴云海 on 16/9/27.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "WJCacheUserDefaults.h"

@interface WJCacheUserDefaults ()

@property(nonatomic, weak) NSUserDefaults *userDefaults;

@end

@implementation WJCacheUserDefaults

DEF_SINGLETON_INIT(WJCacheUserDefaults)
 
-(void) singleInit {
    self.userDefaults = [NSUserDefaults standardUserDefaults];
}

#pragma mark IWJCache
- (BOOL)hasObjectForKey:(NSString*)key {
    id value = [self.userDefaults objectForKey:key];
    return value ? YES : NO;
}

- (BOOL)boolForKey:(NSString*)key {
    if (key)
        return [self.userDefaults boolForKey:key];
    return NO;
}

- (void)setBool:(BOOL)value forKey:(NSString*)key {
    if (key) {
        [self.userDefaults setBool:value forKey:key];
        [self.userDefaults synchronize];
    }
}

- (NSString*)stringForKey:(NSString*)key {
    if (key) {
        return [self.userDefaults stringForKey:key];
    }
    return nil;
}

- (void)setString:(NSString*)value forKey:(NSString*)key {
    if (value && key) {
        [self.userDefaults setObject:value forKey:key];
        [self.userDefaults synchronize];
    }
}

- (NSData*)dataForKey:(NSString*)key {
    if (key) {
        return [self.userDefaults dataForKey:key];
    }
    return nil;
}

- (void)setData:(NSData*)data forKey:(NSString*)key {
    if (data && key) {
        [self.userDefaults setObject:data forKey:key];
        [self.userDefaults synchronize];
    }
}

- (id<NSCoding>)objectForKey:(NSString*)key {
    if (key) {
        return [self.userDefaults objectForKey:key];
    }
    return nil;
}

- (void)setObject:(id<NSCoding>)object forKey:(NSString*)key {
    if (object && key) {
        [self.userDefaults setObject:object forKey:key];
        [self.userDefaults synchronize];
    }
}

- (void)removeObjectForKey:(NSString*)key {
    if (key) {
        [self.userDefaults removeObjectForKey:key];
        [self.userDefaults synchronize];
    }
}

- (void)removeAllObjects {
    [NSUserDefaults resetStandardUserDefaults];
    self.userDefaults = [NSUserDefaults standardUserDefaults];
}

-(NSInteger)cacheType {
    return WJCacheTypeUserDefaults;
}

+(id<IWJCache>)getInstance {
    return [WJCacheUserDefaults sharedInstance];
}

@end
