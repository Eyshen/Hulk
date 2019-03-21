//
//  ZYJSONObjectDesc.h
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

/**
 *  对象类型
 */
typedef NS_ENUM(NSInteger, ZYObjectType) {
    ZYObjectTypeObject,//任意类型自定义
    ZYObjectTypeDictionary,//词典类型
    ZYObjectTypeArray,//数组类型
    ZYObjectTypeSet,//集合类型
    ZYObjectTypeNumber,//数字类型
    ZYObjectTypeString,//字符串类型
    ZYObjectTypeDate,//日期类型
    ZYObjectTypeCustom,//自定义类型
};


@interface ZYJSONPropertyDesc : NSObject
@property (nonatomic, copy) NSString *jsonName;//属性对应JSON名称
@property (nonatomic, copy) NSString *name;//属性名称
@property (nonatomic, assign) ZYObjectType type;
@property (nonatomic, copy) NSString *typeName;//类型名称 NSString NSNumber NSArray NSDictionary
@property (nonatomic, copy) NSString *dateFormat;//日期格式化字符串
@property (nonatomic, assign) BOOL nonJson;//是否为非序列化属性（Default NO）
@property (nonatomic, assign) BOOL hasCusHandle;//是否自定义处理解析
@property (nonatomic) Class genericClass;//泛型（NSArray，NSSet）
@property (nonatomic, strong) NSDictionary *genericClassDict;//词典泛型（NSDictionary）

-(instancetype) initWithName:(NSString*) name typeName:(NSString*) typeName jsonName:(NSString*) jsonName nonJson:(BOOL) nonJson customHandle:(BOOL) cusHandle;
@property (nonatomic) Class customClass;

@end



/**
 *  Json 对象描述
 */
@interface ZYJSONObjectDesc : NSObject

-(NSArray*) allPropertys;

-(ZYJSONPropertyDesc*) getPropertyByName:(NSString*) propertyName;

-(ZYJSONPropertyDesc*) getPropertyByJsonName:(NSString*) jsonName;

-(instancetype) initWithProperty:(NSArray*) propertys;

@end
