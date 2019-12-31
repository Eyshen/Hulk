//
//  NSManagedObjectContext+WJExtension.h
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

@interface NSManagedObjectContext (WJDA)

/**
 *  在当前线程获得一个Context
 *
 *  @return NSManagedObjectContext
 */
+ (NSManagedObjectContext *)defaultContext;

/**
 *  保存
 *
 *  @param wait  是否等待完成
 *  @param error 错误指针
 *
 *  @return 是否成功
 */
-(BOOL) saveAndWait:(BOOL) wait error:(NSError*__autoreleasing*) error;

@end
