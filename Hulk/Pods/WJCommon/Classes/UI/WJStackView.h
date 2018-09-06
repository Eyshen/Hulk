//
//  WJStackView.h
//  WJCommon-master
//
//  Created by 吴云海 on 16/6/12.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "BaseWJView.h"

typedef NS_ENUM(NSInteger, WJStackViewAxis) {
    WJStackViewAxisHorizontal,
    WJStackViewAxisVertical,
};


/**
 *  由于UIStackView 9.0 才支持，所以先使用一个简单的替换
 */
@interface WJStackView : BaseWJView

@property (nonatomic, assign) WJStackViewAxis axis;

- (NSArray*)arrangedSubviews;

- (void)removeArrangedSubview:(UIView*) view;

- (void)addArrangedSubview:(UIView *)view;

@end
