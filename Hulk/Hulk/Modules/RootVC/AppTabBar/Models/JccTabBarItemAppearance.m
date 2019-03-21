//
//  JccTabBarItemAppearance.m
//  ios-jucaicat
//
//  Created by 吴云海 on 16/9/14.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "JccTabBarItemAppearance.h"

@implementation JccTabBarItemAppearance

#pragma mark ITabBarItemAppearance
-(UIImage*)normalIcon {
    UIImage *img = nil;
    if (_normalIconName) {
        img = [UIImage imageNamed:_normalIconName];
    } else if (WJ_FILE_EXIST(_normalIconPath)) {
        img = [UIImage imageWithContentsOfFile:_normalIconPath];
    }
    return img;
}

-(UIImage*)selectedIcon {
    UIImage *img = nil;
    if (_selectedIconName) {
        img = [UIImage imageNamed:_selectedIconName];
    } else if (WJ_FILE_EXIST(_selectedIconPath)) {
        img = [UIImage imageWithContentsOfFile:_selectedIconPath];
    }
    return img;
}

-(NSString*)normalTitle {
    return _normalTitle;
}

-(NSString*)selectedTitle {
    return _selectedTitle;
}

-(BOOL)isVenue {
    return _isVenue;
}

-(NSUInteger)unreadMsgCount {
    return _unreadMsgCount;
}

@end
