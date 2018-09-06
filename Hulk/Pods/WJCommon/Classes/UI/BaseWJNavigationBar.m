//
//  BaseWJNavigationBar.m
//  WJCommon-master
//
//  Created by YunhaiWu on 2017/12/2.
//  Copyright © 2017年 WJ. All rights reserved.
//

#import "BaseWJNavigationBar.h"

@implementation BaseWJNavigationBar

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0
-(void)layoutSubviews {
    [super layoutSubviews];
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    for (UIView *view in self.subviews) {
        if([NSStringFromClass([view class]) containsString:@"Background"]) {
            [view setFrame:self.bounds];
        } else if ([NSStringFromClass([view class]) containsString:@"ContentView"]) {
            [view setFrame:CGRectMake(0, statusBarHeight, self.bounds.size.width, self.bounds.size.height-statusBarHeight)];
        }
    }
}
#endif

@end
