//
//  ZYJSONObjectDesc.m
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

#import "ZYJSONObjectDesc.h"
#import "IZYJSONObject.h"

@implementation ZYJSONPropertyDesc

-(void)setTypeName:(NSString *)typeName {
    _typeName = [typeName copy];
    if ([typeName isEqualToString:@"NSDate"]) {
        _type = ZYObjectTypeDate;
    } else if ([typeName isEqualToString:@"NSString"]) {
        _type = ZYObjectTypeString;
    } else if ([typeName isEqualToString:@"NSNumber"]) {
        _type = ZYObjectTypeNumber;
    } else if ([typeName isEqualToString:@"NSSet"]) {
        _type = ZYObjectTypeSet;
    } else if ([typeName isEqualToString:@"NSArray"]) {
        _type = ZYObjectTypeArray;
    } else if ([typeName isEqualToString:@"NSDictionary"]) {
        _type = ZYObjectTypeDictionary;
    } else {
        if ([NSClassFromString(typeName) conformsToProtocol:@protocol(IZYJSONObject)]) {
            _type = ZYObjectTypeCustom;
        } else {
            _type = ZYObjectTypeObject;
        }
    }
}

-(instancetype) initWithName:(NSString*) name typeName:(NSString*) typeName jsonName:(NSString*) jsonName nonJson:(BOOL) nonJson customHandle:(BOOL) cusHandle {
    self = [super init];
    if (self) {
        self.name = name;
        self.typeName = typeName;
        self.jsonName = jsonName;
        self.nonJson = nonJson;
        self.hasCusHandle = cusHandle;
    }
    return self;
}

-(BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[ZYJSONPropertyDesc class]]) {
        if ([_name isEqualToString:[(ZYJSONPropertyDesc*)object name]]) {
            return YES;
        }
    }
    return NO;
}

-(NSUInteger)hash {
    return _name.hash;
}

@end



@interface ZYJSONObjectDesc ()

@property (nonatomic, copy) NSArray *propertys;

@property (nonatomic, strong) NSMutableDictionary *jnToPropertyDict;

@property (nonatomic, strong) NSMutableDictionary *nToPropertyDict;

@end
@implementation ZYJSONObjectDesc

-(NSArray*) allPropertys {
    return _propertys;
}

-(ZYJSONPropertyDesc*) getPropertyByName:(NSString*) propertyName {
    return _nToPropertyDict[propertyName];
}

-(ZYJSONPropertyDesc*) getPropertyByJsonName:(NSString*) jsonName {
    return _jnToPropertyDict[jsonName];
}

-(instancetype) initWithProperty:(NSArray*) propertys {
    self = [super init];
    if (self) {
        self.propertys = propertys;
        if ([self.propertys count] > 0) {
            self.jnToPropertyDict = [[NSMutableDictionary alloc] init];
            self.nToPropertyDict = [[NSMutableDictionary alloc] init];
        }
        for (ZYJSONPropertyDesc *desc in self.propertys) {
            [self.jnToPropertyDict setObject:desc forKey:[desc jsonName]];
            [self.nToPropertyDict setObject:desc forKey:[desc name]];
        }
    }
    return self;
}
@end
