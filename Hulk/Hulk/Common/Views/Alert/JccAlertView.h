//
//  JccAlertView.h
//  ios-jucaicat
//
//  Created by 吴云海 on 17/6/29.
//  Copyright © 2017年 wuyunhai. All rights reserved.
//

#import "AppBaseView.h"
#import "WJAlertView.h"

//return：是否关闭当前view 参数：点击按钮索引号
typedef BOOL(^JccAlertViewActionBlock)(NSInteger buttonIndex);

@interface JccAlertView : AppBaseView<IWJAlertContentView>

#pragma mark IWJAlertContentView
@property(nonatomic, weak) UIView<IWJAlertView> *containerView;

@end


@interface JccAlertView (Helper)

+(UIView<IWJAlertView>*)showTitle:(NSString*)title message:(NSString*)message cancelButtonTitle:(NSString*)cancelTitle otherButtonTitle:(NSString*)otherTitle actionBlock:(JccAlertViewActionBlock)actionBlock inView:(UIView*)view animated:(BOOL)animated;

+(UIView<IWJAlertView>*)showTitle:(NSString*)title messageAttributedString:(NSAttributedString*)messageAttributedString cancelButtonTitle:(NSString*)cancelTitle otherButtonTitle:(NSString*)otherTitle actionBlock:(JccAlertViewActionBlock)actionBlock inView:(UIView*)view animated:(BOOL)animated;

+(UIView<IWJAlertView>*)showTitle:(NSString*)title messageAttributedString:(NSAttributedString*)messageAttributedString cancelButtonTitle:(NSString*)cancelTitle cancelTitleColor:(UIColor*)color actionBlock:(JccAlertViewActionBlock)actionBlock inView:(UIView*)view animated:(BOOL)animated;

+(UIView<IWJAlertView>*)showTitle:(NSString*)title middleMessageAttributedString:(NSAttributedString*)messageAttributedString cancelButtonTitle:(NSString*)cancelTitle otherButtonTitle:(NSString*)otherTitle actionBlock:(JccAlertViewActionBlock)actionBlock inView:(UIView*)view animated:(BOOL)animated;

@end
