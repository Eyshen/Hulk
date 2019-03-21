//
//  TabbarIconDTO.h
//  ios-jucaicat
//
//  Created by 吴云海 on 17/6/7.
//  Copyright © 2017年 wuyunhai. All rights reserved.
//

#import "AppBaseDTO.h"

@interface TabbarIconDTO : AppBaseDTO

//0:普通功能icon  1:活动icon
@property(nonatomic, assign) int iconType;

//0:不需要登录  1:需要登录
@property(nonatomic, assign) int needLogin;

@property(nonatomic, copy) NSString *normalImgUrl;

@property(nonatomic, copy) NSString *selectedImgUrl;

@property(nonatomic, copy) NSString *targetUrl;

@property(nonatomic, copy) NSString *targetTitle;

@property(nonatomic, copy) NSString *selectedTitle;

@property(nonatomic, copy) NSString *normalTitle;

-(NSString*)normalIconFileName;

-(NSString*)selectedIconFileName;

@end
