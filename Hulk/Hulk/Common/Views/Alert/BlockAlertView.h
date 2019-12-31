//
//  BlockAlertView.h
//  ios-jucaicat
//
//  Created by 吴云海 on 17/6/19.
//  Copyright © 2017年 wuyunhai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlertViewActionBlock)(NSInteger buttonIndex);

@interface BlockAlertView : UIAlertView

-(void)showWithBlock:(AlertViewActionBlock)actionBlock;

@end
