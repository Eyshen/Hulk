//
//  ZYJSONUtils.m
//
//     ___________ __      __
//    /\______   / \ \    / /
//    \/___  /  /   \ \  / /
//        / /  /     \ \/ /
//       / /  /       |  |
//      / /  /______  |  |
//     / /__________\ |__|
//
//  Created by Eason.zhangyi on 16/9/9.
//  Copyright (c) 2016年 ZY. All rights reserved.
//

#import "ZYJSONUtils.h"
#import "IZYJSONObject.h"
#import "NSObject+ZYJSON.h"
#import <objc/runtime.h>

static NSMutableDictionary *cacheJsonObjectDescs = nil;

//忽略属性名称列表
static NSSet *ignorePropertyNames = nil;
//数字类型名称列表
static NSSet *numberTypeNames = nil;

static NSDictionary *objectTypeDict;

@implementation ZYJSONUtils

+(void)load {
    cacheJsonObjectDescs = [[NSMutableDictionary alloc] init];
    ignorePropertyNames = [[NSSet alloc] initWithObjects:@"superclass",@"hash",@"debugDescription",@"description", nil];
    numberTypeNames = [[NSSet alloc] initWithObjects:@"B",@"i",@"I",@"d",@"D",@"c",@"C",@"f",@"l",@"L",@"s",@"S",@"q",@"Q", nil];
//    objectTypeDict = @{@"NSString":@(ZYObjectTypeString),
//                  @"NSNumber":@(ZYObjectTypeNumber),
//                  @"NSSet":@(ZYObjectTypeSet),
//                  @"NSArray":@(ZYObjectTypeArray),
//                  @"NSDictionary":@(ZYObjectTypeDictionary),
//                  @"NSDate":@(ZYObjectTypeDate),};
}

+(ZYObjectType)getType:(id)value {
    ZYObjectType t = ZYObjectTypeObject;
    if ([value isKindOfClass:[NSString class]]) {
        t = ZYObjectTypeString;
    } else if ([value isKindOfClass:[NSNumber class]]) {
        t = ZYObjectTypeNumber;
    } else if ([value isKindOfClass:[NSArray class]]) {
        t = ZYObjectTypeArray;
    } else if ([value isKindOfClass:[NSDictionary class]]) {
        t = ZYObjectTypeDictionary;
    } else if ([value isKindOfClass:[NSSet class]]) {
        t = ZYObjectTypeSet;
    } else if ([value isKindOfClass:[NSDate class]]) {
        t = ZYObjectTypeDate;
    } else if ([[value class] conformsToProtocol:@protocol(IZYJSONObject)]) {
        t = ZYObjectTypeCustom;
    }
    return t;
}

+(ZYJSONObjectDesc *)getJsonObjectDesc:(Class)clazz {
    ZYJSONObjectDesc *objectDesc = nil;
//    if (clazz != Nil && [clazz conformsToProtocol:@protocol(IZYJSONObject)]) {
    if (clazz != Nil) {
        NSString *clazzName = NSStringFromClass(clazz);
        objectDesc = cacheJsonObjectDescs[clazzName];
        if (!objectDesc) {
            NSMutableArray *propertys = [self getPropertys:clazz];
            objectDesc = [[ZYJSONObjectDesc alloc] initWithProperty:propertys];
            [cacheJsonObjectDescs setObject:objectDesc forKey:clazzName];
        }
    }
    return objectDesc;
}

+(NSMutableArray*) getPropertys:(Class) clazz {
    if (clazz == [NSObject class]) {
        return nil;
    } else {
        NSDictionary *map = [clazz zyPropertyToJsonPropertyDictionary];
        NSSet *customHandleSet = [clazz zyCustomParsePropertys];
        NSSet *nonJsonSet = [clazz zyNonJsonPropertys];
        NSDictionary *genericClassNameDict = [clazz zyContainerPropertysGenericClass];
        NSMutableArray *propertyList = [self getPropertys:[clazz superclass]];
        if (!propertyList) {
            propertyList = [[NSMutableArray alloc] init];
        }
        @autoreleasepool {
            unsigned int propertyCount = 0;
            objc_property_t *properties = class_copyPropertyList(clazz, &propertyCount);
            for (unsigned int i = 0; i < propertyCount; ++i) {
                objc_property_t property = properties[i];
                const char * name = property_getName(property);
                NSString *nameString = [NSString stringWithUTF8String:name];
                
                if ([ignorePropertyNames containsObject:nameString]) {
                    continue;
                }
                NSString *typeName = [self getPropertyTypeName:property];
                NSString *jsonName = map[nameString];
                if (!jsonName) {
                    jsonName = nameString;
                }
                BOOL isNonJson = NO;
                if ([nonJsonSet containsObject:nameString]) {
                    isNonJson = YES;
                }
                BOOL isCustomHandle = NO;
                if (customHandleSet && [customHandleSet containsObject:nameString]) {
                    isCustomHandle = YES;
                }
                ZYJSONPropertyDesc *desc = [[ZYJSONPropertyDesc alloc] initWithName:nameString typeName:typeName jsonName:jsonName nonJson:isNonJson customHandle:isCustomHandle];
                switch (desc.type) {
                    case ZYObjectTypeDate:
                        {
                            NSString *df = [clazz zyPropertyDateFormatString:nameString];
                            [desc setDateFormat:df];
                        }
                        break;
                    default:
                        break;
                }
                
                switch (desc.type) {
                    case ZYObjectTypeArray:
                        {
                            Class clazz = genericClassNameDict[nameString];
                            if ([clazz conformsToProtocol:@protocol(IZYJSONObject)]) {
                                [desc setGenericClass:clazz];
                            }
                        }
                        break;
                    case ZYObjectTypeSet:
                        {
                            Class clazz = genericClassNameDict[nameString];
                            if ([clazz conformsToProtocol:@protocol(IZYJSONObject)]) {
                                [desc setGenericClass:clazz];
                            }
                        }
                        break;
                    case ZYObjectTypeDictionary:
                        {
                            id value = genericClassNameDict[nameString];
                            if ([value isKindOfClass:[NSDictionary class]]) {
                                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                                NSArray *allKeys = [value allKeys];
                                for (NSString *key in allKeys) {
                                    Class clazz = value[key];
                                    if ([clazz conformsToProtocol:@protocol(IZYJSONObject)]) {
                                        [dict setObject:clazz forKey:key];
                                    }
                                }
                                if ([dict count] > 0) {
                                    [desc setGenericClassDict:dict];
                                }
                            }
                        }
                        break;
                    default:
                        break;
                }
                
                [propertyList addObject:desc];
            }
            free(properties);
        }
        return propertyList;
    }
}

+(NSString*) getPropertyTypeName:(objc_property_t) property {
    const char *attributes = property_getAttributes(property);
    NSString *attributeStr = [[NSString alloc] initWithBytes:attributes length:strlen(attributes) encoding:NSUTF8StringEncoding];
    NSString *a1 = [[[attributeStr componentsSeparatedByString:@","] objectAtIndex:0] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSString *typeName = nil;
    if ([a1 hasPrefix:@"T@"]) {
        typeName = [[NSString alloc] initWithString:[a1 substringWithRange:NSMakeRange(2, a1.length-2)]];
    } else {
        if (a1.length >= 2) {
            typeName = [a1 substringWithRange:NSMakeRange(1, a1.length-1)];
            if ([numberTypeNames containsObject:typeName]) {
                typeName = @"NSNumber";
            }
        }
    }
    return typeName;
}

@end
