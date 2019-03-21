//
//  OtherModule.m
//  ios-jucaicat
//
//  Created by 吴云海 on 17/5/23.
//  Copyright © 2017年 wuyunhai. All rights reserved.
//

#import "OtherModule.h"
#import "CocoaLumberjack.h"
#import <Bugly/Bugly.h>


#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define _IPHONE80_ 80000

@interface OtherModule ()

@property(nonatomic, copy) NSString *currentUserCode;

@end

@implementation OtherModule


-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self routerMapAction];
    [self svprogressHUDConfig];
    [self cleanCache];
    [self logConfig];
    [self vendorConfig];
    
//    if (USER_IS_LOGINED) {
//        [self registerConfig];
//    } else {
//        [self removeConfig];
//    }
    
    //配置事件统计
//    [JccMobClick registerAppConfig:[JccAnalyticsConfig instanceWithAppKey:@"jucaicat" policy:JccReportPolicyRealTime] dataStoreage:[JccAppAnalyticsDataStorage sharedInstance]];
//    self.currentUserCode = USER_CODE;
    
    //配置外观
    [self appearanceConfig];
    
//    [LaunchPageManager sharedInstance];
    return YES;
}

//配置路由
-(void)routerMapAction {
//#ifdef DEBUG
//    //切换服务环境
//    [[WJUIRoutable sharedInstance] map:UI_ROUTER_URL_SERVER_CONTEXT_CHOOSE toController:[ChooseServerContextViewController class] withOptions:[WJRouterOptions modal]];
//    [[WJUIRoutable sharedInstance] map:UI_ROUTER_URL_WEB_TEST_TOOLS toController:[DebugWebViewController class]];
//#endif
}


-(void)svprogressHUDConfig {
    //配置SVProgressHUD
    [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}


//配置UI外观
-(void)appearanceConfig {
    /**
     *  UIBarButtonItem
     */
    UIColor *barBtnItemTitleColorNormal = APP_BAR_BUTTON_ITEM_TITLE_COLOR_NORMAL;
    UIColor *barBtnItemTitleColorSelected = APP_BAR_BUTTON_ITEM_TITLE_COLOR_SELECTED;
    UIFont *barBtnItemTitleFontNormal = APP_BAR_BUTTON_ITEM_TITLE_FONT_NORMAL;
    UIFont *barBtnItemTitleFontSelected = APP_BAR_BUTTON_ITEM_TITLE_FONT_SELECTED;
    
    NSMutableDictionary *titleAttributes = [[NSMutableDictionary alloc] init];
    if (barBtnItemTitleColorNormal) {
        [titleAttributes setObject:barBtnItemTitleColorNormal forKey:NSForegroundColorAttributeName];
    }
    if (barBtnItemTitleFontNormal) {
        [titleAttributes setObject:barBtnItemTitleFontNormal forKey:NSFontAttributeName];
    }
    if ([titleAttributes count] > 0) [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithDictionary:titleAttributes] forState:UIControlStateNormal];
    [titleAttributes removeAllObjects];
    if (barBtnItemTitleColorSelected) {
        [titleAttributes setObject:barBtnItemTitleColorSelected forKey:NSForegroundColorAttributeName];
    }
    if (barBtnItemTitleFontSelected) {
        [titleAttributes setObject:barBtnItemTitleFontSelected forKey:NSFontAttributeName];
    }
    if ([titleAttributes count] > 0) {
        [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithDictionary:titleAttributes] forState:UIControlStateHighlighted];
    }
    [titleAttributes removeAllObjects];
    
    /**
     *  UINavigation
     */
    UIColor *navBarTintColor = APP_NAVBAR_BAR_TINT_COLOR;
    UIColor *navTintColor = APP_NAVBAR_TINT_COLOR;
    UIColor *navBackgroundColor = APP_NAVBAR_BACKGROUND_COLOR;
    UIImage *navBackgroundImage = APP_NAVBAR_BACKGROUND_IMAGE;
    UIImage *navBackIndicatorImage = APP_NAVBAR_BACK_INDICATOR_IMAGE;
    
    if (navBarTintColor) [[UINavigationBar appearance] setBarTintColor:navBarTintColor];
    if (navTintColor) [[UINavigationBar appearance] setTintColor:navTintColor];
    if (navBackgroundColor) [[UINavigationBar appearance] setBackgroundColor:navBackgroundColor];
    if (navBackIndicatorImage) [[UINavigationBar appearance] setBackIndicatorImage:navBackIndicatorImage];
    if (navBackgroundImage) [[UINavigationBar appearance] setBackgroundImage:navBackgroundImage forBarMetrics:UIBarMetricsDefault];
    
    UIColor *navTitleColor = APP_NAVBAR_TITLE_COLOR;
    UIFont *navTitleFont = APP_NAVBAR_TITLE_FONT;
    
    if (navTitleColor) {
        [titleAttributes setObject:navTitleColor forKey:NSForegroundColorAttributeName];
    }
    if (navTitleFont) {
        [titleAttributes setObject:navTitleFont forKey:NSFontAttributeName];
    }
    if ([titleAttributes count] > 0) {
        [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithDictionary:titleAttributes]];
    }
    [titleAttributes removeAllObjects];
    
    
    /**
     *  UITabBar
     */
    UIColor *tabBarTintColor = APP_TABBAR_BAR_TINT_COLOR;
    UIColor *tabTintColor = APP_TABBAR_TINT_COLOR;
    UIColor *tabBackgroundColor = APP_TABBAR_BACKGROUND_COLOR;
    UIImage *tabBackgroundImage = APP_TABBAR_BACKGROUND_IMAGE;
    
    if (tabBarTintColor) [[UITabBar appearance] setBarTintColor:tabBarTintColor];
    if (tabTintColor) [[UITabBar appearance] setTintColor:tabTintColor];
    if (tabBackgroundColor) [[UITabBar appearance] setBackgroundColor:tabBackgroundColor];
    if (tabBackgroundImage) [[UITabBar appearance] setBackgroundImage:tabBackgroundImage];
    
    
    UIColor *tabItemTitleColorNormal = APP_TABBAR_ITEM_TITLE_COLOR_NORMAL;
    UIColor *tabItemTitleColorSelected = APP_TABBAR_ITEM_TITLE_COLOR_SELECTED;
    UIFont *tabItemTitleFontNormal = APP_TABBAR_ITEM_TITLE_FONT_NORMAL;
    UIFont *tabItemTitleFontSelected = APP_TABBAR_ITEM_TITLE_FONT_SELECTED;
    
    if (tabItemTitleFontNormal) {
        [titleAttributes setObject:tabItemTitleFontNormal forKey:NSFontAttributeName];
    }
    if (tabItemTitleColorNormal) {
        [titleAttributes setObject:tabItemTitleColorNormal forKey:NSForegroundColorAttributeName];
    }
    if ([titleAttributes count] > 0) {
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithDictionary:titleAttributes] forState:UIControlStateNormal];
    }
    [titleAttributes removeAllObjects];
    if (tabItemTitleFontSelected) {
        [titleAttributes setObject:tabItemTitleFontSelected forKey:NSFontAttributeName];
    }
    if (tabItemTitleColorSelected) {
        [titleAttributes setObject:tabItemTitleColorSelected forKey:NSForegroundColorAttributeName];
    }
    
    if ([titleAttributes count] > 0) {
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithDictionary:titleAttributes] forState:UIControlStateSelected];
    }
    
    [titleAttributes removeAllObjects];
}


-(void)cleanCache {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

//日志配置
-(void)logConfig {
#ifdef DEBUG
    [DDLog addLogger:[DDTTYLogger sharedInstance] withLevel:DDLogLevelAll];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
#else
    [DDLog addLogger:[DDTTYLogger sharedInstance] withLevel:DDLogLevelError];
#endif
}

//领域配置
-(void)vendorConfig {
    //友盟统计
//#ifdef DEBUG
//    [MobClick setAppVersion:[NSString stringWithFormat:@"%@.dev",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]];
//#else
//    [MobClick setAppVersion:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
//#endif
//    UMConfigInstance.appKey = JCC_UMENG_APP_KEY;
//    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
//    if(UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
//    {
//        //register remoteNotification types
//        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
//        action1.identifier = @"action1_identifier";
//        action1.title=@"允许";
//        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
//
//        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
//        action2.identifier = @"action2_identifier";
//        action2.title=@"拒绝";
//        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
//        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
//        action2.destructive = YES;
//
//        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
//        categorys.identifier = @"category1";//这组动作的唯一标示
//        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
//
//        [UMessage registerForRemoteNotifications:[NSSet setWithObject:categorys]];
//    } else{
//        //register remoteNotification types
//        [UMessage registerForRemoteNotifications];
//    }
//#else
//    //register remoteNotification types
//    [UMessage registerForRemoteNotifications];
//#endif
    
    
    //腾讯bugly异常上报
    [Bugly startWithAppId:JCC_BUGLY_APP_ID];
}


-(instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUserLogoutNotification:) name:UserLogoutNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUserLoginedNotification:) name:UserLoginedNotification object:nil];
    }
    return self;
}

-(void)handleUserLogoutNotification:(NSNotification*)notification {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeConfig];
    });
}

-(void)handleUserLoginedNotification:(NSNotification*)notification {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self registerConfig];
    });
}

//统计
-(void)registerConfig {
//    self.currentUserCode = USER_CODE;
    
//    NSString *phoneNumber = USER_PHONE_NUMBER;
//    if (WJ_STRING_IS_NOT_EMPTY(phoneNumber)) {
//        //        [Growing setCS2Value:phoneNumber forKey:@"phone_number"];
//        [UMessage addAlias:phoneNumber type:@"phone_number" response:^(id responseObject, NSError *error) {
//            
//        }];
//    }
//    if (self.currentUserCode) {
//        [UMessage addAlias:self.currentUserCode type:@"user_id" response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
//        }];
//    }
//
//    [JCCUtils addAPushTag:@"login"];
//    [JCCUtils deleteAPushTag:@"not_login"];
}
//统计
-(void)removeConfig {
    //    [Growing setCS1Value:@"" forKey:@"user_id"];
    //    [Growing setCS2Value:@"" forKey:@"phone_number"];
//    NSString *phoneNumber = USER_PHONE_NUMBER;
//    if (WJ_STRING_IS_NOT_EMPTY(phoneNumber)) {
//        [UMessage removeAlias:phoneNumber type:@"phone_number" response:^(id responseObject, NSError *error) {
//            
//        }];
//    }
    
//    if (self.currentUserCode) {
//        [UMessage removeAlias:self.currentUserCode type:@"user_id" response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
//        }];
//
//        self.currentUserCode = nil;
//    }
//
//    [JCCUtils addAPushTag:@"not_login"];
//    [JCCUtils deleteAPushTag:@"login"];
//    [JCCUtils deleteAPushTag:@"trade_user"];
//    [JCCUtils deleteAPushTag:@"vip"];
}


-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
