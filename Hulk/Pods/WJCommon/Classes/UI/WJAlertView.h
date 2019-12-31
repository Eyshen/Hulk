//
//  WJAlertView.h
//  WJCommon-master
//
//  Created by 吴云海 on 16/6/16.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "BaseWJView.h"

typedef NS_ENUM(NSInteger, WJAlertViewAnimationType) {
    WJAlertViewAnimationTypeNone,//无
    WJAlertViewAnimationTypeTop,//顶部朝下显示
    WJAlertViewAnimationTypeBottom,//底部朝上显示
    WJAlertViewAnimationTypeZoom,//放大缩小
};

@protocol IWJAlertView;

/**
 *  提示框内容视图
 */
@protocol IWJAlertContentView <NSObject>

/**
 *  内容视图大小
 */
- (CGSize)contentViewSize;

/**
 *  容器视图
 */
@property(nonatomic, weak) UIView<IWJAlertView> *containerView;



@optional
/**
 *  透明度
 *
 *  @return 0.0~1.0
 *
 *  default 0.3f
 */
- (CGFloat)backgroundAlpha;

/**
 *  动画时长
 *
 *  default 0.25f
 */
- (NSTimeInterval) animatedDuration;

/**
 *  偏移量，相对于中点
 */
- (CGPoint) contentViewOffset;

/**
 * 键盘显示时偏移量
 */
- (CGFloat) keyboardShowContentViewOffsetY;

@end





/**
 *  提示框接口
 */
@protocol IWJAlertView <NSObject>

/**
 *  初始化提示框
 */
- (instancetype)initWithContentView:(UIView<IWJAlertContentView>*)contentView;



/**
 *  初始化提示框
 */
- (instancetype)initWithContentView:(UIView<IWJAlertContentView>*)contentView nokeyboardNotification:(BOOL)noNotification;


/**
 *  关闭提示框
 */
- (void)close:(BOOL)animated;

/**
 *  显示提示框  默认在window上显示
 */
- (void)show:(BOOL)animated;

/**
 *  在指定视图上显示提示框
 *
 *  @param view     视图
 *  @param animated 是否动画
 */
- (void)showInView:(UIView*)view animated:(BOOL)animated;

/**
 *  当前App是否已显示了次类型提示框
 */
+(BOOL) existAlertView;

/**
 *  关闭所有提示框
 */
+(void) closeAllAlertView;

@end

/**
 *  提示框(提示框关闭后会直接从父类上移除)
 */
@interface WJAlertView : BaseWJView<IWJAlertView>


@end
