//
//  WJNetworkContextConfig.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by 吴云海 on 15-12-27.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import "AbstractWJBusinessObject.h"
#import "WJSingleton.h"

/**
 *  网络环境配置
 */
@interface WJNetworkContextConfig : AbstractWJBusinessObject

/**
 *  检测是否已联网host
 *  default www.baidu.com
 */
@property (nonatomic, copy, readonly) NSString *serverHost;

AS_SINGLETON(WJNetworkContextConfig)

-(void) setCheckServerHost:(NSString*) host;

@end
