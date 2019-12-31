//
//  OtherModuleMacros.h
//  ios-jucaicat
//
//  Created by 吴云海 on 17/6/15.
//  Copyright © 2017年 wuyunhai. All rights reserved.
//


#import "H5URLNameDefine.h"
#import "WJCommon.h"
#import "WJCommonUtils.h"
#import "WJCommonUI.h"
#import "WJLoggingMacros.h"
#import "WJUIRoutable.h"
#import "KVOController.h"

#import "WJHttpFactory.h"
//H5路径配置
#import "H5ConfigContext.h"
//API
#import "AppAPI.h"
//App 外观宏
#import "AppearanceMacro.h"
//提示器
#import "SVProgressHUD.h"
//SDWebImage
#import "UIImageView+WebCache.h"
//Masonry
#import "Masonry.h"
//WJAppContext
#import "WJAppContext.h"
#import "WJSession.h"
//第三方库配置
#import "VendorsConfigs.h"
//UI 跳转url

//YYKit
#import <YYText/YYText.h>
//设备id
#import "UIDevice+WJUDID.h"
//工具类
//缓存类型
#import "JccCacheType.h"
#import "WJCacheType.h"
#import "WJCacheFactory.h"
#import "BlockAlertView.h"
#import "JccAlertView.h"


#ifdef DEBUG

    //服务环境切换
    #define UI_ROUTER_URL_SERVER_CONTEXT_CHOOSE                                 @"jucaicat://lc.jucaicat/server/context/choose"
    //Web测试工具
    #define UI_ROUTER_URL_WEB_TEST_TOOLS                                        @"jucaicat://lc.jucaicat/web/test/tools"

#endif

//CEO留言
#define UI_ROUTER_URL_OTHER_CEO_FEEDBACK                                    @"jucaicat://lc.jucaicat/other/ceo/feedback"

//在线客服
#define UI_ROUTER_URL_OTHER_ONLINE_SERVICE                                  @"jucaicat://lc.jucaicat/other/online/service"

//禁用功能处理（params：content）
#define UI_ROUTER_URL_OTHER_DISABLE_FEATURE_HANDLER                         @"jucaicat://lc.jucaicat/other/disable/feature/handler"

//积分商城
#define UI_ROUTER_URL_OTHER_INTEGRAL_MALL                                   @"jucaicat://lc.jucaicat/other/integral/mall"

//消息中心
#define UI_ROUTER_URL_OTHER_MESSAGE_MSGLIST                                   @"jucaicat://lc.jucaicat/msg/list"
