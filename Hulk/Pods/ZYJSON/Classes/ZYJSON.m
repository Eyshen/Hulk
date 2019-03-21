//
//  ZYJSON.m
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

#import "ZYJSON.h"
#import "ZYJSONObjectDesc.h"
#import "ZYJSONUtils.h"

static NSDateFormatter *zyDateFormat = nil;

@implementation NSObject (ZYConverter)

+(void)load {
    zyDateFormat = [[NSDateFormatter alloc] init];
}

-(NSDictionary *)zyDictionary {
    NSMutableDictionary *dict = nil;
    if ([[self class] conformsToProtocol:@protocol(IZYJSONObject)]) {
        dict = [[NSMutableDictionary alloc] init];
        ZYJSONObjectDesc *objectDesc = [ZYJSONUtils getJsonObjectDesc:self.class];
        NSArray *propertys = [objectDesc allPropertys];
        for (ZYJSONPropertyDesc *desc in propertys) {
            if ([desc nonJson]) {
                continue;
            }
            id value = [self valueForKey:[desc name]];
            if (value && value != [NSNull null]) {
                id o = [[self class] toObjectValue:value propertyDesc:desc];
                if (o) {
                    [dict setObject:o forKey:desc.jsonName];
                }
            }
        }
    }
    return dict;
}

+(id) toObjectValue:(id) value propertyDesc:(ZYJSONPropertyDesc*) desc {
    ZYObjectType t = [desc type];
    id returnValue = nil;
    if (desc == nil) {
        t = [ZYJSONUtils getType:value];
    }
    switch (t) {
        case ZYObjectTypeArray:
            {
                Class genericClazz = [desc genericClass];
                NSMutableArray *array = [[NSMutableArray alloc] init];
                for (id o in value) {
                    if ([o isKindOfClass:[NSString class]] || [o isKindOfClass:[NSNumber class]]) {
                        [array addObject:o];
                    } else {
                        if (genericClazz) {
                            [array addObject:[o zyDictionary]];
                        } else {
                            [array addObject:[self toObjectValue:o propertyDesc:nil]];
                        }
                    }
                }
                returnValue = array;
            }
            break;
        case ZYObjectTypeSet:
            {
                Class genericClazz = [desc genericClass];
                NSMutableArray *array = [[NSMutableArray alloc] init];
                for (id o in value) {
                    if ([o isKindOfClass:[NSString class]] || [o isKindOfClass:[NSNumber class]]) {
                        [array addObject:o];
                    } else {
                        if (genericClazz) {
                            [array addObject:[o zyDictionary]];
                        } else {
                            [array addObject:[self toObjectValue:o propertyDesc:nil]];
                        }
                    }
                }
                returnValue = array;
            }
            break;
        case ZYObjectTypeDictionary:
            {
                NSDictionary *genericClazzDict = [desc genericClassDict];
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                NSArray *keys = [value allKeys];
                for (NSString *key in keys) {
                    id v = value[key];
                    if ([v isKindOfClass:[NSString class]] || [v isKindOfClass:[NSNumber class]]) {
                        [dict setObject:v forKey:key];
                    } else {
                        Class genericClazz = genericClazzDict[key];
                        if (genericClazz) {
                            [dict setObject:[v zyDictionary] forKey:key];
                        } else {
                            [dict setObject:[self toObjectValue:v propertyDesc:nil] forKey:key];
                        }
                    }
                }
                returnValue = dict;
            }
            break;
        case ZYObjectTypeDate:
            {
                NSString *dfs = [desc dateFormat];
                if (dfs) {
                    [zyDateFormat setDateFormat:dfs];
                    returnValue = [zyDateFormat stringFromDate:value];
                } else {
                    returnValue = value;
                }
            }
            break;
        
        case ZYObjectTypeNumber:
            {
                returnValue = value;
            }
            break;
        case ZYObjectTypeString:
            {
                returnValue = value;
            }
            break;
        case ZYObjectTypeCustom:
            {
                returnValue = [value zyDictionary];
            }
            break;
        default:
            {
                returnValue = value; //WJObjectTypeObject  对象类型如果不是实现了IWJJSONObject 协议则忽略转换
            }
            break;
    }
    
    return returnValue;
}

+(id) fromObject:(id) value propertyDesc:(ZYJSONPropertyDesc*) desc {
    ZYObjectType t = desc.type;
    id returnValue = nil;
    if (!desc) {
        t = [ZYJSONUtils getType:value];
    }
    switch (t) {
        case ZYObjectTypeArray:
            {
                Class genericClazz = [desc genericClass];
                NSMutableArray *array = [[NSMutableArray alloc] init];
                for (id o in value) {
                    if (genericClazz) {
                        id v = [[genericClazz alloc] zyInitWithDictionary:o];
                        if (v) {
                            [array addObject:v];
                        }
                    } else {
                        id v = [self fromObject:o propertyDesc:nil];
                        if (v) {
                            [array addObject:v];
                        }
                    }
                }
                returnValue = array;
            }
            break;
        case ZYObjectTypeSet:
            {
                Class genericClazz = [desc genericClass];
                NSMutableSet *set = [[NSMutableSet alloc] init];
                for (id o in value) {
                    if (genericClazz) {
                        id v = [[genericClazz alloc] zyInitWithDictionary:o];
                        if (v) {
                            [set addObject:v];
                        }
                    } else {
                        id v = [self fromObject:o propertyDesc:nil];
                        if (v) {
                            [set addObject:v];
                        }
                    }
                }
                returnValue = set;
            }
            break;
        case ZYObjectTypeDate:
            {
                NSString *dfs = [desc dateFormat];
                if (dfs) {
                    [zyDateFormat setDateFormat:dfs];
                    returnValue = [zyDateFormat stringFromDate:value];
                }
            }
            break;
        case ZYObjectTypeNumber:
            {
                returnValue = value;
            }
            break;
        case ZYObjectTypeString:
            {
                returnValue = value;
            }
            break;
        case ZYObjectTypeDictionary:
            {
                NSDictionary *genericClazzDict = [desc genericClassDict];
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                NSArray *allKeys = [value allKeys];
                for (NSString *key in allKeys) {
                    id o = value[key];
                    Class genericClazz = genericClazzDict[key];
                    id v = nil;
                    if (genericClazz && [o isKindOfClass:[NSDictionary class]]) {
                        v = [[genericClazz alloc] zyInitWithDictionary:o];
                    } else {
                        v = [self fromObject:o propertyDesc:nil];
                    }
                    if (v) {
                        [dict setObject:v forKey:key];
                    }
                }
                returnValue = dict;
            }
            break;
        case ZYObjectTypeCustom:
            {
                Class clazz = NSClassFromString(desc.typeName);
                returnValue = [[clazz alloc] zyInitWithDictionary:value];
            }
            break;
        default:
            {
                returnValue = value; //ZYObjectTypeObject
            }
            break;
    }
    return returnValue;
}

-(instancetype)zyInitWithDictionary:(NSDictionary *)dictionary {
    if ([self init]) {
        ZYJSONObjectDesc *objectDesc = [ZYJSONUtils getJsonObjectDesc:self.class];
        NSArray *allPropertys = [objectDesc allPropertys];
        for (ZYJSONPropertyDesc *property in allPropertys) {
            id value = dictionary[property.jsonName];
            if (value && value != [NSNull null]) {
                if ([property hasCusHandle]) {
                    [self zyCustomParseProperty:property.name value:value];
                } else {
                    id returnValue = [[self class] fromObject:value propertyDesc:property];
                    if (returnValue && (returnValue != [NSNull null])) {
                        [self setValue:returnValue forKey:property.name];
                    }
                }
            }
        }
    }
    return self;
}

@end

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////

@implementation ZYJSON

+(NSData*) toJson:(id) object {
    if (object) {
        id o = object;
        if (![NSJSONSerialization isValidJSONObject:object]) {
            o = [self toObjectValue:object propertyDesc:nil];
        }
        if (o) {
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:o options:NSJSONWritingPrettyPrinted error:&error];
            if (error) {
                @throw [NSException exceptionWithName:@"ZYJSONException" reason:[error userInfo][NSLocalizedDescriptionKey] userInfo:[error userInfo]];
            } else {
                return jsonData;
            }
        }
    }
    return nil;
}
 +(NSString*) toJsonString:(id) object {
    NSData *data = [self toJson:object];
    if (data) {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

+(id) fromJsonString:(NSString*) json type:(Class) type {
    if (json) {
        return [self fromJsonData:[json dataUsingEncoding:NSUTF8StringEncoding] type:type];
    }
    return nil;
}

+(id)fromJsonData:(NSData *)json type:(Class)type {
    if (json) {
        if ([type conformsToProtocol:@protocol(IZYJSONObject)]) {
            NSError *error;
            id o = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:&error];
            if (error) {
                @throw [NSException exceptionWithName:@"ZYJSONException" reason:[error userInfo][NSLocalizedDescriptionKey] userInfo:[error userInfo]];
            } else {
                if (![o isKindOfClass:[NSDictionary class]]) {
                    NSString *reason = [NSString stringWithFormat:@"%@ 类型无法解析此json",NSStringFromClass(type)];
                    @throw [NSException exceptionWithName:@"ZYJSONException" reason:reason userInfo:@{NSLocalizedDescriptionKey:reason}];
                } else {
                    return [[type alloc] zyInitWithDictionary:o];
                }
            }
        } else {
            NSString *reason = @"非IZYJSONObject对象";
            @throw [NSException exceptionWithName:@"ZYJSONException" reason:reason userInfo:@{NSLocalizedDescriptionKey:reason}];
        }
    }
    return nil;
}

+(id) fromJsonString:(NSString*) json groupType:(ZYJSONGroupType*) groupType {
    if (json) {
        return [self fromJsonData:[json dataUsingEncoding:NSUTF8StringEncoding] groupType:groupType];
    }
    return nil;
}

+(id) fromJsonData:(NSData*) json groupType:(ZYJSONGroupType*) groupType {
    if (json) {
        NSError *error = nil;
        id o = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:&error];
        if (error) {
            @throw [NSException exceptionWithName:@"ZYJSONException" reason:[error userInfo][NSLocalizedDescriptionKey] userInfo:[error userInfo]];
        } else {
            if (![o isKindOfClass:[NSArray class]]) {
                NSString *reason = [NSString stringWithFormat:@"%@ 类型无法解析此json",NSStringFromClass([groupType collectionClass])];
                @throw [NSException exceptionWithName:@"ZYJSONException" reason:reason userInfo:@{NSLocalizedDescriptionKey:reason}];
            } else {
                Class elementClass = [groupType elementClass];
                if ([[groupType collectionClass] isSubclassOfClass:[NSArray class]]) {
                    NSMutableArray *array = [[NSMutableArray alloc] init];
                    for (id item in o) {
                        if ([item isKindOfClass:[NSDictionary class]]) {
                            [array addObject:[[elementClass alloc] zyInitWithDictionary:item]];
                        } else {
                            [array addObject:item];
                        }
                    }
                    return array;
                } else if ([[groupType collectionClass] isSubclassOfClass:[NSSet class]]) {
                    NSMutableSet *set = [[NSMutableSet alloc] init];
                    for (id item in o) {
                        if ([item isKindOfClass:[NSDictionary class]]) {
                            [set addObject:[[elementClass alloc] zyInitWithDictionary:item]];
                        } else {
                            [set addObject:item];
                        }
                    }
                    return set;
                }
            }
        }
    }
    return nil;
}

+(id) fromJsonString:(NSString*) json {
    if (json) {
        return [self fromJsonData:[json dataUsingEncoding:NSUTF8StringEncoding]];
    }
    return nil;
}

+(id) fromJsonData:(NSData*)jsonData {
    if (jsonData) {
        NSError *error = nil;
        id o = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        if (error) {
            @throw [NSException exceptionWithName:@"ZYJSONException" reason:[error userInfo][NSLocalizedDescriptionKey] userInfo:[error userInfo]];
        } else {
            return o;
        }
    }
    return nil;
}

@end
