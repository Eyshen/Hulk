//
//  JccTabBarAppearance.m
//  ios-jucaicat
//
//  Created by 吴云海 on 16/9/14.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "JccTabBarAppearance.h"

@implementation JccTabBarAppearance

#pragma mark ITabBarAppearance
-(UIImage*)backgroundImage {
    if (WJ_FILE_EXIST(_backgroundPath)) {
        return [UIImage imageWithContentsOfFile:_backgroundPath];
    }
    return nil;
}

-(UIColor*)backgroundColor {
    if (_backgroundColorHexString) {
        return WJ_COLOR_HEX_STRING(_backgroundColorHexString);
    }
    return nil;
}

-(NSArray*)tabBarItemAppearances {
    return _tabBarItemAppearances;
}

@end
