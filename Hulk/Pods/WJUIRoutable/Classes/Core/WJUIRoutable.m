//
//  WJUIRoutable.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/8/24.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import "WJUIRoutable.h"
#import "WJRouterParams.h"
#import "WJURLUtils.h"
#import "IWJRouterURLFormater.h"
#import "WJUIRoutableConfig.h"
#import "WJLoggingMacros.h"
#import "WJCommon.h"

#define WJ_UIROUTABLER_APP_WINDOW_ROOT_VIEW_CONTROLLER [[[[UIApplication sharedApplication] delegate] window] rootViewController]

static WJUIRoutable *sharedObject;

@interface WJUIRoutable ()
@property (readwrite, nonatomic, strong) NSMutableDictionary *routes;
@property (nonatomic, strong) id<IWJRouterURLFormater> routerURLFormater;
//回退节点
@property (nonatomic, weak) UIViewController<IWJRouterViewController> *returnNode;

@end

@implementation WJUIRoutable

-(NSString *)formatRouterURL:(NSString *)routerURL {
    NSString *result = routerURL;
    if (routerURL && _routerURLFormater) {
        result = [_routerURLFormater formatRouterURL:routerURL];
    }
    return result;
}

/**
 *  所有的模态视图控制器
 */
-(NSArray*) allModalControllers {
    UIViewController *presentingViewController = WJ_UIROUTABLER_APP_WINDOW_ROOT_VIEW_CONTROLLER;
    NSMutableArray *presenteds = [[NSMutableArray alloc] initWithObjects:presentingViewController, nil];
    BOOL endTag = YES;
    while (endTag) {
        if (presentingViewController.presentedViewController) {
            [presenteds addObject:presentingViewController.presentedViewController];
            presentingViewController = presentingViewController.presentedViewController;
        } else {
            endTag = NO;
        }
    }
    return presenteds;
}

-(UIViewController*) lastModelViewController {
    return [[self allModalControllers] lastObject];
}

- (UIViewController*)firstModelViewController {
    return [[self allModalControllers] firstObject];
}

/**
 *  当前视图控制器
 */
-(UINavigationController*) currentNavigationController {
    UINavigationController *navigationController = nil;
    NSArray *presentings = [self allModalControllers];
    UIViewController *presentingViewController = [presentings lastObject];
    if (presentingViewController == WJ_UIROUTABLER_APP_WINDOW_ROOT_VIEW_CONTROLLER) {
        if ([presentingViewController isKindOfClass:[UITabBarController class]]) {
            UIViewController *selectedVC = [(UITabBarController*)presentingViewController selectedViewController];
            if ([selectedVC isKindOfClass:[UINavigationController class]]) {
                navigationController = (UINavigationController*)selectedVC;
            }
        }
    }
    if (!navigationController && [presentingViewController isKindOfClass:[UINavigationController class]]) {
        navigationController = (UINavigationController*)presentingViewController;
    }
    return navigationController;
}

- (void) pop:(BOOL) animated {
    if ([NSThread isMainThread]) {
        UINavigationController *nav = [self currentNavigationController];
        if (nav) [nav popViewControllerAnimated:animated];
    } else {
        WJ_BLOCK_WEAK WJUIRoutable *selfObject = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            UINavigationController *nav = [selfObject currentNavigationController];
            if (nav) [nav popViewControllerAnimated:animated];
        });
    }
}
- (void) popRoot:(BOOL) animated {
    if ([NSThread isMainThread]) {
        UINavigationController *nav = [self currentNavigationController];
        if (nav) [nav popToRootViewControllerAnimated:animated];
    } else {
        WJ_BLOCK_WEAK WJUIRoutable *selfObject = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            UINavigationController *nav = [selfObject currentNavigationController];
            if (nav) [nav popToRootViewControllerAnimated:animated];
        });
    }
}
- (void) popAtIndex:(NSUInteger) index animated:(BOOL) animated {
    
    if ([NSThread isMainThread]) {
        UINavigationController *nav = [self currentNavigationController];
        NSArray *viewControllers = [nav viewControllers];
        if ([viewControllers count] > index) {
            [nav popToViewController:viewControllers[index] animated:animated];
        }
    } else {
        WJ_BLOCK_WEAK WJUIRoutable *selfObject = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            UINavigationController *nav = [selfObject currentNavigationController];
            NSArray *viewControllers = [nav viewControllers];
            if ([viewControllers count] > index) {
                [nav popToViewController:viewControllers[index] animated:animated];
            }
        });
    }
}

- (void) dismiss:(BOOL)animated completion:(UIWJCompletionBlock)completionBlock {
    
    if ([NSThread isMainThread]) {
        UIViewController *lastModelVC = [self lastModelViewController];
        if (lastModelVC.presentingViewController) {
            [lastModelVC dismissViewControllerAnimated:animated completion:completionBlock];
        }
    } else {
        WJ_BLOCK_WEAK WJUIRoutable *selfObject = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            UIViewController *lastModelVC = [selfObject lastModelViewController];
            if (lastModelVC.presentingViewController) {
                [lastModelVC dismissViewControllerAnimated:animated completion:completionBlock];
            }
        });
    }
}
- (void) dismissAll:(BOOL)animated completion:(UIWJCompletionBlock)completionBlock {
    
    if ([NSThread isMainThread]) {
        UIViewController *firstModelVC = [self firstModelViewController];
        if (firstModelVC.presentedViewController) {
            [firstModelVC dismissViewControllerAnimated:animated completion:completionBlock];
        }
    } else {
        WJ_BLOCK_WEAK WJUIRoutable *selfObject = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            UIViewController *firstModelVC = [selfObject firstModelViewController];
            if (firstModelVC.presentedViewController) {
                [firstModelVC dismissViewControllerAnimated:animated completion:completionBlock];
            }
        });
    }
    
}
- (void) dismissAtIndex:(NSUInteger) index animated:(BOOL)animated completion:(UIWJCompletionBlock)completionBlock {
    
    if ([NSThread isMainThread]) {
        NSArray *modals = [self allModalControllers];
        if ([modals count] > index) {
            [modals[index] dismissViewControllerAnimated:animated completion:completionBlock];
        }
    } else {
        WJ_BLOCK_WEAK WJUIRoutable *selfObject = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *modals = [selfObject allModalControllers];
            if ([modals count] > index) {
                [modals[index] dismissViewControllerAnimated:animated completion:completionBlock];
            }
        });
    }
    
}

-(void)close:(BOOL)animated {
    
    if ([NSThread isMainThread]) {
        UINavigationController *nav = [self currentNavigationController];
        if (nav) {
            if ([[nav viewControllers] count] > 1) {
                [nav popViewControllerAnimated:animated];
            } else if(nav.presentingViewController) {
                [nav dismissViewControllerAnimated:animated completion:NULL];
            }
        } else if ([[self allModalControllers] count] > 0) {
            [[self lastModelViewController] dismissViewControllerAnimated:animated completion:NULL];
        }
    } else {
        WJ_BLOCK_WEAK WJUIRoutable *selfObject = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            UINavigationController *nav = [selfObject currentNavigationController];
            if (nav) {
                if ([[nav viewControllers] count] > 1) {
                    [nav popViewControllerAnimated:animated];
                } else if(nav.presentingViewController) {
                    [nav dismissViewControllerAnimated:animated completion:NULL];
                }
            } else if ([[selfObject allModalControllers] count] > 0) {
                [[self lastModelViewController] dismissViewControllerAnimated:animated completion:NULL];
            }
        });
    }
    
}
-(void)closeAll:(BOOL)animated {
    
    if ([NSThread isMainThread]) {
        NSArray *modals = [self allModalControllers];
        if ([modals count] > 1) {
            [[modals firstObject] dismissViewControllerAnimated:animated completion:NULL];
        } else {
            UINavigationController *nav = [self currentNavigationController];
            [nav popToRootViewControllerAnimated:animated];
        }
    } else {
        WJ_BLOCK_WEAK WJUIRoutable *selfObject = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *modals = [selfObject allModalControllers];
            if ([modals count] > 1) {
                [[modals firstObject] dismissViewControllerAnimated:animated completion:NULL];
            } else {
                UINavigationController *nav = [selfObject currentNavigationController];
                [nav popToRootViewControllerAnimated:animated];
            }
        });
    }
    
}

- (void)map:(NSString *)format toCallback:(WJRouterOpenCallback)callback {
    if (format) {
        [self maps:@[format] toCallback:callback];
    } else {
        @throw [NSException exceptionWithName:@"RouteNotProvided"
                                       reason:@"Route #format is not initialized"
                                     userInfo:nil];
    }
}
-(void)maps:(NSArray *)formats toCallback:(WJRouterOpenCallback)callback {
    [self maps:formats toCallback:callback withOptions:nil];
}
- (void)map:(NSString *)format toCallback:(WJRouterOpenCallback)callback withOptions:(WJRouterOptions *)options {
    if (format) {
        [self maps:@[format] toCallback:callback withOptions:options];
    } else {
        @throw [NSException exceptionWithName:@"RouteNotProvided"
                                       reason:@"Route #format is not initialized"
                                     userInfo:nil];
    }
}
-(void)maps:(NSArray *)formats toCallback:(WJRouterOpenCallback)callback withOptions:(WJRouterOptions *)options {
    if ([formats count] == 0) {
        @throw [NSException exceptionWithName:@"RouteNotProvided"
                                       reason:@"Route #format is not initialized"
                                     userInfo:nil];
        return;
    }
    if (!options) {
        options = [WJRouterOptions routerOptions];
    }
    options.callback = callback;
    
    for (NSString *f in formats) {
        WJLogDebug(@"映射链接:%@",f);
        [self.routes setObject:options forKey:[self formatRouterURL:f]];
    }
}
- (void)map:(NSString *)format toController:(Class)controllerClass {
    if (format) {
        [self maps:@[format] toController:controllerClass];
    } else {
        @throw [NSException exceptionWithName:@"RouteNotProvided"
                                       reason:@"Route #format is not initialized"
                                     userInfo:nil];
    }
}
-(void)maps:(NSArray *)formats toController:(Class)controllerClass {
    [self maps:formats toController:controllerClass withOptions:nil];
}
- (void)map:(NSString *)format toController:(Class)controllerClass withOptions:(WJRouterOptions *)options {
    if (format) {
        [self maps:@[format] toController:controllerClass withOptions:options];
    } else {
        @throw [NSException exceptionWithName:@"RouteNotProvided"
                                       reason:@"Route #format is not initialized"
                                     userInfo:nil];
    }
}
-(void)maps:(NSArray *)formats toController:(Class)controllerClass withOptions:(WJRouterOptions *)options {
    if ([formats count] == 0) {
        @throw [NSException exceptionWithName:@"RouteNotProvided"
                                       reason:@"Route #format is not initialized"
                                     userInfo:nil];
        return;
    }
    if (!options) {
        options = [WJRouterOptions routerOptions];
    }
    
    if (controllerClass != Nil && [controllerClass conformsToProtocol:@protocol(IWJRouterViewController)]) {
        options.openClass = controllerClass;
    } else {
        WJLogError(@"Route controller class invalid（non IRouterViewController）");
        @throw [NSException exceptionWithName:@"RouteControllerClass"
                                       reason:@"Route controller class invalid（non IRouterViewController）"
                                     userInfo:nil];
        return;
    }
    for (NSString *f in formats) {
        [self.routes setObject:options forKey:[self formatRouterURL:f]];
    }
}
- (void)callTel:(NSString *)tel {
    if (tel) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",tel]]];
    }
}
-(void)settingReturnNode:(UIViewController<IWJRouterViewController> *)returnNode {
    self.returnNode = returnNode;
}

-(BOOL)openReturnNode:(BOOL)animated {
    BOOL result = NO;
    if (_returnNode) {
        if (_returnNode == WJ_UIROUTABLER_APP_WINDOW_ROOT_VIEW_CONTROLLER) {
            [WJ_UIROUTABLER_APP_WINDOW_ROOT_VIEW_CONTROLLER dismissViewControllerAnimated:animated completion:NULL];
            result = YES;
        } else {
            NSArray *allModels = [ self allModalControllers];
            for (UIViewController *model in allModels) {
                if ([model isKindOfClass:[UITabBarController class]]) {
                    UIViewController *selectedVC = [(UITabBarController*)model selectedViewController];
                    if (selectedVC == _returnNode) {
                        if ([model presentedViewController]) {
                            [model dismissViewControllerAnimated:animated completion:NULL];
                            result = YES;
                            break;
                        }
                    } else if ([selectedVC isKindOfClass:[UINavigationController class]] && [[selectedVC childViewControllers] containsObject:_returnNode]) {
                        if ([model presentedViewController]) {
                            [model dismissViewControllerAnimated:animated completion:NULL];
                        }
                        [(UINavigationController*)selectedVC popToViewController:_returnNode animated:animated];
                        result = YES;
                        break;
                    }
                } else if ([model isKindOfClass:[UINavigationController class]]) {
                    if ([[model childViewControllers] containsObject:_returnNode]) {
                        if ([model presentedViewController]) {
                            [model dismissViewControllerAnimated:animated completion:NULL];
                        }
                        [(UINavigationController*)model popToViewController:_returnNode animated:animated];
                        result = YES;
                        break;
                    }
                } else if ([model isKindOfClass:[UIViewController class]]) {
                    if (model == _returnNode) {
                        if ([model presentedViewController]) {
                            [model dismissViewControllerAnimated:animated completion:NULL];
                        }
                        result = YES;
                        break;
                    }
                }
            }
        }
        _returnNode = nil;
    }
    return result;
}

- (void)openExternal:(NSString *)url {
    WJLogDebug(@"打开外部链接:%@",url);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
- (void)open:(NSString *)url {
    [self open:url animated:NO];
}
- (void)open:(NSString *)url animated:(BOOL)animated {
    [self open:url animated:animated extraParams:nil];
}
- (void)open:(NSString *)url animated:(BOOL)animated extraParams:(NSDictionary *)extraParams {
    if ([NSThread isMainThread]) {
        [self openAction:url animated:animated extraParams:extraParams];
    } else {
        WJ_BLOCK_WEAK WJUIRoutable *selfObject = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [selfObject openAction:url animated:animated extraParams:extraParams];
        });
    }
}

- (void) openAction:(NSString*)url animated:(BOOL)animated extraParams:(NSDictionary *)extraParams {
    WJLogDebug(@"打开链接:%@",url);
    //格式化url链接
    NSString *routerURL = [self formatRouterURL:url];
    WJLogDebug(@"打开router链接:%@",routerURL);
    
    WJRouterParams *params = [self routerParamsForUrl:routerURL extraParams: extraParams];
    WJRouterOptions *options = params.routerOptions;
    
    if (options.callback) {
        WJRouterOpenCallback callback = options.callback;
        callback([params controllerParams]);
        return;
    }
    
    //使用格式化url链接
    UIViewController *controller = [self controllerForRouterParams:params url:routerURL];
    
    if (controller) {
        if ([options isModal]) {
            NSArray *modals = [self allModalControllers];
            id presentingVC = [modals lastObject];
            
            if ([controller isKindOfClass:[UINavigationController class]]) {
                [presentingVC presentViewController:controller animated:animated completion:NULL];
            } else {
                id<IWJRouterViewControllerDelegate> delegate = nil;
                if ([presentingVC isKindOfClass:[UINavigationController class]] && [[[[presentingVC viewControllers] lastObject] class] conformsToProtocol:@protocol(IWJRouterViewControllerDelegate)]) {
                    delegate = [[presentingVC viewControllers] lastObject];
                } else if ([[presentingVC class] conformsToProtocol:@protocol(IWJRouterViewControllerDelegate)]) {
                    delegate = presentingVC;
                }
                [(id<IWJRouterViewController>)controller setRouterDelegate:delegate];
                
                
                UINavigationController *nav = nil;
                Class navClazz = options.navigationControllerClass;
                if (navClazz != Nil) {
                    nav= [[navClazz alloc] initWithRootViewController:controller];
                } else {
                    nav = [[UINavigationController alloc] initWithRootViewController:controller];
                }
                WJLogDebug(@"模态打开视图控制器:%@",NSStringFromClass(controller.class));
                [presentingVC presentViewController:nav animated:animated completion:NULL];
            }
        } else {
            UINavigationController *nav = [self currentNavigationController];
            UIViewController *lastVC = [[nav viewControllers] lastObject];
            if ([[lastVC class] conformsToProtocol:@protocol(IWJRouterViewControllerDelegate)]) {
                [(id<IWJRouterViewController>)controller setRouterDelegate:(id<IWJRouterViewControllerDelegate>)lastVC];
            }
            WJLogDebug(@"推送打开视图控制器:%@",NSStringFromClass(controller.class));
            [nav pushViewController:controller animated:animated];
        }
    }
}

- (void)openRoot:(UIViewController*) rootViewController {
    if ([NSThread isMainThread]) {
        if (rootViewController) {
            if ([WJ_UIROUTABLER_APP_WINDOW_ROOT_VIEW_CONTROLLER presentedViewController]) {
                [WJ_UIROUTABLER_APP_WINDOW_ROOT_VIEW_CONTROLLER dismissViewControllerAnimated:NO completion:NULL];
            }
            [[[[UIApplication sharedApplication] delegate] window] setRootViewController:rootViewController];
        }
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (rootViewController) {
                if ([WJ_UIROUTABLER_APP_WINDOW_ROOT_VIEW_CONTROLLER presentedViewController]) {
                    [WJ_UIROUTABLER_APP_WINDOW_ROOT_VIEW_CONTROLLER dismissViewControllerAnimated:NO completion:NULL];
                }
                [[[[UIApplication sharedApplication] delegate] window] setRootViewController:rootViewController];
            }
        });
    }
}

- (NSDictionary*)paramsOfUrl:(NSString*)url {
    return [[self routerParamsForUrl:url] controllerParams];
}

-(NSString*) getFullURL:(NSString*) URL {
    if (URL) {
        return [URL componentsSeparatedByString:@"?"][0];
    }
    return nil;
}

//根据url得到路由参数
- (WJRouterParams *)routerParamsForUrl:(NSString *)url extraParams: (NSDictionary *)extraParams {
    if (!url) {
        //if we wait, caching this as key would throw an exception
        if (_ignoresExceptions) {
            return nil;
        }
        WJLogError(@"URL 不能为空");
        @throw [NSException exceptionWithName:@"RouteNotFoundException"
                                       reason:@"URL 不能为空"
                                     userInfo:nil];
    }
    
    NSString *fullURL = [self getFullURL:url];
    
    NSMutableDictionary *mutableExtraParams = [[NSMutableDictionary alloc] init];
    [mutableExtraParams setObject:url forKey:WJ_ROUTER_URL_KEY];
    
    //额外参数
    if ([extraParams count] > 0) {
        [mutableExtraParams addEntriesFromDictionary:extraParams];
    }
    //url 中 ？后面的参数
    NSDictionary *urlParams = [WJURLUtils paramsWithFormURL:url];
    if ([urlParams count] > 0) {
        [mutableExtraParams addEntriesFromDictionary:urlParams];
    }
    
    /**
     *  如果routes中存在此url，则直接返回 WJRouterParams
     */
    if ([[self.routes allKeys] containsObject:fullURL]) {
        return [[WJRouterParams alloc] initWithRouterOptions:self.routes[fullURL] openParams:nil extraParams:mutableExtraParams];
    }
    
    //得到完整url
    
    NSArray *givenParts = fullURL.pathComponents;
    NSArray *legacyParts = [fullURL componentsSeparatedByString:@"/"];
    if ([legacyParts count] != [givenParts count]) {
        WJLogDebug(@"Routable Warning - your URL %@ has empty path components - this will throw an error in an upcoming release", url);
        givenParts = legacyParts;
    }
    
    __block WJRouterParams *openParams = nil;
    //遍历routes
    [self.routes enumerateKeysAndObjectsUsingBlock:
     ^(NSString *routerUrl, WJRouterOptions *routerOptions, BOOL *stop) {
         
         NSArray *routerParts = [routerUrl componentsSeparatedByString:@"/"];
         if ([routerParts count] == [givenParts count]) {
             
             NSDictionary *givenParams = [self paramsForUrlComponents:givenParts routerUrlComponents:routerParts];
             if (givenParams) {
                 openParams = [[WJRouterParams alloc] initWithRouterOptions:routerOptions openParams:givenParams extraParams:mutableExtraParams];
                 *stop = YES;
             }
         }
     }];
    
    if (!openParams) {
        openParams = [[WJRouterParams alloc] initWithRouterOptions:_routes[@"*"] openParams:nil extraParams:mutableExtraParams];
    }
    return openParams;
}

- (WJRouterParams *)routerParamsForUrl:(NSString *)url {
    return [self routerParamsForUrl:url extraParams: nil];
}

//创建一个视图控制器（并将参数赋值给此控制器）
- (UIViewController *)controllerForRouterParams:(WJRouterParams *)params url:(NSString*) url {

    UIViewController *controller = nil;
    if (params) {
        //得到视图控制器class
        Class controllerClass = params.routerOptions.openClass;
        if ([controllerClass conformsToProtocol:@protocol(IWJRouterViewController)]) {
            controller = [[controllerClass alloc] initWithURL:url routerParams:[params controllerParams]];
            controller.modalTransitionStyle = params.routerOptions.transitionStyle;
            controller.modalPresentationStyle = params.routerOptions.presentationStyle;
        } else {
            if (!_ignoresExceptions) {
                WJLogError(@"视图控制器没有实现IWJRouterViewController协议");
                @throw [NSException exceptionWithName:@"RoutableInitializerNotFound"
                                               reason:@"视图控制器没有实现IWJRouterViewController协议"
                                             userInfo:nil];
            }
        }
    }
    return controller;
}

-(NSDictionary *)paramsForUrlComponents:(NSArray *)givenUrlComponents
                    routerUrlComponents:(NSArray *)routerUrlComponents {
    
    __block NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [routerUrlComponents enumerateObjectsUsingBlock:
     ^(NSString *routerComponent, NSUInteger idx, BOOL *stop) {
         
         NSString *givenComponent = givenUrlComponents[idx];
         if ([routerComponent hasPrefix:@":"]) {
             NSString *key = [routerComponent substringFromIndex:1];
             [params setObject:givenComponent forKey:key];
         } else if (![routerComponent isEqualToString:givenComponent]) {
             params = nil;
             *stop = YES;
         }
     }];
    return params;
}

/**
 *  初始化
 */
-(void) singleInit {
    self.routes = [[NSMutableDictionary alloc] init];
    self.ignoresExceptions = YES;
    
    
    Class formatClazz = [[WJUIRoutableConfig sharedInstance] routerURLFormatter];
    if (formatClazz) {
        self.routerURLFormater = [[formatClazz alloc] init];
    }
}

+(instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[WJUIRoutable alloc] init];
        [sharedObject singleInit];
    });
    return sharedObject;
}

-(id)mutableCopy {
    return self;
}

-(id)copy {
    return self;
}

+(id)allocWithZone:(NSZone *)zone {
    @synchronized (self) {
        if (sharedObject == nil) {
            sharedObject = [super allocWithZone:zone];
        }
    }
    return sharedObject;
}

@end
