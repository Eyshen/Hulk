//
//  JccDiskCache.h
//  ios-jucaicat
//
//  Created by 吴云海 on 16/9/28.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "AbstractWJBusinessObject.h"
#import "WJSingleton.h"
#import "WJCacheAPI.h"

/**
 *  硬盘缓存
 */
@interface JccDiskCache : AbstractWJBusinessObject<IWJCache>

AS_SINGLETON(JccDiskCache)

@end
