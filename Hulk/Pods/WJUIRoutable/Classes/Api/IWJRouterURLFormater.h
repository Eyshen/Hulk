//
//  IWJRouterURLFormater.h
//  WJUIRoutable-example
//
//  Created by 吴云海 on 17/5/22.
//  Copyright © 2017年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IWJRouterURLFormater <NSObject>

- (NSString*)formatRouterURL:(NSString*)routerURL;

@end
