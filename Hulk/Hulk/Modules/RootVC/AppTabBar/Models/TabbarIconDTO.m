//
//  TabbarIconDTO.m
//  ios-jucaicat
//
//  Created by 吴云海 on 17/6/7.
//  Copyright © 2017年 wuyunhai. All rights reserved.
//

#import "TabbarIconDTO.h"

@implementation TabbarIconDTO

-(NSString*)normalIconFileName {
    if (self.normalImgUrl) {
        NSString *md5 = WJ_SECURITY_MD5([self.normalImgUrl dataUsingEncoding:NSUTF8StringEncoding]);
        NSString *extension = [self.normalImgUrl pathExtension];
        if (md5 && extension) {
            return [NSString stringWithFormat:@"%@.%@",md5,extension];
        }
    }
    return nil;
}

-(NSString*)selectedIconFileName {
    if (self.selectedImgUrl) {
        NSString *md5 = WJ_SECURITY_MD5([self.selectedImgUrl dataUsingEncoding:NSUTF8StringEncoding]);
        NSString *extension = [self.selectedImgUrl pathExtension];
        if (md5 && extension) {
            return [NSString stringWithFormat:@"%@.%@",md5,extension];
        }
    }
    return nil;
}

@end
