//
//  QueryTabbarIconResDTO.m
//  ios-jucaicat
//
//  Created by 吴云海 on 17/6/7.
//  Copyright © 2017年 wuyunhai. All rights reserved.
//

#import "QueryTabbarIconResDTO.h"
#import "IconUrlUtils.h"

@implementation QueryTabbarIconResDTO

+(NSDictionary *)wjContainerPropertysGenericClass {
    return @{@"icons":[TabbarIconDTO class]};
}

-(NSString *)backgroundImgFileName {
    if (self.backgroundImgUrl) {
        NSString *md5 = WJ_SECURITY_MD5([self.backgroundImgUrl dataUsingEncoding:NSUTF8StringEncoding]);
        NSString *extension = [self.backgroundImgUrl pathExtension];
        if (md5 && extension) {
            return [NSString stringWithFormat:@"%@.%@",md5,extension];
        }
    }
    return nil;
}

-(void)changeScaleImageUrlAction {
    if (WJ_STRING_IS_NOT_EMPTY(_backgroundImgUrl)) {
        NSString *url = [IconUrlUtils formatSuitableUrl:_backgroundImgUrl];
        self.backgroundImgUrl = url;
    }
    if ([_icons count] > 0) {
        for (TabbarIconDTO *iconDTO in _icons) {
            if (WJ_STRING_IS_NOT_EMPTY([iconDTO normalImgUrl])) {
                [iconDTO setNormalImgUrl:[IconUrlUtils formatSuitableUrl:[iconDTO normalImgUrl]]];
            }
            if (WJ_STRING_IS_NOT_EMPTY([iconDTO selectedImgUrl])) {
                [iconDTO setSelectedImgUrl:[IconUrlUtils formatSuitableUrl:[iconDTO selectedImgUrl]]];
            }
        }
    }
}

@end
