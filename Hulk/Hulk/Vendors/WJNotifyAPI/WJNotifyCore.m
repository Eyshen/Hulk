//
//  WJNotifyCore.m
//  WJNotifyAPI-example
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by 吴云海 on 16/10/31.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "WJNotifyCore.h"
#import "IWJNotifyHandler.h"
#import "WJConfig.h"

@interface WJNotifyCore ()

@property(nonatomic, strong) NSMutableDictionary *handlers;

@property(nonatomic, strong) dispatch_queue_t notify_handle_queue;

@property(nonatomic, strong) dispatch_semaphore_t notify_handle_semaphore;

@end

@implementation WJNotifyCore

DEF_SINGLETON_INIT(WJNotifyCore)
 
-(void) singleInit {
    //单利初始化
    self.handlers = [[NSMutableDictionary alloc] init];
    
    self.notify_handle_queue = dispatch_queue_create("com.wj.notify.queue", NULL);
    dispatch_set_target_queue(_notify_handle_queue, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    self.notify_handle_semaphore = dispatch_semaphore_create(5);
    
    [self loadConfig];
}

- (void)loadConfig {
    NSDictionary *config = [[WJConfig sharedInstance] getConfig:@"WJNotifyAPI"];
    if ([[config allKeys] containsObject:@"notifyHandlers"]) {
        id o = [config objectForKey:@"notifyHandlers"];
        if ([o isKindOfClass:[NSArray class]]) {
            for (id item in o) {
                if ([item isKindOfClass:[NSString class]]) {
                    [self injectNotifyHandle:NSClassFromString(item)];
                }
            }
        }
    }
}


-(void)handleNotify:(id<IWJNotify>)notify {
    if (notify) {
        dispatch_semaphore_wait(_notify_handle_semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(_notify_handle_queue, ^{
            NSInteger type = [notify notifyType];
            WJLogDebug(@"handle notify type:%d",type);
            NSArray *hs = self.handlers[@(type)];
            BOOL isAsyn = NO;
            if ([notify respondsToSelector:@selector(isAsyn)]) {
                isAsyn = [notify isAsyn];
            }
            for (id<IWJNotifyHandler> handler in hs) {
                if ([handler canHandle:notify]) {
                    if (isAsyn) {
                        [handler handle:notify];
                    } else {
                        [(NSObject*)handler performSelectorOnMainThread:@selector(handle:) withObject:notify waitUntilDone:NO];
                    }
                }
            }
            dispatch_semaphore_signal(_notify_handle_semaphore);
        });
    }
}

-(BOOL)canHandleNotify:(id<IWJNotify>)notify {
    BOOL r = NO;
    if (notify) {
        NSInteger type = [notify notifyType];
        NSArray *hs = self.handlers[@(type)];
        for (id<IWJNotifyHandler> handler in hs) {
            if ([handler canHandle:notify]) {
                r = YES;
                break;
            }
        }
    }
    return r;
}

#pragma mark IWJInjectConfig
- (void)injectNotifyHandle:(Class)clazz {
    if ([clazz conformsToProtocol:@protocol(IWJNotifyHandler)]) {
        id<IWJNotifyHandler> handler = [clazz getInstance];
        NSInteger type = [clazz canHandleNotifyType];
        NSMutableArray *hs = self.handlers[@(type)];
        if (!hs) {
            hs = [[NSMutableArray alloc] init];
            [_handlers setObject:hs forKey:@(type)];
        }
        [hs addObject:handler];
    }
}


@end
