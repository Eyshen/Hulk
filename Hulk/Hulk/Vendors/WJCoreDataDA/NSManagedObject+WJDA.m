//
//  NSManagedObject+WJDataAccess.m
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

#import "NSManagedObject+WJDA.h"
#import "WJCoreDataManager.h"
#import "NSArray+WJExtension.h"
#import "NSDictionary+WJExtension.h"
#import "NSManagedObject+WJMappings.h"
#import "NSString+WJExtension.h"
#import "WJLoggingMacros.h"
#import <UIKit/UIKit.h>
#import "WJVersionUtils.h"
#import "WJCommon.h"

@implementation NSObject(null)

- (BOOL)exists {
    return self && self != [NSNull null];
}

@end

@implementation NSManagedObject (WJDA)

#pragma mark - Finders

+ (NSArray *)all {
    return [self allInContext:[NSManagedObjectContext defaultContext]];
}

+ (NSArray *)allWithOrder:(id)order {
    return [self allInContext:[NSManagedObjectContext defaultContext] order:order];
}

+ (NSArray *)allInContext:(NSManagedObjectContext *)context {
    return [self allInContext:context order:nil];
}

+ (NSArray *)allInContext:(NSManagedObjectContext *)context order:(id)order {
    return [self fetchWithCondition:nil inContext:context withOrder:order fetchLimit:nil];
}

+ (instancetype)findOrCreate:(NSDictionary *)properties {
    return [self findOrCreate:properties inContext:[NSManagedObjectContext defaultContext]];
}

+ (instancetype)findOrCreate:(NSDictionary *)properties inContext:(NSManagedObjectContext *)context {
    NSDictionary *transformed = [[self class] transformProperties:properties withObject:nil context:context];
    
    NSManagedObject *existing = [self where:transformed inContext:context].wj_first;
    return existing ?: [self create:transformed inContext:context];
}

+ (instancetype)find:(id)condition, ... {
    va_list va_arguments;
    va_start(va_arguments, condition);
    NSPredicate *predicate = [self predicateFromObject:condition arguments:va_arguments];
    va_end(va_arguments);
    
    return [self find:predicate inContext:[NSManagedObjectContext defaultContext]];
}

+ (instancetype)find:(id)condition inContext:(NSManagedObjectContext *)context {
    return [self where:condition inContext:context limit:@1].wj_first;
}

+ (NSArray *)where:(id)condition, ... {
    va_list va_arguments;
    va_start(va_arguments, condition);
    NSPredicate *predicate = [self predicateFromObject:condition arguments:va_arguments];
    va_end(va_arguments);
    
    return [self where:predicate inContext:[NSManagedObjectContext defaultContext]];
}

+ (NSArray *)where:(id)condition order:(id)order {
    return [self where:condition inContext:[NSManagedObjectContext defaultContext] order:order];
}

+ (NSArray *)where:(id)condition limit:(NSNumber *)limit {
    return [self where:condition inContext:[NSManagedObjectContext defaultContext] limit:limit];
}

+ (NSArray *)where:(id)condition order:(id)order limit:(NSNumber *)limit {
    return [self where:condition inContext:[NSManagedObjectContext defaultContext] order:order limit:limit];
}

+ (NSArray *)where:(id)condition inContext:(NSManagedObjectContext *)context {
    return [self where:condition inContext:context order:nil limit:nil];
}

+ (NSArray *)where:(id)condition inContext:(NSManagedObjectContext *)context order:(id)order {
    return [self where:condition inContext:context order:order limit:nil];
}

+ (NSArray *)where:(id)condition inContext:(NSManagedObjectContext *)context limit:(NSNumber *)limit {
    return [self where:condition inContext:context order:nil limit:limit];
}

+ (NSArray *)where:(id)condition inContext:(NSManagedObjectContext *)context order:(id)order limit:(NSNumber *)limit {
    return [self fetchWithCondition:condition inContext:context withOrder:order fetchLimit:limit];
}

#pragma mark - Aggregation

+ (NSUInteger)count {
    return [self countInContext:[NSManagedObjectContext defaultContext]];
}

+ (NSUInteger)countWhere:(id)condition, ... {
    va_list va_arguments;
    va_start(va_arguments, condition);
    NSPredicate *predicate = [self predicateFromObject:condition arguments:va_arguments];
    va_end(va_arguments);
    
    return [self countWhere:predicate inContext:[NSManagedObjectContext defaultContext]];
}

+ (NSUInteger)batchUpdate:(id)condition attributes:(NSDictionary *)attributes {
    NSManagedObjectContext *context = [NSManagedObjectContext defaultContext];
    return [self batchUpdate:condition attributes:attributes inContext:context];
}

+(NSUInteger)batchUpdate:(id)condition attributes:(NSDictionary *)attributes inContext:(NSManagedObjectContext *)context {
    if (context && [attributes count] > 0) {
        /*
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
        if (WJ_OS_VERSION_GREATER_THAN_OR_EQUAL(@"8.0")) {
            NSPredicate *predicate = [self predicateFromObject:condition];
            NSEntityDescription *entityDescription = [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:context];
            NSBatchUpdateRequest *request = [[NSBatchUpdateRequest alloc] initWithEntity:entityDescription];
            request.resultType = NSUpdatedObjectIDsResultType;
            [request setPredicate:predicate];
            [request setPropertiesToUpdate:attributes];
            NSError *error = nil;
            NSBatchUpdateResult *updateResult = [context executeRequest:request error:&error];
            if (!error) {
                NSArray *ids = updateResult.result;
                [context performBlockAndWait:^{
                    NSManagedObject *o = nil;
                    for (NSManagedObjectID *oId in ids) {
                        o = [context objectWithID:oId];
                        if (![o isFault]) {
                            [context refreshObject:o mergeChanges:YES];
                        }
                    }
                }];
                return [ids count];
            } else {
                WJLogError(@"%@",error.userInfo[NSLocalizedDescriptionKey]);
            }
        } else {
            //8.0以下处理逻辑
            return [self beforeForiOS8BatchUpdate:condition attributes:attributes inContext:(NSManagedObjectContext*)context];
        }
#else
        //8.0以下处理逻辑
        return [self beforeForiOS8BatchUpdate:condition attributes:attributes inContext:(NSManagedObjectContext*)context];
#endif
         */
        return [self beforeForiOS8BatchUpdate:condition attributes:attributes inContext:(NSManagedObjectContext*)context];
    }
    return 0;
}

+ (NSUInteger)beforeForiOS8BatchUpdate:(id)condition attributes:(NSDictionary *)attributes inContext:(NSManagedObjectContext *)context {
    NSArray *objects = [self where:condition inContext:context];
    for (NSManagedObject *mo in objects) {
        @autoreleasepool {
            [mo update:attributes];
        }
    }
    if ([objects count] > 0) [context saveAndWait:YES error:NULL];
    return [objects count];
}

+ (NSUInteger)countInContext:(NSManagedObjectContext *)context {
    return [self countForFetchWithPredicate:nil inContext:context];
}

+ (NSUInteger)countWhere:(id)condition inContext:(NSManagedObjectContext *)context {
    NSPredicate *predicate = [self predicateFromObject:condition];
    
    return [self countForFetchWithPredicate:predicate inContext:context];
}

#pragma mark - Creation / Deletion

+ (id)create {
    return [self createInContext:[NSManagedObjectContext defaultContext]];
}

+ (id)create:(NSDictionary *)attributes {
    return [self create:attributes inContext:[NSManagedObjectContext defaultContext]];
}

+ (id)create:(NSDictionary *)attributes inContext:(NSManagedObjectContext *)context {
    if (![attributes exists]) {
        return nil;
    }
    
    NSManagedObject *newEntity = [self createInContext:context];
    [newEntity update:attributes];
    
    return newEntity;
}

+ (id)createInContext:(NSManagedObjectContext *)context {
    return [NSEntityDescription insertNewObjectForEntityForName:[self entityName]
                                         inManagedObjectContext:context];
}

- (void)update:(NSDictionary *)attributes {
    if (![attributes exists]) {
        return;
    }
    NSDictionary *transformed = [[self class] transformProperties:attributes withObject:self context:self.managedObjectContext];
    WJ_WEAK_REF_TYPE weakSelf = self;
    [transformed wj_each:^(NSString *key, id value) {
        [weakSelf willChangeValueForKey:key];
        [weakSelf setSafeValue:value forKey:key];
        [weakSelf didChangeValueForKey:key];
    }];
}

- (BOOL)save {
    return [self saveTheContext];
}

- (void)delete {
    [self.managedObjectContext deleteObject:self];
}

+ (void)deleteAll {
    [self deleteAllInContext:[NSManagedObjectContext defaultContext]];
}

+ (void)deleteAllInContext:(NSManagedObjectContext *)context {
    [[self allInContext:context] wj_each:^(id object) {
        [object delete];
    }];
}

#pragma mark - Naming

+ (NSString *)entityName {
    return NSStringFromClass(self);
}

#pragma mark - Private

+ (NSDictionary *)transformProperties:(NSDictionary *)properties withObject:(NSManagedObject *)object context:(NSManagedObjectContext *)context {
    NSEntityDescription *entity = [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:context];
    
    NSDictionary *attributes = [entity attributesByName];
    NSDictionary *relationships = [entity relationshipsByName];
    
    NSMutableDictionary *transformed = [NSMutableDictionary dictionaryWithCapacity:[properties count]];
    
    for (NSString *key in properties) {
        NSString *localKey = [self keyForRemoteKey:key inContext:context];
        if (attributes[localKey] || relationships[localKey]) {
            id value = [[self class] transformValue:properties[key] forRemoteKey:key inContext:context];
            if (object) {
                id localValue = [object primitiveValueForKey:localKey];
                if ([localValue isEqual:value] || (localValue == nil && value == [NSNull null]))
                    continue;
            }
            transformed[localKey] = value;
        } else {
            WJLogDebug(@"Discarding key ('%@') from properties on class ('%@'): no attribute or relationship found",key, [self class]);
        }
    }
    
    return transformed;
}

+ (NSPredicate *)predicateFromDictionary:(NSDictionary *)dict {
    NSArray *subpredicates = [dict wj_map:^(NSString *key, id value) {
        return [NSPredicate predicateWithFormat:@"%K = %@", key, value];
    }];
    
    return [NSCompoundPredicate andPredicateWithSubpredicates:subpredicates];
}

+ (NSPredicate *)predicateFromObject:(id)condition {
    return [self predicateFromObject:condition arguments:NULL];
}

+ (NSPredicate *)predicateFromObject:(id)condition arguments:(va_list)arguments {
    if ([condition isKindOfClass:[NSPredicate class]])
        return condition;
    
    if ([condition isKindOfClass:[NSString class]])
        return [NSPredicate predicateWithFormat:condition arguments:arguments];
    
    if ([condition isKindOfClass:[NSDictionary class]])
        return [self predicateFromDictionary:condition];
    
    return nil;
}

+ (NSSortDescriptor *)sortDescriptorFromDictionary:(NSDictionary *)dict {
    BOOL isAscending = ![[dict.allValues.wj_first uppercaseString] isEqualToString:@"DESC"];
    return [NSSortDescriptor sortDescriptorWithKey:dict.allKeys.wj_first
                                         ascending:isAscending];
}

+ (NSSortDescriptor *)sortDescriptorFromString:(NSString *)order {
    NSArray *components = [order wj_split];
    
    NSString *key = [components firstObject];
    NSString *value = [components count] > 1 ? components[1] : @"ASC";
    
    return [self sortDescriptorFromDictionary:@{key: value}];
    
}

+ (NSSortDescriptor *)sortDescriptorFromObject:(id)order {
    if ([order isKindOfClass:[NSSortDescriptor class]])
        return order;
    
    if ([order isKindOfClass:[NSString class]])
        return [self sortDescriptorFromString:order];
    
    if ([order isKindOfClass:[NSDictionary class]])
        return [self sortDescriptorFromDictionary:order];
    
    return nil;
}

+ (NSArray *)sortDescriptorsFromObject:(id)order {
    if ([order isKindOfClass:[NSString class]])
        order = [order componentsSeparatedByString:@","];
    
    if ([order isKindOfClass:[NSArray class]])
        return [order wj_map:^id (id object) {
            return [self sortDescriptorFromObject:object];
        }];
    
    return @[[self sortDescriptorFromObject:order]];
}

+ (NSFetchRequest *)createFetchRequestInContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [NSFetchRequest new];
    NSEntityDescription *entity = [NSEntityDescription entityForName:[self entityName]
                                              inManagedObjectContext:context];
    [request setEntity:entity];
    return request;
}

+ (NSArray *)fetchWithCondition:(id)condition
                      inContext:(NSManagedObjectContext *)context
                      withOrder:(id)order
                     fetchLimit:(NSNumber *)fetchLimit {
    
    NSFetchRequest *request = [self createFetchRequestInContext:context];
    
    if (condition)
        [request setPredicate:[self predicateFromObject:condition]];
    
    if (order)
        [request setSortDescriptors:[self sortDescriptorsFromObject:order]];
    
    if (fetchLimit)
        [request setFetchLimit:[fetchLimit integerValue]];
    
    return [context executeFetchRequest:request error:nil];
}

+ (NSUInteger)countForFetchWithPredicate:(NSPredicate *)predicate
                               inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [self createFetchRequestInContext:context];
    [request setPredicate:predicate];
    
    return [context countForFetchRequest:request error:nil];
}

- (BOOL)saveTheContext {
    NSError *error = nil;
    BOOL r = [self.managedObjectContext saveAndWait:YES error:&error];
    if (!r) {
        WJLogError(@"%@",error);
    }
    return r;
}

- (void)setSafeValue:(id)value forKey:(NSString *)key {
    if (value == nil || value == [NSNull null]) {
        [self setNilValueForKey:key];
        return;
    }
    
    NSAttributeDescription *attribute = [[self entity] attributesByName][key];
    NSAttributeType attributeType = [attribute attributeType];
    
    if ((attributeType == NSStringAttributeType) && ([value isKindOfClass:[NSNumber class]]))
        value = [value stringValue];
    
    else if ([value isKindOfClass:[NSString class]]) {
        
        if ([self isIntegerAttributeType:attributeType])
            value = [NSNumber numberWithLongLong:[value longLongValue]];
        
        else if (attributeType == NSBooleanAttributeType)
            value = [NSNumber numberWithBool:[value boolValue]];
        
        else if ([self isFloatAttributeType:attributeType])
            value = [NSNumber numberWithDouble:[value doubleValue]];
        
        else if (attributeType == NSDateAttributeType)
            value = [self.defaultFormatter dateFromString:value];
    }
    
    [self setPrimitiveValue:value forKey:key];
}

- (BOOL)isIntegerAttributeType:(NSAttributeType)attributeType {
    return (attributeType == NSInteger16AttributeType) ||
    (attributeType == NSInteger32AttributeType) ||
    (attributeType == NSInteger64AttributeType);
}

- (BOOL)isFloatAttributeType:(NSAttributeType)attributeType {
    return (attributeType == NSFloatAttributeType) ||
    (attributeType == NSDoubleAttributeType);
}

#pragma mark - Date Formatting

- (NSDateFormatter *)defaultFormatter {
    static NSDateFormatter *sharedFormatter;
    static dispatch_once_t singletonToken;
    dispatch_once(&singletonToken, ^{
        sharedFormatter = [[NSDateFormatter alloc] init];
        [sharedFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss z"];
    });
    
    return sharedFormatter;
}



@end
