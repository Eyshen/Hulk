//
//  AppBaseViewModel.h
//  WJCommon-master
//
//  Created by 吴云海 on 16-2-27.
//  Copyright (c) 2016年 WJ. All rights reserved.
//

#import "BaseWJViewModel.h"

/**
 *  应用程序ViewModel基类
 */
@interface AppBaseViewModel : BaseWJViewModel

@property(nonatomic, copy) NSDictionary *routerParams;

-(instancetype)initWithRouterParams:(NSDictionary*)params;

@end
