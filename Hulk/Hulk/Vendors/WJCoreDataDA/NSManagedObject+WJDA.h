//
//  NSManagedObject+WJDataAccess.h
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

#import <CoreData/CoreData.h>
#import "NSManagedObjectContext+WJDA.h"

@interface NSManagedObject (WJDA)

#pragma mark - Default Context

/**
 *  如果是异步线程一定要保证 NSManagedObjectContext 没有被销毁
 */
- (BOOL)save;
- (void)delete;
+ (void)deleteAll;

/**
 *  主线程使用
 */
+ (id)create;
+ (id)create:(NSDictionary *)attributes;
- (void)update:(NSDictionary *)attributes;

+ (NSArray *)all;
+ (NSArray *)allWithOrder:(id)order;
+ (NSArray *)where:(id)condition, ...;
+ (NSArray *)where:(id)condition order:(id)order;
+ (NSArray *)where:(id)condition limit:(NSNumber *)limit;
+ (NSArray *)where:(id)condition order:(id)order limit:(NSNumber *)limit;
+ (instancetype)findOrCreate:(NSDictionary *)attributes;
+ (instancetype)find:(id)condition, ...;
+ (NSUInteger)count;
+ (NSUInteger)countWhere:(id)condition, ...;

/**
 *  批量修改数据，注意，如果是使用NSFetchResultsController，需要重新执行performFetch，获取数据
 *
 *  @param condition  条件
 *  @param attributes 更新值
 *
 *  @return 影响记录条数
 */
+ (NSUInteger)batchUpdate:(id)condition attributes:(NSDictionary*)attributes;

#pragma mark - Custom Context

/**
 *  非主线程使用
 */
+ (id)createInContext:(NSManagedObjectContext *)context;
+ (id)create:(NSDictionary *)attributes inContext:(NSManagedObjectContext *)context;

+ (void)deleteAllInContext:(NSManagedObjectContext *)context;

+ (NSArray *)allInContext:(NSManagedObjectContext *)context;
+ (NSArray *)allInContext:(NSManagedObjectContext *)context order:(id)order;
+ (NSArray *)where:(id)condition inContext:(NSManagedObjectContext *)context;
+ (NSArray *)where:(id)condition inContext:(NSManagedObjectContext *)context order:(id)order;
+ (NSArray *)where:(id)condition inContext:(NSManagedObjectContext *)context limit:(NSNumber *)limit;
+ (NSArray *)where:(id)condition inContext:(NSManagedObjectContext *)context order:(id)order limit:(NSNumber *)limit;
+ (instancetype)findOrCreate:(NSDictionary *)properties inContext:(NSManagedObjectContext *)context;
+ (instancetype)find:(id)condition inContext:(NSManagedObjectContext *)context;
+ (NSUInteger)countInContext:(NSManagedObjectContext *)context;
+ (NSUInteger)countWhere:(id)condition inContext:(NSManagedObjectContext *)context;

/**
 *  批量修改数据，注意，如果是使用NSFetchResultsController，需要重新执行performFetch，获取数据
 *
 *  @param condition  条件
 *  @param attributes 更新值
 *  @param context    对象上下文环境
 *
 *  @return 影响记录条数
 */
+ (NSUInteger)batchUpdate:(id)condition attributes:(NSDictionary*)attributes inContext:(NSManagedObjectContext *)context;

#pragma mark - Naming

+ (NSString *)entityName;

@end
