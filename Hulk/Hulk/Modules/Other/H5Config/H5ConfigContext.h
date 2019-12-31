//
//  H5ConfigContext.h
//  ios-jucaicat
//
//  Created by 吴云海 on 16/8/26.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "AbstractWJBusinessObject.h"
#import "WJSingleton.h"
#import "H5URLNameDefine.h"

#define JCC_FEETCH_H5_URL(name)     ([[H5ConfigContext sharedInstance] fetchH5URL:name])


/**
 *  H5配置环境
 */
@interface H5ConfigContext : AbstractWJBusinessObject

AS_SINGLETON(H5ConfigContext)

/**
 *  获取H5链接
 *
 *  @param h5Name h5名称
 */
-(NSString*)fetchH5URL:(NSString*)h5Name;

@end
