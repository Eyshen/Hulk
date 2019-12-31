//
//  BaseWJViewController.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/7/30.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import "BaseWJViewController.h"
#import "BaseWJNavigationBar.h"

NSString * const WJViewControllerTitleKey = @"WJViewControllerTitleKey";


@interface BaseWJViewController ()<IWJLoadingViewDelegate>
@property (nonatomic, assign) BOOL wjInitTag;
@end

@implementation BaseWJViewController

-(BOOL)wj_existNavigationBar {
    return YES;
}

#pragma mark custom
-(NSArray*)wj_viewModels {
    return nil;
}

#pragma mark IWJLoadingViewDelegate
-(void)loadingRefresh:(UIView<IWJLoadingView> *)loadingView {
    [loadingView setState:WJLoadingStateLoading];
    [self performSelectorOnMainThread:@selector(wj_execLoadDataAction) withObject:nil waitUntilDone:NO];
}
#pragma mark ViewController Overriding
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSArray *viewModels = [self wj_viewModels];
    for (id<IWJViewModel> vm in viewModels) {
        [vm setWjActive:NO];
        [vm wj_viewWillDisappear];
    }
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSArray *viewModels = [self wj_viewModels];
    for (id<IWJViewModel> vm in viewModels) {
        [vm wj_viewDidDisappear];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.navigationController) {
        [self.navigationController setNeedsStatusBarAppearanceUpdate];
    } else {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    NSArray *viewModels = [self wj_viewModels];
    for (id<IWJViewModel> vm in viewModels) {
        [vm setWjActive:YES];
        [vm wj_viewWillAppear];
    }
    if (_wjLoadingView) [self.view bringSubviewToFront:_wjLoadingView];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSArray *viewModels = [self wj_viewModels];
    for (id<IWJViewModel> vm in viewModels) {
        [vm wj_viewDidAppear];
    }
}

-(void)viewDidLoad {
    [super viewDidLoad];

    if (@available(iOS 11.0, *)) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
#endif
    } else {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
        //解决iOS7之后滚动视图留有间隙问题
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
#endif
    }
    
    [self wj_refreshUIElement];
    
    //添加加载视图
    if (!_wjLoadingView) {
        UIView<IWJLoadingView> *v = [self wj_instanceLoadingView];
        if (v) {
            [v setDelegate:self];
            [v setOffsetY:-20.0f];
            [self.wjView addSubview:v];
            __weak typeof(self) selfObject = self;
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(selfObject.wjView);
            }];
            _wjLoadingView = v;
        }
    }
    
    [self loadingRefresh:_wjLoadingView];
}

#pragma mark NavigationBar style
-(void)setWjNavTitle:(NSString *)wjNavTitle {
    if (_wjNavTitle == wjNavTitle) {
        return;
    }
    _wjNavTitle = [wjNavTitle copy];
    [_wjNavigationItem setTitle:_wjNavTitle];
}


-(void) wj_popExec:(id) sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}

-(void) wj_refreshUIElement {
    CGFloat statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    if ([self wj_existNavigationBar]) {
        __weak typeof(self) selfObject = self;
        if (!_wjNavigationBar) {
            BaseWJNavigationBar *bar = [[BaseWJNavigationBar alloc] init];
            UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:self.wjNavTitle];
            _wjNavigationItem = item;
            
            [bar setItems:[NSArray arrayWithObjects:item, nil]];
            
            if ([self.navigationController.viewControllers count] > 1) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0
                UIImage *icon = [UIImage imageNamed:@"wj-nav-icon-back"];
                UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:icon style:UIBarButtonItemStylePlain target:self action:@selector(wj_popExec:)];
                [self.wjNavigationItem setLeftBarButtonItem:backItem];
#else
                UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
                negativeSpacer.width = -2.0f;
                UIImage *icon = [UIImage imageNamed:@"wj-nav-icon-back"];
                UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:icon style:UIBarButtonItemStylePlain target:self action:@selector(wj_popExec:)];
                [self.wjNavigationItem setLeftBarButtonItems:@[negativeSpacer,backItem]];
#endif
            }
            [self.view addSubview:bar];
            [bar mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(selfObject.view.mas_left);
                make.right.equalTo(selfObject.view.mas_right);
                make.top.equalTo(selfObject.view.mas_top);
                make.height.equalTo(@(statusHeight+44.0f));
            }];
            _wjNavigationBar = bar;
        }
        if (!_wjView) {
//            UIView *v = [[UIView alloc] initWithFrame:([self edgesForExtendedLayout] & UIRectEdgeTop) ? self.view.bounds : CGRectMake(0, 64.0f, self.view.bounds.size.width, self.view.bounds.size.height - 64.0f)];
            UIView *v = [[UIView alloc] init];
            [self.view insertSubview:v atIndex:0];
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                UIEdgeInsets edgeInsets = UIEdgeInsetsMake(([selfObject edgesForExtendedLayout] & UIRectEdgeTop) ? 0 : statusHeight+44.0f, 0, 0, 0);
                make.edges.equalTo(selfObject.view).with.insets(edgeInsets);
            }];
            _wjView = v;
        } else {
            if (self.wjViewTopLayoutConstraint) {
                [self.wjViewTopLayoutConstraint setConstant:statusHeight+44.0f];
            } else {
                NSArray *constraints = [self.view constraints];
                for (NSLayoutConstraint *constraint in constraints) {
                    if ([constraint constant] == 64.0f) {
                        [constraint setConstant:statusHeight+44.0f];
                        break;
                    }
                }
            }
        }
    } else {
        _wjView = self.view;
    }
}


-(BOOL)shouldAutorotate {
    return NO;
}

//-(void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//    if ([self wj_existNavigationBar]) {
//        [_wjNavigationBar setFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64.0f)];
//        if ([self edgesForExtendedLayout] & UIRectEdgeTop) {
//            [_wjView setFrame:self.view.bounds];
//        } else {
//            [_wjView setFrame:CGRectMake(0, 64.0f, self.view.bounds.size.width, self.view.bounds.size.height - 64.0f)];
//        }
//    }
//}

-(void)dealloc {
    [self wj_unregisterFromKVO];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_6_0
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0f) {
        if (self.isViewLoaded && !self.view.window) {
            self.view = nil;
        }
    }
#endif
    
    NSArray *viewModels = [self wj_viewModels];
    for (id<IWJViewModel> vm in viewModels) {
        [vm wj_didReceiveMemoryWarning];
    }
    
}

-(instancetype)init {
    self = [super init];
    if (self) {
        if (!_wjInitTag) {
            [self wj_vcInit];
            _wjInitTag = YES;
        }
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        if (!_wjInitTag) {
            [self wj_vcInit];
            _wjInitTag = YES;
        }
    }
    return self;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if (!_wjInitTag) {
            [self wj_vcInit];
            _wjInitTag = YES;
        }
    }
    return self;
}

-(void)wj_vcInit {
    [self wj_registerForKVO];
}


#pragma mark exec action method
-(void) wj_execLoadDataAction {}

#pragma mark instance
+(instancetype) wj_instance {
    BaseWJViewController *viewController = nil;
    @try {
        NSString *className = NSStringFromClass(self);
        NSString *nibFilePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.nib",className]];
        NSString *iphoneNibFilePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@~iphone.nib",className]];
        NSString *ipadNibFilePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@~ipad.nib",className]];
        NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm fileExistsAtPath:iphoneNibFilePath] || [fm fileExistsAtPath:nibFilePath] || [fm fileExistsAtPath:ipadNibFilePath]) {
            viewController = [[self alloc] initWithNibName:className bundle:[NSBundle mainBundle]];
        } else {
            viewController = [[self alloc] init];
        }
    }
    @catch (NSException *exception) {
        viewController = [[self alloc] init];
    }
    return viewController;
}

#pragma mark Instance LoadingView
-(UIView<IWJLoadingView> *)wj_instanceLoadingView {
    return nil;
}


#pragma mark KVO
-(NSKeyValueObservingOptions) observerOptionsForKeypath:(NSString*) keyPath {
    return NSKeyValueObservingOptionNew;
}
-(void) wj_registerForKVO {
    NSArray *keypaths = [self wj_observableKeypaths];
    for (NSString *keypath in keypaths) {
        [self addObserver:self forKeyPath:keypath options:[self observerOptionsForKeypath:keypath] context:NULL];
    }
}
-(void) wj_unregisterFromKVO {
    NSArray *keypaths = [self wj_observableKeypaths];
    for (NSString *keypath in keypaths) {
        [self removeObserver:self forKeyPath:keypath];
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(wj_changeForKeypath:) withObject:keyPath waitUntilDone:NO];
    } else {
        [self wj_changeForKeypath:keyPath];
    }
}

-(NSArray*) wj_observableKeypaths {
    return nil;
}

-(void) wj_changeForKeypath:(NSString*) keypath {}


#pragma mark IQWRouterViewController
-(id)initWithURL:(NSString *)URL routerParams:(NSDictionary *)params {
    self.routerParams = params;
    self = [super init];
    if (self) {
        if (!_wjInitTag) {
            [self wj_vcInit];    
            _wjInitTag = YES;
        }
    }
    return self;
}

#pragma mark IQWRouterViewControllerDelegate
-(void) viewController:(UIViewController*) viewController routerParams:(NSDictionary*) params {
    [_routerDelegate viewController:viewController routerParams:params];
}

@end
