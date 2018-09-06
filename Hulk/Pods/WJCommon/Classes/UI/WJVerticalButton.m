//
//  WJVerticalButton.m
//  WJCommon-master
//
//  Created by 吴云海 on 16/9/27.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "WJVerticalButton.h"
#import "WJStringUtils.h"
#import "NSString+WJCalculateSize.h"

@implementation WJVerticalButton

-(void)wj_loadSubViews {
    [super wj_loadSubViews];
    [self wj_setFont:self.titleLabel.font];
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)refreshUI {
    UIImage *img = [self imageForState:self.state];
    NSString *t = [self titleForState:self.state];
    
    
    CGSize imgSize = CGSizeZero;
    CGSize titleSize = CGSizeZero;
    if (img) imgSize = [img size];
    if (t) titleSize = [t wj_sizeWithFont:self.titleLabel.font boundingSize:CGSizeMake(self.bounds.size.width, self.bounds.size.height) mode:NSLineBreakByWordWrapping];
    
    UIEdgeInsets titleEdge = UIEdgeInsetsMake((imgSize.height+_spacing+titleSize.height)/2.0f + (imgSize.height-titleSize.height)/2, -imgSize.width, 0, 0);
    [self setTitleEdgeInsets:titleEdge];
    UIEdgeInsets imgEdge = UIEdgeInsetsMake(-(imgSize.height+_spacing+titleSize.height)/2.0f + (imgSize.height-titleSize.height)/2, 0, 0, -titleSize.width);
    [self setImageEdgeInsets:imgEdge];
}

-(void)wj_setFont:(UIFont *)font {
    [self.titleLabel setFont:font];
    [self refreshUI];
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
    if (self.state == state) {
        [self refreshUI];
    }
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    if (self.state == state) {
        [self refreshUI];
    }
}

-(NSArray *)wj_observableKeypaths {
    return @[@"highlighted",@"spacing",@"selected",@"enabled"];
}

-(void)wj_changeForKeypath:(NSString *)keyPath {
    if (WJ_STRING_EQUAL(keyPath, @"highlighted") || WJ_STRING_EQUAL(keyPath, @"selected") || WJ_STRING_EQUAL(keyPath, @"enabled") || WJ_STRING_EQUAL(keyPath, @"spacing")) {
        [self refreshUI];
    }
}

@end
