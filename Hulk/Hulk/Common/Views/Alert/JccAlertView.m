//
//  JccAlertView.m
//  ios-jucaicat
//
//  Created by 吴云海 on 17/6/29.
//  Copyright © 2017年 wuyunhai. All rights reserved.
//

#import "JccAlertView.h"
#import "AppBaseDTO.h"

@interface CusAlertViewData : AppBaseDTO
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSAttributedString *messageAttributedString;
@property(nonatomic, copy) NSString *cancelTitle;
@property(nonatomic, copy) NSString *otherTitle;
@property(nonatomic, copy) JccAlertViewActionBlock copyActionBlock;
@end

@implementation CusAlertViewData

@end

@interface JccAlertView ()
@property(nonatomic, copy) CusAlertViewData *alertData;
@property(nonatomic, assign) CGSize contentSize;
@property(nonatomic, weak) IBOutlet UILabel *refLabTitle,*refLabContent;
@property(nonatomic, weak) IBOutlet UIButton *refBtnCancel,*refBtnConfirm,*refBtnSingle;
- (void)btnExec:(id)sender;
@end

@implementation JccAlertView

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle otherButtonTitle:(NSString *)otherTitle actionBlock:(JccAlertViewActionBlock)actionBlock {
    self = [super init];
    if (self) {
        CusAlertViewData *data = [[CusAlertViewData alloc] init];
        [data setTitle:title];
        if (message) [data setMessageAttributedString:[[NSAttributedString alloc] initWithString:message]];
        [data setCancelTitle:cancelTitle];
        [data setOtherTitle:otherTitle];
        [data setCopyActionBlock:actionBlock];
        self.alertData = data;
        
        [self refreshUI];
    }
    return self;
}

-(instancetype)initWithTitle:(NSString *)title messageAttributedString:(NSAttributedString *)messageAttributedString cancelButtonTitle:(NSString *)cancelTitle otherButtonTitle:(NSString *)otherTitle actionBlock:(JccAlertViewActionBlock)actionBlock {
    self = [super init];
    if (self) {
        CusAlertViewData *data = [[CusAlertViewData alloc] init];
        [data setTitle:title];
        [data setMessageAttributedString:messageAttributedString];
        [data setCancelTitle:cancelTitle];
        [data setOtherTitle:otherTitle];
        [data setCopyActionBlock:actionBlock];
        self.alertData = data;
        
        [self refreshUI];
    }
    return self;
}

-(void)wj_loadSubViews {
    [super wj_loadSubViews];
    [self setBackgroundColor:[UIColor whiteColor]];
    if (!_refLabTitle) {
        WJ_WEAK_REF_TYPE weakSelf = self;
        UILabel *titleLab = [[UILabel alloc] init];
        [titleLab setTextColor:WJ_COLOR_RGBA(51, 51, 51, 1)];
        [titleLab setFont:[UIFont fontWithName:APP_FONT_NAME size:18]];
        [titleLab setBackgroundColor:[UIColor clearColor]];
        [titleLab setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:titleLab];
        _refLabTitle = titleLab;
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@24);
            make.right.equalTo(@(-24));
            make.top.equalTo(@(25));
            make.height.equalTo(@(25));
        }];
        
        UILabel *contentLab = [[UILabel alloc] init];
        [contentLab setFont:[UIFont fontWithName:APP_FONT_NAME size:14]];
        [contentLab setLineBreakMode:NSLineBreakByCharWrapping];
        [contentLab setTextColor:WJ_COLOR_RGBA(153, 153, 153, 1)];
        [contentLab setBackgroundColor:[UIColor clearColor]];
        [contentLab setTextAlignment:NSTextAlignmentLeft];
        [contentLab setNumberOfLines:0];
        [self addSubview:contentLab];
        _refLabContent = contentLab;
        [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(24));
            make.right.equalTo(@(-24));
            make.top.equalTo(@(60));
            make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-65);
        }];
        
        WJLineView *line0 = [[WJLineView alloc] init];
        [line0 setDrawPosition:WJLineDrawPositionHorizontalCenter];
        [line0 setLineColor:WJ_COLOR_RGBA(222, 222, 222, 1)];
        [self addSubview:line0];
        [line0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(0.0f));
            make.right.equalTo(@0);
            make.bottom.equalTo(@(-50));
            make.height.equalTo(@1);
        }];
        
        WJLineView *line1 = [[WJLineView alloc] init];
        [line1 setDrawPosition:WJLineDrawPositionVerticalCenter];
        [line1 setLineColor:WJ_COLOR_RGBA(222, 222, 222, 1)];
        [self addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line0.mas_bottom);
            make.width.equalTo(@1);
            make.bottom.equalTo(@(0));
            make.centerX.equalTo(weakSelf.mas_centerX);
        }];

        
        UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn0 addTarget:self action:@selector(btnExec:) forControlEvents:UIControlEventTouchUpInside];
        [btn0 setBackgroundColor:[UIColor whiteColor]];
        [btn0 setBackgroundImage:[UIImage imageNamed:@"white-button-high-bg"] forState:UIControlStateHighlighted];
        [btn0 setTitleColor:WJ_COLOR_RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
        [[btn0 titleLabel] setFont:[UIFont fontWithName:APP_FONT_NAME size:18]];
        [self addSubview:btn0];
        _refBtnCancel = btn0;
        [btn0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(line1.mas_left);
            make.top.equalTo(line0.mas_bottom);
            make.bottom.equalTo(weakSelf.mas_bottom);
        }];
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn1 addTarget:self action:@selector(btnExec:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 setBackgroundColor:[UIColor whiteColor]];
        [btn1 setBackgroundImage:[UIImage imageNamed:@"white-button-high-bg"] forState:UIControlStateHighlighted];
        [btn1 setTitleColor:WJ_COLOR_RGBA(231, 68, 68, 1) forState:UIControlStateNormal];
        [[btn1 titleLabel] setFont:[UIFont fontWithName:APP_FONT_NAME size:18]];
        [self addSubview:btn1];
        _refBtnConfirm = btn1;
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line1.mas_right);
            make.right.equalTo(@0);
            make.top.equalTo(line0.mas_bottom);
            make.bottom.equalTo(weakSelf.mas_bottom);
        }];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn2 addTarget:self action:@selector(btnExec:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 setBackgroundColor:[UIColor whiteColor]];
        [btn2 setBackgroundImage:[UIImage imageNamed:@"white-button-high-bg"] forState:UIControlStateHighlighted];
        [btn2 setTitleColor:WJ_COLOR_RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
        [[btn2 titleLabel] setFont:[UIFont fontWithName:APP_FONT_NAME size:18]];
        [self addSubview:btn2];
        _refBtnSingle = btn2;
        [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.top.equalTo(line0.mas_bottom);
            make.bottom.equalTo(weakSelf.mas_bottom);
        }];
    }
    
    [self.layer setCornerRadius:8.0f];
    [self setClipsToBounds:YES];
}


-(void)refreshUI {
    [self.refLabTitle setText:self.alertData.title];
    [self.refLabContent setAttributedText:self.alertData.messageAttributedString];
    [self.refBtnCancel setTitle:self.alertData.cancelTitle forState:UIControlStateNormal];
    [self.refBtnSingle setTitle:self.alertData.cancelTitle forState:UIControlStateNormal];
    [self.refBtnConfirm setTitle:self.alertData.otherTitle forState:UIControlStateNormal];
    
    if (self.alertData.otherTitle) {
        [self.refBtnSingle setHidden:YES];
        [self.refBtnCancel setHidden:NO];
        [self.refBtnConfirm setHidden:NO];
    } else {
        [self.refBtnSingle setHidden:NO];
        [self.refBtnCancel setHidden:YES];
        [self.refBtnConfirm setHidden:YES];
    }
    
    //计算高度
    CGFloat width = 280.0f;
    CGFloat height = 125.0f;
    if (WJ_SCREEN_WIDTH >= 375) {
        width = 300.0f;
    }
    
    CGSize cs = [self.refLabContent sizeThatFits:CGSizeMake(width-48.0f, 400)];
    height += cs.height;
    
    if (cs.height >= 20.0f) {
        [self.refLabContent setTextAlignment:NSTextAlignmentLeft];
    } else {
        [self.refLabContent setTextAlignment:NSTextAlignmentCenter];
    }
    
    self.contentSize = CGSizeMake(width, height);
}

-(void)btnExec:(id)sender {
    BOOL hasClose = YES;
    if (NULL != self.alertData.copyActionBlock) {
        if (sender == _refBtnCancel) {
            hasClose = self.alertData.copyActionBlock(0);
        } else if (sender == _refBtnSingle) {
            hasClose = self.alertData.copyActionBlock(0);
        } else if (sender == _refBtnConfirm) {
            hasClose = self.alertData.copyActionBlock(1);
        }
    }
    if (hasClose) {
        [self.containerView close:YES];
    }
}

#pragma mark IWJAlertContentView
-(CGFloat)backgroundAlpha {
    return 0.7f;
}

-(CGSize)contentViewSize {
    return _contentSize;    
}

-(CGPoint)contentViewOffset {
    return CGPointMake(0, -40.0f);
}

-(void)setSingleButtonColor:(UIColor*)color {
    if (_refBtnSingle) {
        [_refBtnSingle setTitleColor:color forState:UIControlStateNormal];
    }
}
@end



@implementation JccAlertView(Helper)


+(UIView<IWJAlertView>*)showTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle otherButtonTitle:(NSString *)otherTitle actionBlock:(JccAlertViewActionBlock)actionBlock inView:(UIView *)view animated:(BOOL)animated {
    JccAlertView *v = [[JccAlertView alloc] initWithTitle:title message:message cancelButtonTitle:cancelTitle otherButtonTitle:otherTitle actionBlock:actionBlock];
    WJAlertView *alertView = [[WJAlertView alloc] initWithContentView:v];
    [alertView showInView:view?:WJ_APPLICATION_WINDOW animated:animated];
    return alertView;
}


+(UIView<IWJAlertView>*)showTitle:(NSString *)title messageAttributedString:(NSAttributedString *)messageAttributedString cancelButtonTitle:(NSString *)cancelTitle otherButtonTitle:(NSString *)otherTitle actionBlock:(JccAlertViewActionBlock)actionBlock inView:(UIView *)view animated:(BOOL)animated {
    JccAlertView *v = [[JccAlertView alloc] initWithTitle:title messageAttributedString:messageAttributedString cancelButtonTitle:cancelTitle otherButtonTitle:otherTitle actionBlock:actionBlock];
    WJAlertView *alertView = [[WJAlertView alloc] initWithContentView:v];
    [alertView showInView:view?:WJ_APPLICATION_WINDOW animated:animated];
    return alertView;
}

+(UIView<IWJAlertView>*)showTitle:(NSString*)title messageAttributedString:(NSAttributedString*)messageAttributedString cancelButtonTitle:(NSString*)cancelTitle cancelTitleColor:(UIColor*)color actionBlock:(JccAlertViewActionBlock)actionBlock inView:(UIView*)view animated:(BOOL)animated{
    JccAlertView *v = [[JccAlertView alloc] initWithTitle:title messageAttributedString:messageAttributedString cancelButtonTitle:cancelTitle otherButtonTitle:nil actionBlock:actionBlock];
    [v setSingleButtonColor:color];
    WJAlertView *alertView = [[WJAlertView alloc] initWithContentView:v];
    [alertView showInView:view?:WJ_APPLICATION_WINDOW animated:animated];
    return alertView;
}

+(UIView<IWJAlertView>*)showTitle:(NSString*)title middleMessageAttributedString:(NSAttributedString*)messageAttributedString cancelButtonTitle:(NSString*)cancelTitle otherButtonTitle:(NSString*)otherTitle actionBlock:(JccAlertViewActionBlock)actionBlock inView:(UIView*)view animated:(BOOL)animated {
    JccAlertView *v = [[JccAlertView alloc] initWithTitle:title messageAttributedString:messageAttributedString cancelButtonTitle:cancelTitle otherButtonTitle:otherTitle actionBlock:actionBlock];
    [[v refLabContent] setTextAlignment:NSTextAlignmentCenter];
    WJAlertView *alertView = [[WJAlertView alloc] initWithContentView:v];
    [alertView showInView:view?:WJ_APPLICATION_WINDOW animated:animated];
    return alertView;
}
@end
