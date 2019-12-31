//
//  WJHttpEngineConfig.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/12/25.
//  Copyright © 2015年 WJ. All rights reserved.
//

#import "WJHttpEngineConfig.h"
#import "IWJHttpEngine.h"
#import "IWJHttpFilter.h"
#import "WJConfig.h"



@interface WJHttpEngineConfig ()
@property (nonatomic, strong) NSMutableArray *fs;
@property (nonatomic, strong) NSMutableSet *cerPaths;
@end

@implementation WJHttpEngineConfig

DEF_SINGLETON_INIT(WJHttpEngineConfig)

-(void) singleInit {
    _defaultTimeoutDuration = 60;
    _defaultNetworkActivityEnabled = YES;
    _fs = [[NSMutableArray alloc] init];
    self.defaultEngineName = @"AFWJHttpEngine";
    self.cerPaths = [[NSMutableSet alloc] init];
    
    NSDictionary *config = [[WJConfig sharedInstance] getConfig:@"WJHttpEngineAPI"];
    if ([[config allKeys] containsObject:@"timeoutDuration"]) {
        id o = [config objectForKey:@"timeoutDuration"];
        if ([o isKindOfClass:[NSNumber class]]) {
            _defaultTimeoutDuration = [(NSNumber*)o intValue];
        }
    }
    if ([[config allKeys] containsObject:@"defaultEngineName"]) {
        id o = [config objectForKey:@"defaultEngineName"];
        if ([o isKindOfClass:[NSString class]]) {
            self.defaultEngineName = o;
        }
    }
    if ([[config allKeys] containsObject:@"networkActivityEnabled"]) {
        id o = [config objectForKey:@"networkActivityEnabled"];
        if ([o isKindOfClass:[NSNumber class]]) {
            _defaultNetworkActivityEnabled = [(NSNumber*)o boolValue];
        }
    }
    if ([[config allKeys] containsObject:@"allowInvalidCertificates"]) {
        id o = [config objectForKey:@"allowInvalidCertificates"];
        if ([o isKindOfClass:[NSNumber class]]) {
            _allowInvalidCertificates = [(NSNumber*)o boolValue];
        }
    }
    if ([[config allKeys] containsObject:@"filters"]) {
        id o = [config objectForKey:@"filters"];
        if ([o isKindOfClass:[NSArray class]]) {
            for (id item in o) {
                if ([item isKindOfClass:[NSString class]]) {
                    [self addFilter:NSClassFromString(item)];
                }
            }
        }
    }
    if ([[config allKeys] containsObject:@"cers"]) {
        id o = [config objectForKey:@"cers"];
        if ([o isKindOfClass:[NSArray class]]) {
            for (id item in o) {
                if ([item isKindOfClass:[NSString class]]) {
                    if ([(NSString*)item hasSuffix:@"cer"]) {
                        [self addCertificater:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:item]];
                    }
                }
            }
        }
    }
}

-(void) setTimeoutDuration:(int) timeoutDuration {
    if (timeoutDuration > 0) {
        _defaultTimeoutDuration = timeoutDuration;
    }
}

-(void) setNetworkActivityEnabled:(BOOL) enabled {
    _defaultNetworkActivityEnabled = enabled;
}

-(void) addFilter:(Class) filterClazz {
    if (filterClazz) {
        if ([filterClazz conformsToProtocol:@protocol(IWJHttpFilter)]) {
            [_fs addObject:filterClazz];
        } else {
            NSString *reason = [NSString stringWithFormat:@"%@ 没有实现过滤器协议 IWJHttpFilter",NSStringFromClass(filterClazz)];
            @throw [NSException exceptionWithName:@"WJHttpEngineException" reason:reason userInfo:nil];
        }
    }
}

-(NSArray *)filters {
    return _fs;
}

/**
 *  添加证书
 */
-(void) addCertificater:(NSString*) path {
    if ([[NSFileManager defaultManager] fileExistsAtPath:path] && [[path pathExtension] isEqualToString:@"cer"]) {
        [_cerPaths addObject:path];
    }
}

/**
 *  证书列表
 */
-(NSArray*) certificatesPaths {
    return _cerPaths.allObjects;
}

@end
