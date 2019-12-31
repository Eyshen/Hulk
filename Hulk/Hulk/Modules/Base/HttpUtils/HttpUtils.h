//
//  HttpUtils.h
//  ios-jucaicat
//
//  Created by 吴云海 on 17/7/12.
//  Copyright © 2017年 wuyunhai. All rights reserved.
//

#import <Foundation/Foundation.h>

//http 请求参数工具
@interface HttpUtils : NSObject

//生成带用户消息
+(NSDictionary*)generateSignParams:(NSDictionary*)params;

//生成http头
+(NSDictionary*)generateHeaders;

@end
