//
//  AppTabBarViewModel.m
//  ios-jucaicat
//
//  Created by 张学超 on 16/9/18.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "AppTabBarViewModel.h"
#import "WJHttpFactory.h"
#import "JccTabBarAppearance.h"
#import "JccTabBarItemAppearance.h"
#import "QueryTabbarIconHttpApi.h"
#import "QueryTabbarIconResDTO.h"

@interface AppTabBarViewModel ()

@property(nonatomic, strong)id<IWJHttpEngine> httpEngine;

@property(nonatomic, copy) id<ITabBarAppearance> currentTabBarAppearance;

@property(nonatomic, weak) JccTabBarItemAppearance *myTabBarItemAppearance;

@property(nonatomic, copy) QueryTabbarIconResDTO *tabBarIconResData;

@property(nonatomic, assign) BOOL fetchDataTag;

@end

@implementation AppTabBarViewModel

-(id<ITabBarAppearance>)tabBarAppearance {
    return _currentTabBarAppearance;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        self.httpEngine = [WJHttpFactory buildHttpEngine];
        
        JccTabBarAppearance *tabBarAppearance = [[JccTabBarAppearance alloc] init];
        JccTabBarItemAppearance *item0 = [[JccTabBarItemAppearance alloc] init];
        [item0 setNormalTitle:@"首页"];
        [item0 setSelectedTitle:@"首页"];
        [item0 setNormalIconName:@"tabbar-icon-home-normal"];
        [item0 setSelectedIconName:@"tabbar-icon-home-selected"];
//        JccTabBarItemAppearance *item1 = [[JccTabBarItemAppearance alloc] init];
//        [item1 setNormalTitle:@"投资"];
//        [item1 setSelectedTitle:@"投资"];
//        [item1 setNormalIconName:@"tabbar-icon-invest-normal"];
//        [item1 setSelectedIconName:@"tabbar-icon-invest-selected"];
        JccTabBarItemAppearance *item2 = [[JccTabBarItemAppearance alloc] init];
        [item2 setNormalTitle:@"订单"];
        [item2 setSelectedTitle:@"订单"];
        [item2 setNormalIconName:@"tabbar-icon-assets-normal"];
        [item2 setSelectedIconName:@"tabbar-icon-assets-selected"];
        JccTabBarItemAppearance *item3 = [[JccTabBarItemAppearance alloc] init];
        _myTabBarItemAppearance = item3;
        [item3 setNormalTitle:@"我的"];
        [item3 setSelectedTitle:@"我的"];
        [item3 setNormalIconName:@"tabbar-icon-my-normal"];
        [item3 setSelectedIconName:@"tabbar-icon-my-selected"];
        [tabBarAppearance setTabBarItemAppearances:@[item0,item2,item3]];
        self.currentTabBarAppearance = tabBarAppearance;
    }
    return self;
}

-(void)fetchImgUrlsAction {
    if (self.tabBarIconResData) {
        NSMutableSet *imageURLs = [[NSMutableSet alloc] init];
        if (WJ_STRING_IS_NOT_EMPTY([self.tabBarIconResData backgroundImgUrl])) {
            [imageURLs addObject:[self.tabBarIconResData backgroundImgUrl]];
        }
        for (TabbarIconDTO *data in [self.tabBarIconResData icons]) {
            if (WJ_STRING_IS_NOT_EMPTY([data normalImgUrl])) {
                [imageURLs addObject:[data normalImgUrl]];
            }
            if (WJ_STRING_IS_NOT_EMPTY([data selectedImgUrl])) {
                [imageURLs addObject:[data selectedImgUrl]];
            }
        }
        if ([imageURLs count] > 0) {
            [self downloadIconImages:imageURLs.allObjects];
        }
    }
}

-(void)wj_viewDidAppear {
    [super wj_viewDidAppear];
    
    //请求数据
    
//    if (![_httpEngine hasLoading] && !_fetchDataTag) {
//        self.fetchDataTag = YES;
//        //请求数据
//        QueryTabbarIconHttpRequest *request = [[QueryTabbarIconHttpRequest alloc] init];
//        WJ_WEAK_REF_TYPE weakSelf = self;
//        [_httpEngine asynRequest:request responseClass:[QueryTabbarIconHttpResponse class] responseBlock:^(id<IWJHttpResponse> res, NSError *error) {
//            if (error) {
//                WJLogWarn(@"%@",error);
//            } else {
//                if ([res isError]) {
//                    WJLogWarn(@"%@",[res errorMsg]);
//                } else {
//                    QueryTabbarIconResDTO *resData = [(QueryTabbarIconHttpResponse*)res data];
//                    [resData changeScaleImageUrlAction];
//                    weakSelf.tabBarIconResData = resData;
//                    [weakSelf fetchImgUrlsAction];
//                }
//            }
//        }];
//    }
    
}

-(void)refreshUnreadMsg {
//    int unreadMsgCount = [[MsgContext sharedInstance] unreadMsgCount];
//    if ([[MsgContext sharedInstance] existUnreadOnlineServiceMsg]) {
//        unreadMsgCount += 1;
//    }
//    if (_myTabBarItemAppearance && unreadMsgCount != (int)[_myTabBarItemAppearance unreadMsgCount]) {
//        [_myTabBarItemAppearance setUnreadMsgCount:unreadMsgCount];
//        [self willChangeValueForKey:@"tabBarAppearance"];
//        [self didChangeValueForKey:@"tabBarAppearance"];
//    }
}

-(void)refreshTabBarAppearance {
    if (self.tabBarIconResData && ([[self.tabBarIconResData icons] count] == 3 || [[self.tabBarIconResData icons] count] == 5)) {
        NSMutableArray *tabBarItems = [[NSMutableArray alloc] init];
        NSArray *icons = [self.tabBarIconResData icons];
        NSUInteger len = [icons count];
        for (NSUInteger i = 0; i < len; i++) {
            TabbarIconDTO *data = icons[i];
            JccTabBarItemAppearance *item = [[JccTabBarItemAppearance alloc] init];
            [item setNormalTitle:[data normalTitle]];
            [item setSelectedTitle:[data selectedTitle]];
            NSString *fileName = [data normalIconFileName];
            NSString *normalFilePath = [WJ_FILE_DIR_TMP stringByAppendingPathComponent:fileName?fileName:@""];
            NSString *selectedFileName = [data selectedIconFileName];
            NSString *selectedFilePath = [WJ_FILE_DIR_TMP stringByAppendingPathComponent:selectedFileName?selectedFileName:@""];
            [item setNormalIconPath:normalFilePath];
            [item setSelectedIconPath:selectedFilePath];
            [item setIsVenue:([data iconType] == 1)];
            if ([item isVenue] && WJ_STRING_IS_NOT_EMPTY([data targetUrl])) {
                self.venueURL = [data targetUrl];
            }
            [tabBarItems addObject:item];
        }
        
        JccTabBarAppearance *tabBarAppearance = [[JccTabBarAppearance alloc] init];
        [tabBarAppearance setBackgroundColorHexString:[self.tabBarIconResData backgroundColorHex]];
        if (WJ_STRING_IS_NOT_EMPTY([self.tabBarIconResData backgroundImgUrl])) {
            NSString *bgFileName = [self.tabBarIconResData backgroundImgFileName];
            [tabBarAppearance setBackgroundPath:[WJ_FILE_DIR_TMP stringByAppendingPathComponent:bgFileName?bgFileName:@""]];
        }
        [tabBarAppearance setTabBarItemAppearances:tabBarItems];
        _myTabBarItemAppearance = [[tabBarAppearance tabBarItemAppearances] lastObject];
        [self refreshUnreadMsg];
        self.currentTabBarAppearance = tabBarAppearance;
        [self willChangeValueForKey:@"tabBarAppearance"];
        [self didChangeValueForKey:@"tabBarAppearance"];
    }
}

-(void)downloadIconImages:(NSArray*)imageURLs {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //放入临时目录
        BOOL downloadFinished = YES;
        for (NSString *imgURL in imageURLs) {
            NSString *md5 = WJ_SECURITY_MD5([imgURL dataUsingEncoding:NSUTF8StringEncoding]);
            NSString *extension = [imgURL pathExtension];
            if (md5 && extension) {
                NSString *fileName = [NSString stringWithFormat:@"%@.%@",md5,extension];
                NSString *filePath = [WJ_FILE_DIR_TMP stringByAppendingPathComponent:fileName];
                WJLogDebug(@"%@",filePath);
                if (!WJ_FILE_EXIST(filePath)) {
                    //下载
                    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgURL]];
                    if (data) {
                        //写入本地文件夹
                        
                        if ([WJFileUtils writeFile:data forPath:filePath replace:YES]) {
                            WJLogDebug(@"下载图片成功~");
                        } else {
                            WJLogError(@"写入文件错误:%@",filePath);
                            downloadFinished = NO;
                            break;
                        }
                    } else {
                        WJLogError(@"下载图片失败:%@",imgURL);
                        downloadFinished = NO;
                        break;
                    }
                }
            } else {
                WJLogError(@"存在无效文件名称和扩展名:%@-%@",md5,extension);
                downloadFinished = NO;
                break;
            }
        }
        
        if (downloadFinished) {
            //刷新底部tabbar
            [self performSelectorOnMainThread:@selector(refreshTabBarAppearance) withObject:nil waitUntilDone:NO];
        }
    });
}

@end
