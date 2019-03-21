//
//  JccLoadingIndicatorView.m
//  ios-jucaicat
//
//  Created by 吴云海 on 16/9/1.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "JccLoadingIndicatorView.h"
#import <QuartzCore/QuartzCore.h>

@interface JccLoadingIndicatorView ()

@property(nonatomic, weak) UIImageView *imgCircle;

@property(nonatomic, weak) UIImageView *imgLogo;

//@property(nonatomic, assign) BOOL animated;

@property(nonatomic, weak) CADisplayLink *displayLink;

@end

@implementation JccLoadingIndicatorView

-(void)wj_loadSubViews {
    [super wj_loadSubViews];
    if (!_imgLogo) {
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading-indicator-logo"]];
        [img setFrame:self.bounds];
        [self addSubview:img];
        [img setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        _imgLogo = img;
    }
    if (!_imgCircle) {
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading-indicator-circle"]];
        [img setFrame:self.bounds];
        [self addSubview:img];
        [img setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        _imgCircle = img;
    }
    [self setBackgroundColor:[UIColor clearColor]];
}

-(void)startAnimating {
    if (![self isAnimating]) {
        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(rotateAction)];
        [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        self.displayLink = link;
    }
}

- (void)rotateAction {
    self.imgCircle.transform = CGAffineTransformRotate(self.imgCircle.transform, 30 * M_PI_2 / 180.0f );
    
}

-(void)stopAnimating {
    if ([self isAnimating]) {
        [self.displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}

-(BOOL)isAnimating {
    if (self.displayLink) {
        return YES;
    }
    return NO;
}

-(void)dealloc {
    WJLogDebug(@"dealloc JccLoadingIndicatorView");
}

@end
