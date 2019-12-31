//
//  JccTabBarItem.m
//  ios-jucaicat
//
//  Created by 吴云海 on 16/9/19.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "JccTabBarItem.h"

#define JCC_TABBAR_HEIGHT   49.0f
#define JCC_TABBAR_ITEM_TITLE_NORMAL_COLOR      WJ_COLOR_RGBA(151, 151, 151, 1)
#define JCC_TABBAR_ITEM_TITLE_SELECTED_COLOR    WJ_COLOR_RGBA(231, 68, 68, 1)
#define JCC_TABBAR_ITEM_TITLE_FONT_SIZE         10

@interface JccTabBarItem ()

@property(nonatomic, weak) UIButton *btn;

@property(nonatomic, weak) UIImageView *icon;

@property(nonatomic, weak) UILabel *title;

@property(nonatomic, weak) UIImageView *venueIcon;

@property(nonatomic, weak) UIImageView *existMsgIcon;

@end

@implementation JccTabBarItem

-(void)layoutSubviews {
    [super layoutSubviews];
    [_btn setFrame:CGRectMake((self.width-JCC_TABBAR_HEIGHT)/2, 0, JCC_TABBAR_HEIGHT, JCC_TABBAR_HEIGHT)];
    [_venueIcon setFrame:CGRectMake((self.width-JCC_TABBAR_HEIGHT)/2, 0, JCC_TABBAR_HEIGHT, JCC_TABBAR_HEIGHT)];
    [_icon setFrame:CGRectMake((self.width-25.0f)/2, 8, 22.0f, 22.0f)];
    [_title setFrame:CGRectMake(2, 35.0f, self.width-4, 10)];
    [_existMsgIcon setFrame:CGRectMake(_icon.rightTopX, _icon.rightTopY, 10, 10)];
}

-(void)wj_loadSubViews {
    if (!_btn) {
        UIImageView *icon = [[UIImageView alloc] init];
        [icon setTag:19999];
        [self addSubview:icon];
        _icon = icon;
        
        UILabel *label = [[UILabel alloc] init];
        [label setTag:20000];
        [label setFont:[UIFont fontWithName:APP_FONT_NAME size:JCC_TABBAR_ITEM_TITLE_FONT_SIZE]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setBackgroundColor:[UIColor clearColor]];
        [self addSubview:label];
        _title = label;
        
        UIImageView *venueIcon = [[UIImageView alloc] init];
        [venueIcon setTag:20001];
        [self addSubview:venueIcon];
        _venueIcon = venueIcon;
        
        UIImageView *existMsg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"message-redtag"]];
        [existMsg setTag:20002];
        [self addSubview:existMsg];
        _existMsgIcon = existMsg;
        
        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
        [b setTitle:nil forState:UIControlStateNormal];
        [self addSubview:b];
        _btn = b;
    }
    [self setBackgroundColor:[UIColor clearColor]];
}

-(void)setTag:(NSInteger)tag {
    [super setTag:tag];
    [_btn setTag:tag];
}

-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    [_btn addTarget:target action:action forControlEvents:controlEvents];
}

-(void)refreshUI {
    if (_appearance) {
        [_icon setHidden:[_appearance isVenue]];
        [_title setHidden:[_appearance isVenue]];
        [_venueIcon setHidden:![_appearance isVenue]];
        [_icon setImage:[_appearance normalIcon]];
        [_icon setHighlightedImage:[_appearance selectedIcon]];
        [_venueIcon setImage:[_appearance normalIcon]];
        [_venueIcon setHighlightedImage:[_appearance selectedIcon]];
        [_title setText:_selected?[_appearance selectedTitle]:[_appearance normalTitle]];
        [_venueIcon setHighlighted:_selected];
        [_icon setHighlighted:_selected];
        [_title setTextColor:_selected?JCC_TABBAR_ITEM_TITLE_SELECTED_COLOR:JCC_TABBAR_ITEM_TITLE_NORMAL_COLOR];
    } else {
        [_icon setImage:nil];
        [_venueIcon setImage:nil];
        [_title setText:nil];
        [_btn setEnabled:NO];
    }
    
    if ([_appearance unreadMsgCount] > 0) {
        [_existMsgIcon setHidden:NO];
    } else {
        [_existMsgIcon setHidden:YES];
    }
}

-(NSArray *)wj_observableKeypaths {
    return @[@"appearance",@"selected"];
}

-(void)wj_changeForKeypath:(NSString *)keyPath {
    if (WJ_STRING_EQUAL(keyPath, @"appearance") || WJ_STRING_EQUAL(keyPath, @"selected")) {
        [self refreshUI];
    }
}

@end
