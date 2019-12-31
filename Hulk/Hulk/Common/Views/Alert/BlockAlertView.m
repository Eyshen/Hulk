//
//  BlockAlertView.m
//  ios-jucaicat
//
//  Created by 吴云海 on 17/6/19.
//  Copyright © 2017年 wuyunhai. All rights reserved.
//

#import "BlockAlertView.h"

@interface BlockAlertView ()<UIAlertViewDelegate>

@property(nonatomic, copy) AlertViewActionBlock copyActionBlock;

@end

@implementation BlockAlertView

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (NULL != self.copyActionBlock) {
        self.copyActionBlock(buttonIndex);
    }
}

-(void)showWithBlock:(AlertViewActionBlock)actionBlock {
    [self setDelegate:self];
    self.copyActionBlock = actionBlock;
    [self show];
}

@end
