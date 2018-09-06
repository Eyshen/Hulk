//
//  WJVerticalButton.h
//  WJCommon-master
//
//  Created by 吴云海 on 16/9/27.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "BaseWJButton.h"


/**
 *  垂直Button(图片在上，文字在下)
 *  note:各种状态图片最好要相同大小
 */
@interface WJVerticalButton : BaseWJButton

/**
 *  图片与文字间距
 *  default 0.0f
 */
@property(nonatomic, assign) CGFloat spacing;

/**
 *  设置字体
 */
-(void)wj_setFont:(UIFont*)font;


@end
