//
//  AppDelegate.m
//  Hulk
//
//  Created by 张学超 on 2018/10/13.
//  Copyright © 2018年 张学超. All rights reserved.
//

#import "AppDelegate.h"



@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#ifdef DEBUG
    NSLog(@"%f",CFAbsoluteTimeGetCurrent());
#endif
    self.window =[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    
    UIViewController *vc = [[UIViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
