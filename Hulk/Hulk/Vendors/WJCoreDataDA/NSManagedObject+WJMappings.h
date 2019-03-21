//
//  NSManagedObject+WJMappings.h
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

@interface NSManagedObject (WJMappings)

/**
 A dictionary mapping remote (server) attribute names to local (Core Data) attribute names. Optionally overridden in NSManagedObject subclasses.
 
 @return A dictionary.
 */
+ (NSDictionary *)mappings;

/**
 Returns a Core Data attribute name for a remote attribute name. Returns values defined in @c +mappings or, by default, converts snake case to camel case (e.g., @c @@"first_name" becomes @c @@"firstName").
 
 @see +[NSManagedObject mappings]
 
 @param remoteKey     A remote (server) attribute name.
 @param context A local managed object context.
 
 @return A local (Core Data) attribute name.
 */
+ (NSString *)keyForRemoteKey:(NSString *)remoteKey inContext:(NSManagedObjectContext *)context;

/**
 Transforms a given object for a remote attribute name.
 
 @param value     Object to be transformed (e.g., a dictionary may become a managed object)
 @param remoteKey A remote (server) attribute name.
 @param context   A local managed object context.
 
 @return A tranformed object.
 */
+ (id)transformValue:(id)value forRemoteKey:(NSString *)remoteKey inContext:(NSManagedObjectContext *)context;

/**
 The keypath uniquely identifying your entity. Usually an ID, e.g., @c @@"remoteID".
 
 @return An attribute name.
 */
+ (NSString *)primaryKey;

@end
