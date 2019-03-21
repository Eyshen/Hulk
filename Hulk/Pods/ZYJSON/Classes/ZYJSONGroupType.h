//
//  ZYJSONGroupType.h
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
 *  组类型
 */
@interface ZYJSONGroupType : NSObject

/**
 *  元素类型
 */
-(Class) elementClass;

/**
 *  集合类型
 */
-(Class) collectionClass;

/**
 *  创建方法
 */
+(ZYJSONGroupType*) createCollectionClass:(Class) collectionClass elementClass:(Class)elementClass;

@end
