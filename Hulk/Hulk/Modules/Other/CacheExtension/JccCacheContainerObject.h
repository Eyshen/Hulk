//
//  JccCacheContainerObject.h
//  ios-jucaicat
//
//  Created by 吴云海 on 16/8/25.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "AppBaseDTO.h"

/**
 *  缓存容器对象
 */
@interface JccCacheContainerObject : AppBaseDTO

/**
 *  版本号
 */
@property(nonatomic, copy) NSString *versionId;

/**
 *  用户码
 */
@property(nonatomic, copy) NSString *userCode;

/**
 *  创建时间
 */
@property(nonatomic, assign) NSTimeInterval createtTime;

/**
 *  数据
 */
@property(nonatomic, copy) id data;

-(instancetype)initWithData:(id)data;

@end
