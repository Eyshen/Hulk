//
//  WJRouterOptions.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/8/24.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import "WJRouterOptions.h"
#import "IWJRouterViewControllerDelegate.h"
#import "WJUIRoutableConfig.h"

@implementation WJRouterOptions
+ (instancetype)routerOptionsWithPresentationStyle: (UIModalPresentationStyle)presentationStyle
                                   transitionStyle: (UIModalTransitionStyle)transitionStyle
                                     defaultParams: (NSDictionary *)defaultParams
                                           isModal: (BOOL)isModal {
    WJRouterOptions *options = [[WJRouterOptions alloc] init];
    options.presentationStyle = presentationStyle;
    options.transitionStyle = transitionStyle;
    options.defaultParams = defaultParams;
    options.modal = isModal;
    
    Class navControllerClazz = [[WJUIRoutableConfig sharedInstance] defaultNavigationControllerClass];
    if (navControllerClazz) {
        options.navigationControllerClass = navControllerClazz;
    } else {
        options.navigationControllerClass = [UINavigationController class];
    }
    
    return options;
}
+ (instancetype)routerOptions {
    return [self routerOptionsWithPresentationStyle:UIModalPresentationNone
                                    transitionStyle:UIModalTransitionStyleCoverVertical
                                      defaultParams:nil
                                            isModal:NO];
}
+ (instancetype)routerOptionsAsModal {
    return [self routerOptionsWithPresentationStyle:UIModalPresentationNone
                                    transitionStyle:UIModalTransitionStyleCoverVertical
                                      defaultParams:nil
                                            isModal:YES];
}
+ (instancetype)routerOptionsWithPresentationStyle:(UIModalPresentationStyle)style {
    return [self routerOptionsWithPresentationStyle:style
                                    transitionStyle:UIModalTransitionStyleCoverVertical
                                      defaultParams:nil
                                            isModal:NO];
}
+ (instancetype)routerOptionsWithTransitionStyle:(UIModalTransitionStyle)style {
    return [self routerOptionsWithPresentationStyle:UIModalPresentationNone
                                    transitionStyle:style
                                      defaultParams:nil
                                            isModal:NO];
}
+ (instancetype)routerOptionsForDefaultParams:(NSDictionary *)defaultParams {
    return [self routerOptionsWithPresentationStyle:UIModalPresentationNone
                                    transitionStyle:UIModalTransitionStyleCoverVertical
                                      defaultParams:defaultParams
                                            isModal:NO];
}
+ (instancetype)routerOptionsAsRoot {
    return [self routerOptionsWithPresentationStyle:UIModalPresentationNone
                                    transitionStyle:UIModalTransitionStyleCoverVertical
                                      defaultParams:nil
                                            isModal:NO];
}
+ (instancetype)modal {
    return [self routerOptionsAsModal];
}
+ (instancetype)withPresentationStyle:(UIModalPresentationStyle)style {
    return [self routerOptionsWithPresentationStyle:style];
}
+ (instancetype)withTransitionStyle:(UIModalTransitionStyle)style {
    return [self routerOptionsWithTransitionStyle:style];
}
+ (instancetype)forDefaultParams:(NSDictionary *)defaultParams {
    return [self routerOptionsForDefaultParams:defaultParams];
}
- (WJRouterOptions *)modal {
    [self setModal:YES];
    return self;
}
- (WJRouterOptions *)withPresentationStyle:(UIModalPresentationStyle)style {
    [self setPresentationStyle:style];
    return self;
}
- (WJRouterOptions *)withTransitionStyle:(UIModalTransitionStyle)style {
    [self setTransitionStyle:style];
    return self;
}
- (WJRouterOptions *)forDefaultParams:(NSDictionary *)defaultParams {
    [self setDefaultParams:defaultParams];
    return self;
}
@end
