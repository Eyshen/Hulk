//
//  BaseModule.m
//  ios-jucaicat
//
//  Created by 吴云海 on 17/5/25.
//  Copyright © 2017年 wuyunhai. All rights reserved.
//

#import "BaseModule.h"
#import "WJUIRoutable.h"

@implementation BaseModule

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self routerMapAction];
    return YES;
}




/************************
 *  路由映射配置操作
 ************************
 */
- (void)routerMapAction {
    
}


@end
