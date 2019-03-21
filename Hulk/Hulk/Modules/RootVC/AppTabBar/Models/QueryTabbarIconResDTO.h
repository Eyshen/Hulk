//
//  QueryTabbarIconResDTO.h
//  ios-jucaicat
//
//  Created by 吴云海 on 17/6/7.
//  Copyright © 2017年 wuyunhai. All rights reserved.
//

#import "AppBaseDTO.h"
#import "TabbarIconDTO.h"

@interface QueryTabbarIconResDTO : AppBaseDTO

@property(nonatomic, assign) int changeTag;

@property(nonatomic, copy) NSArray *icons;

@property(nonatomic, copy) NSString *backgroundImgUrl;

@property(nonatomic, copy) NSString *backgroundColorHex;

-(NSString*)backgroundImgFileName;

//变更拉伸图片url操作
-(void)changeScaleImageUrlAction;

@end
