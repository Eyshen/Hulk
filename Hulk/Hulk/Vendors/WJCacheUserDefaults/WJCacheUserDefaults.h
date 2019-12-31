//
//  WJCacheUserDefaults.h
//  WJCacheUserDefaults-example
//
//  Created by 吴云海 on 16/9/27.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "AbstractWJBusinessObject.h"
#import "WJSingleton.h"
#import "WJCacheAPI.h"

/**
 *  基于NSUserDefaults实现
 */
@interface WJCacheUserDefaults : AbstractWJBusinessObject<IWJCache>

AS_SINGLETON(WJCacheUserDefaults)


@end
