//
//  ViewController.m
//  Hulk
//
//  Created by 张学超 on 2018/5/9.
//  Copyright © 2018年 Happiness. All rights reserved.
//

#import "ViewController.h"


#define ZY_SCREEN_WIDTH             [UIScreen width]

#define ZY_SCREEN_HEIGHT            [UIScreen height]

@interface ViewController ()



@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(100, 200, 15, 15)];
    [image setImage:[UIImage imageNamed:@"purchase_hand"]];
    [self.view addSubview:image];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.translation.y";
    animation.values = @[@0, @-20, @0, @20, @0];
    animation.keyTimes = @[ @0, @(1 / 4), @(1 / 2), @(3 / 4), @1 ];
    animation.duration = 0.8;
    animation.repeatCount = MAXFLOAT;
    animation.additive = YES;
    [image.layer addAnimation:animation forKey:@"keyTimes"];
}

-(void)printN:(int)num{
    if (num) {
        [self printN:(num-1)];
//        NSLog(@"%d\n",num);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
