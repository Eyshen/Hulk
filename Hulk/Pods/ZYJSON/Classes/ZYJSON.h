//
//  ZYJSON.h
//
//     ___________ __      __
//    /\______   / \ \    / /
//    \/___  /  /   \ \  / /
//        / /  /     \ \/ /
//       / /  /       |  |
//      / /  /______  |  |
//     / /__________\ |__|
//
//  Created by Eason.zhangyi on 15/9/9.
//  Copyright (c) 2016年 ZY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYJSONGroupType.h"
#import "NSObject+ZYJSON.h"

@interface NSObject (ZYConverter)

-(id) zyInitWithDictionary:(NSDictionary*) dictionary;

-(NSDictionary*) zyDictionary;

@end

/**
 *  JSON 解析入口
 */
@interface ZYJSON : NSObject

/**
 *  将对象转成Json（可以直接解析NSDictionary，NSArray，NSObject）
 */
+(NSData*) toJson:(id) object;

/**
 *  将对象转成Json（可以直接解析NSDictionary，NSArray，NSObject）
 */
+(NSString*) toJsonString:(id) object;

/**
 *  解析Json
 */
+(id) fromJsonString:(NSString*) jsonString type:(Class) type;

/**
 *  解析Json
 */
+(id) fromJsonData:(NSData*) jsonData type:(Class)type;

/**
 *  解析Json
 */
+(id) fromJsonString:(NSString*) jsonString groupType:(ZYJSONGroupType*) groupType;

/**
 *  解析Json
 */
+(id) fromJsonData:(NSData*) jsonData groupType:(ZYJSONGroupType*) groupType;

/**
 *  返回NSDictionary 或者 NSArray
 */
+(id) fromJsonString:(NSString*) json;

/**
 *  返回NSDictionary 或者 NSArray
 */
+(id) fromJsonData:(NSData*)jsonData;


@end
