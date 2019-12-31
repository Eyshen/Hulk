//
//  FilterCore.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/7/30.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import "WJHttpFilterCore.h"
#import "IWJHttpFilter.h"
#import "WJHttpEngineConfig.h"
#import "WJLoggingMacros.h"

static WJHttpFilterCore *sharedObject;

@interface WJHttpFilterCore ()
@property (nonatomic, strong) NSMutableArray *filters;
@end

@implementation WJHttpFilterCore

-(void)filter:(id)res {
    for (id filter in _filters) {
        if ([res conformsToProtocol:@protocol(IWJHttpResponse)]) {
            if (![filter doFilter:res]) {
                break;
            }
        } else {
            if (![filter doFilterData:res]) {
                break;
            }
        }
    }
}

-(void) singleInit {
    self.filters = [[NSMutableArray alloc] init];
    
    NSArray *fs = [[WJHttpEngineConfig sharedInstance] filters];
    for (Class f in fs) {
        [self.filters addObject:[[f alloc] init]];
    }
}

+(instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[WJHttpFilterCore alloc] init];
        [sharedObject singleInit];
    });
    return sharedObject;
}

-(id)mutableCopy {
    return self;
}

-(id)copy {
    return self;
}

+(id)allocWithZone:(NSZone *)zone {
    @synchronized (self) {
        if (sharedObject == nil) {
            sharedObject = [super allocWithZone:zone];
        }
    }
    return sharedObject;
}

@end
