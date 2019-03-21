//
//  ZYJSONUtils.h
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

#import <Foundation/Foundation.h>
#import "ZYJSONObjectDesc.h"

@interface ZYJSONUtils : NSObject

+(ZYJSONObjectDesc*) getJsonObjectDesc:(Class) clazz;

+(ZYObjectType) getType:(id) value;

@end
