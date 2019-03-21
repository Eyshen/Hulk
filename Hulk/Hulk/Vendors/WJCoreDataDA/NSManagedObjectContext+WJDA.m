//
//  NSManagedObjectContext+WJExtension.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/12/16.
//  Copyright © 2015年 WJ. All rights reserved.
//

#import "NSManagedObjectContext+WJDA.h"
#import "WJCoreDataManager.h"
#import "WJLoggingMacros.h"

@implementation NSManagedObjectContext (WJDA)

+ (NSManagedObjectContext *)defaultContext {
    if ([[NSThread currentThread] isMainThread]) {
        return [[WJCoreDataManager sharedObject] managedObjectContext];
    } else {
        NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        context.parentContext = [[WJCoreDataManager sharedObject] managedObjectContext];
        return context;
    }
}

-(BOOL) saveAndWait:(BOOL) wait error:(NSError*__autoreleasing*) error {
    __block BOOL result = YES;
    if ([self hasChanges] && [self save:error]) {
        if (self.parentContext) {
            if (wait) {
                [self.parentContext performBlockAndWait:^{
                    NSError *e = nil;
                    if (![self.parentContext save:&e]) {
                        result = NO;
                        WJLogError(@"%@",error);
                    }
                }];
            } else {
                [self.parentContext performBlock:^{
                    NSError *e = nil;
                    if (![self.parentContext save:&e]) {
                        result = NO;
                        WJLogError(@"%@",error);
                    }
                }];
            }
        }
    } else {
        result = NO;
    }
    return result;
}

@end
