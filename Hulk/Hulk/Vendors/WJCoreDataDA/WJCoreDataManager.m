//
//  WJCoreDataManager.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/12/15.
//  Copyright © 2015年 WJ. All rights reserved.
//

#import "WJCoreDataManager.h"
#import "WJLoggingMacros.h"

static WJCoreDataManager *sharedObject = nil;

@implementation WJCoreDataManager

-(NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle bundleForClass:[self class]] URLForResource:[self modelName] withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

-(NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:[self databaseName]];
    
    _persistentStoreCoordinator = [self persistentStoreCoordinatorWithStoreType:NSSQLiteStoreType
                                                                       storeURL:storeURL];
    return _persistentStoreCoordinator;
}

-(void) wjInitManagedObjectContext {
    if (!_managedObjectContext) {
        NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
        if (coordinator) {
            _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
            [_managedObjectContext setPersistentStoreCoordinator:coordinator];
        } else {
            WJLogError(@"coordinator nil");
        }
    }
}

-(NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    if ([[NSThread currentThread] isMainThread]) {
        [self wjInitManagedObjectContext];
    } else {
        [self performSelectorOnMainThread:@selector(wjInitManagedObjectContext) withObject:nil waitUntilDone:YES];
    }
    return _managedObjectContext;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinatorWithStoreType:(NSString *const)storeType
                                                                 storeURL:(NSURL *)storeURL {
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    NSDictionary *options = @{ NSMigratePersistentStoresAutomaticallyOption: @YES,
                               NSInferMappingModelAutomaticallyOption: @YES };
    NSError *error = nil;
    if (![coordinator addPersistentStoreWithType:storeType configuration:nil URL:storeURL options:options error:&error])
        WJLogError(@"ERROR WHILE CREATING PERSISTENT STORE COORDINATOR! %@",error);
    
    return coordinator;
}

- (NSString *)appName {
    return [[NSBundle bundleForClass:[self class]] infoDictionary][@"CFBundleName"];
}

- (NSString *)databaseName {
    if (_databaseName != nil) return _databaseName;
    _databaseName = [[[self appName] stringByAppendingString:@".sqlite"] copy];
    return _databaseName;
}

- (NSString *)modelName {
    if (_modelName != nil) return _modelName;
    
    _modelName = [[self appName] copy];
    return _modelName;
}

-(void) singleInit {
    
}

+(id)allocWithZone:(NSZone *)zone {
    @synchronized (self) {
        if (sharedObject == nil) {
            sharedObject = [super allocWithZone:zone];
        }
    }
    return sharedObject;
}

-(id)copy {
    return self;
}

-(id)mutableCopy {
    return self;
}

+(instancetype)sharedObject {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[WJCoreDataManager alloc] init];
        [sharedObject singleInit];
    });
    return sharedObject;
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
