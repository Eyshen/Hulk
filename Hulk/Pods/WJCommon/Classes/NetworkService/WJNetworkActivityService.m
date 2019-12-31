//
//  WJNetworkActivityManager.m
//  117goFramework
//
//  Created by Yunhai.Wu on 15/7/30.
//  Copyright (c) 2015年 117go. All rights reserved.
//

#import "WJNetworkActivityService.h"
#import <UIKit/UIKit.h>

@interface WJNetworkActivityService ()
@property (atomic, assign) int counter;
@end

@implementation WJNetworkActivityService

DEF_SINGLETON_INIT(WJNetworkActivityService)

-(void)start {
    @synchronized(self) {
        if (_counter == 0) {
            if ([[NSThread currentThread] isMainThread]) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            } else {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
                });
            }
            
        }
        _counter++;
    }
}

-(void)stop {
    @synchronized(self) {
        if (_counter > 0 && --_counter == 0) {
            if ([[NSThread currentThread] isMainThread]) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            } else {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                });
            }
        }
    }
}

-(void)stopAll {
    @synchronized(self) {
        _counter = 0;
        if ([[NSThread currentThread] isMainThread]) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            });
        }
    }
}

-(void) handleApplicationDidEnterBackgroundNotification:(NSNotification*) notification {
    [self stopAll];
}

-(void) singleInit {
    _counter = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationDidEnterBackgroundNotification:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
