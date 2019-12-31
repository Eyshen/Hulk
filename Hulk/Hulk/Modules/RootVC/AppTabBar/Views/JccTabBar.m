//
//  JccTabBar.m
//  ios-jucaicat
//
//  Created by 吴云海 on 16/9/14.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "JccTabBar.h"
#import "WJStackView.h"
#import "JccTabBarItem.h"
#import <Bugly/BuglyLog.h>

@interface JccTabBar ()

/**
 *  当前选择的索引号
 */
@property(nonatomic, assign) NSUInteger currentSelectedIndex;

/**
 *  背景视图
 */
@property(nonatomic, weak) UIImageView *bgImageView;

/**
 *  栈视图
 */
@property(nonatomic, weak) WJStackView *stackView;

@property(nonatomic, copy) JccTabBarActionBlock copyActionBlock;

@end

@implementation JccTabBar

-(void)setActionBlock:(JccTabBarActionBlock)actionBlock {
    self.copyActionBlock = actionBlock;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [_bgImageView setFrame:self.bounds];
    [_stackView setFrame:self.bounds];
}

-(void)wj_loadSubViews {
    [super wj_loadSubViews];
    if (!_bgImageView) {
        UIImageView *bg = [[UIImageView alloc] init];
        [self addSubview:bg];
        _bgImageView = bg;
        
        WJStackView *sv = [WJStackView wj_instance];
        [sv setAxis:WJStackViewAxisHorizontal];
        [self addSubview:sv];
        _stackView = sv;
    }
}

-(void)setOwnerTabBarController:(UITabBarController *)ownerTabBarController {
    if (_ownerTabBarController == ownerTabBarController) {
        return;
    }
    _ownerTabBarController = ownerTabBarController;
    [self.KVOController unobserveAll];
    if (_ownerTabBarController) {
        WJ_WEAK_REF_TYPE weakSelf = self;
        [self.KVOController observe:_ownerTabBarController keyPath:@"selectedIndex" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
//            if ([[weakSelf.appearance tabBarItemAppearances] count] == 5) {
            if ([[weakSelf.appearance tabBarItemAppearances] count] > 0) {
                weakSelf.currentSelectedIndex = weakSelf.ownerTabBarController.selectedIndex;
            } else {
                if (weakSelf.ownerTabBarController.selectedIndex > 1) {
                    weakSelf.currentSelectedIndex = weakSelf.ownerTabBarController.selectedIndex - 1;
                } else {
                    weakSelf.currentSelectedIndex = weakSelf.ownerTabBarController.selectedIndex;
                }
            }
        }];
    }
}

-(void)itemTouchDownExec:(id)sender {
    UIView *v = (UIView*)sender;
    NSInteger tag = [v tag] - 100;
    if (tag >= 0 && NULL != _copyActionBlock) {
        BLYLogInfo(@"tabbar selectedIndex:%li",(long)tag);
//        if ([[self.appearance tabBarItemAppearances] count] == 5) {
        if ([[self.appearance tabBarItemAppearances] count] > 0) {
            _copyActionBlock(tag);
        } else if (tag + 1 < [[_ownerTabBarController viewControllers] count]) {
            if (tag > 1) {
                _copyActionBlock(tag+1);
            } else {
                _copyActionBlock(tag);
            }
        }
    }
}

-(void)refreshUI {
    if (_appearance) {
        if ([_appearance backgroundColor]) {
            [self setBackgroundColor:[_appearance backgroundColor]];
        } else {
            [self setBackgroundColor:[UIColor clearColor]];
        }
        [self.bgImageView setImage:[_appearance backgroundImage]];
        
        NSArray *appearances = [_appearance tabBarItemAppearances];
        
        NSInteger subCount = [[_stackView arrangedSubviews] count];
        if ([appearances count] > subCount) {
            NSUInteger count = [[_stackView arrangedSubviews] count];
            for (NSUInteger i=count; i < [appearances count]; i++) {
                JccTabBarItem *item = [JccTabBarItem wj_instance];
                [_stackView addArrangedSubview:item];
                [item addTarget:self action:@selector(itemTouchDownExec:) forControlEvents:UIControlEventTouchDown];
                [item setTag:i+100];
            }
        } else if ([appearances count] < subCount) {
            NSUInteger len = [[_stackView arrangedSubviews] count] - [appearances count];
            NSArray *views = [[_stackView arrangedSubviews] subarrayWithRange:NSMakeRange([appearances count], len)];
            for (JccTabBarItem *item in views) {
                [_stackView removeArrangedSubview:item];
            }
        }
        NSArray *subViews = [_stackView arrangedSubviews];
        NSUInteger count = [subViews count];
        for (int i=0; i<count; i++) {
            JccTabBarItem *item = subViews[i];
            id<ITabBarItemAppearance> appearance  = appearances[i];
            [item setAppearance:appearance];
        }
        [self refreshSelectedItemUI];
    } else {
        NSArray *subViews = [_stackView arrangedSubviews];
        for (UIView *v in subViews) {
            [v removeFromSuperview];
        }
    }
}

-(void)refreshSelectedItemUI {
//    if ([[_appearance tabBarItemAppearances] count] == 5) {
    if ([[_appearance tabBarItemAppearances] count] > 0) {
        _currentSelectedIndex = _ownerTabBarController.selectedIndex;
    } else {
        if (_ownerTabBarController.selectedIndex > 1) {
            _currentSelectedIndex = _ownerTabBarController.selectedIndex - 1;
        } else {
            _currentSelectedIndex = _ownerTabBarController.selectedIndex;
        }
    }
    
    NSArray *subViews = [_stackView arrangedSubviews];
    NSUInteger count = [subViews count];
    for (int i = 0; i < count; i++) {
        JccTabBarItem *item = (JccTabBarItem*)subViews[i];
        [item setSelected:(_currentSelectedIndex==i)];
    }
}

-(NSArray *)wj_observableKeypaths {
    return @[@"currentSelectedIndex",@"appearance"];
}

-(void)wj_changeForKeypath:(NSString *)keyPath {
    if (WJ_STRING_EQUAL(keyPath, @"currentSelectedIndex")) {
        [self refreshSelectedItemUI];
    } else if (WJ_STRING_EQUAL(keyPath, @"appearance")) {
        [self refreshUI];
    }
}

@end
