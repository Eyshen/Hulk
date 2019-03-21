//
//  NSObject+ZYJSON.m
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

#import "NSObject+ZYJSON.h"

@implementation NSObject (ZYJSON)

/**
 *  属性到JSON属性名称映射
 */
+(NSDictionary*) zyPropertyToJsonPropertyDictionary {
    return nil;
}

/**
 *  非JSON属性列表
 */
+(NSSet*) zyNonJsonPropertys {
    return nil;
}

/**
 *  容器属性类型
 *  key：属性名称
 *  value：类型（Class）支持NSDictionary，NSSet，NSArray
 */
+(NSDictionary*) zyContainerPropertysGenericClass {
    return nil;
}

+(NSString *)zyPropertyDateFormatString:(NSString *)property {
    return @"YYYY-MM-dd'T'HH:mm:ssZ";//Default ISO8601
}

/**
 *  自定义解析属性集合
 *
 *  @return 数据名称集合
 */
+(NSSet*) zyCustomParsePropertys {
    return nil;
}

/**
 *  自定义处理属性（只有wjCustomParsePropertys返回有属性需要自定义处理时才触发）
 *
 *  @param property 属性名称
 *  @param object   对应值
 */
-(void) zyCustomParseProperty:(NSString*) property value:(id) object {}


@end
