//
//  ZYJSONGroupType.m
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

#import "ZYJSONGroupType.h"
#import "IZYJSONObject.h"

@interface ZYJSONGroupType ()
@property (nonatomic, readwrite) Class collectionClass;
@property (nonatomic, readwrite) Class elementClass;
@end
@implementation ZYJSONGroupType

-(Class) collectionClass {
    return _collectionClass;
}

-(Class) elementClass {
    return _elementClass;
}

+(ZYJSONGroupType *)createCollectionClass:(Class)collectionClass elementClass:(Class)elementClass {
    if (![collectionClass isSubclassOfClass:[NSArray class]] && ![collectionClass isSubclassOfClass:[NSSet class]]) {
        NSString *reason = @"collectionClass必须是NSArray，NSSet类型";
        @throw [[NSException alloc] initWithName:@"ZYJSONGroupTypeException" reason:reason userInfo:@{NSLocalizedDescriptionKey:reason}];
        return nil;
    }
    if (![elementClass conformsToProtocol:@protocol(IZYJSONObject)]) {
        NSString *reason = @"elementClass必须是IZYJSONObject类型";
        @throw [[NSException alloc] initWithName:@"ZYJSONGroupTypeException" reason:reason userInfo:@{NSLocalizedDescriptionKey:reason}];
        return nil;
    }
    ZYJSONGroupType *type = [[ZYJSONGroupType alloc] init];
    [type setCollectionClass:collectionClass];
    [type setElementClass:elementClass];
    return type;
}

@end
