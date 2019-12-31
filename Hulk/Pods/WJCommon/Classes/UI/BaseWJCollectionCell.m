//
//  BaseWJCollectionCell.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/7/29.
//  Copyright (c) 2015年 WJ. All rights reserved.
//


#import "BaseWJCollectionCell.h"

@interface BaseWJCollectionCell ()
@property (nonatomic, assign) BOOL wjInitTag;
@end

@implementation BaseWJCollectionCell

-(void) wj_reuseCollectionCell {
}

-(void) loadBaseWJCollectionCellSubviews {
    if (!_wjInitTag) {
        [self wj_registerForKVO];
        _wjInitTag = YES;
    }
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            ((UIScrollView *)view).delaysContentTouches = NO;
            break;
        }
    }
    
    [self wj_loadSubViews];
}

-(void) wj_loadSubViews {
    if (self.contentView) {
        [self.contentView setUserInteractionEnabled:YES];
        [self setUserInteractionEnabled:YES];
    }
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadBaseWJCollectionCellSubviews];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self loadBaseWJCollectionCellSubviews];
    }
    return self;
}
-(id)init {
    self = [super init];
    if (self) {
        [self loadBaseWJCollectionCellSubviews];
    }
    return self;
}

-(NSKeyValueObservingOptions) wj_observerOptionsForKeypath:(NSString*) keyPath {
    return NSKeyValueObservingOptionNew;
}

- (void) wj_registerForKVO {
    for (NSString *keyPath in [self wj_observableKeypaths]) {
        [self addObserver:self forKeyPath:keyPath options:[self wj_observerOptionsForKeypath:keyPath] context:NULL];
    }
}

- (void) wj_unregisterFromKVO {
    for (NSString *keyPath in [self wj_observableKeypaths]) {
        [self removeObserver:self forKeyPath:keyPath];
    }
}

- (NSArray *) wj_observableKeypaths {
    return nil;
}

-(void)prepareForReuse {
    [super prepareForReuse];
    [self wj_reuseCollectionCell];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(wj_changeForKeypath:) withObject:keyPath waitUntilDone:NO];
    } else {
        [self wj_changeForKeypath:keyPath];
    }
}

- (void)wj_changeForKeypath:(NSString *)keyPath {}

-(void)dealloc {
    [self wj_unregisterFromKVO];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+(instancetype) wj_instance {
    BaseWJCollectionCell *instance = nil;
    @try {
        NSString *className = NSStringFromClass(self);
        NSString *nibFile = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.nib",className]];
        NSString *iphoneNibFile = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@~iphone.nib",className]];
        NSString *ipadNibFile = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@~ipad.nib",className]];
        NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm fileExistsAtPath:iphoneNibFile] || [fm fileExistsAtPath:nibFile] || [fm fileExistsAtPath:ipadNibFile]) {
            id o = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
            if ([o isKindOfClass:self]) {
                instance = o;
            }
        }
        if (!instance) {
            instance = [[self alloc] init];
        }
    }
    @catch (NSException *exception) {
        instance = [[self alloc] init];
    }
    return instance;
}

@end
