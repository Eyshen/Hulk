//
//  AppDelegate.m
//  Hulk
//
//  Created by 张学超 on 2018/10/13.
//  Copyright © 2018年 张学超. All rights reserved.
//

#import "AppDelegate.h"
#import "WJAPPContext.h"


@interface AppDelegate ()

@property (nonatomic, unsafe_unretained) UIBackgroundTaskIdentifier backgroundTaskIdentifier;

@property(nonatomic, assign) long duration;

@end

@implementation AppDelegate

-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler{
    return [[WJAppContext sharedInstance] application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#ifdef DEBUG
    NSLog(@"%f",CFAbsoluteTimeGetCurrent());
#endif
    self.window =[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [WJAppContext registerAppContext];
    [[WJAppContext sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    return YES;
}

//程序进入后台
-(void)applicationDidEnterBackground:(UIApplication *)application{
    if (![self isMutiltaskingSupported]) {
        return;
    }
    
    self.backgroundTaskIdentifier = [application beginBackgroundTaskWithExpirationHandler:^{
        [self endBackgroundTask];
    }];
}

- (BOOL)isMutiltaskingSupported {
    BOOL result = NO;
    if ( [[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)]) {
        result = [[UIDevice currentDevice] isMultitaskingSupported];
    }
    return result;
}

-(void)endBackgroundTask {
    [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTaskIdentifier];
    self.backgroundTaskIdentifier = UIBackgroundTaskInvalid;
}

//打开app工程回调
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [[WJAppContext sharedInstance] application:application handleOpenURL:url];
}

//app回调
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [[WJAppContext sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

//app回调
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    if (@available(iOS 9.0, *)) {
        return [[WJAppContext sharedInstance] application:application openURL:url options:options];
    } else {
        return NO;
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [[WJAppContext sharedInstance] application:application didReceiveRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[WJAppContext sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler {
    [[WJAppContext sharedInstance] application:application handleActionWithIdentifier:identifier forRemoteNotification:userInfo completionHandler:completionHandler];
}

//程序失去焦点
- (void)applicationWillResignActive:(UIApplication *)application {
    
}

//程序从后台回到前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    if(self.backgroundTaskIdentifier != UIBackgroundTaskInvalid){
        [self endBackgroundTask];
    }
}

//程序获取焦点(程序变的活跃)
- (void)applicationDidBecomeActive:(UIApplication *)application {

}

//程序内存警告, 可能要终止程序
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    
}

//程序即将退出
- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
