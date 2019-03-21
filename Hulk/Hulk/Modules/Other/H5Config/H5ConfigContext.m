//
//  H5ConfigContext.m
//  ios-jucaicat
//
//  Created by 吴云海 on 16/8/26.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "H5ConfigContext.h"
#import "WJHttpFactory.h"
#import "FetchH5ConfigAPI.h"
#import "WJCacheAPI.h"

#ifdef DEBUG

#define H5_CONFIG_LAST_UPDATE_TIME_KEY  @"debug_h5ConfigLastUpdateTimeKeyV2"
#define H5_CONFIG_DATA_KEY              @"debug_h5ConfigDataKeyV2"
#define H5_CONFIG_DATA_VERSION_KEY      @"debug_h5ConfigDataVersionKey"

#else

#define H5_CONFIG_LAST_UPDATE_TIME_KEY  @"h5ConfigLastUpdateTimeKeyV2"
#define H5_CONFIG_DATA_KEY              @"h5ConfigDataKeyV2"
#define H5_CONFIG_DATA_VERSION_KEY      @"h5ConfigDataVersionKey"

#endif

//#define H5_CLEAR_CACHE_240              @"h5ClearCache2.4.0"

@interface H5ConfigContext ()

@property(nonatomic, strong) id<IWJHttpEngine> httpEngine;

@property(nonatomic, weak) id<IWJCache> cache;

//@property(nonatomic, weak) id<IWJCache> clearCache;

@property(nonatomic, assign) long lastUpdateTime;

@property(nonatomic, strong) NSMutableDictionary *h5ConfigData;

@property(nonatomic, assign) long syncLastUpdateTime;

@end

@implementation H5ConfigContext

DEF_SINGLETON_INIT(H5ConfigContext)
 
-(void) singleInit {
    //单利初始化
    self.h5ConfigData = [[NSMutableDictionary alloc] init];
    self.httpEngine = [WJHttpFactory buildHttpEngine];
    self.cache = WJ_CACHE_OBJECT(JccCacheTypeDisk);
    
    
    NSString *dataVersionKey = [self.cache stringForKey:H5_CONFIG_DATA_VERSION_KEY];
    if (!WJ_STRING_EQUAL(dataVersionKey, WJ_APPLICATION_SHORT_VERSION)) {
        [self.cache removeObjectForKey:H5_CONFIG_DATA_KEY];
        [self.cache removeObjectForKey:H5_CONFIG_LAST_UPDATE_TIME_KEY];
        [self.cache setString:WJ_APPLICATION_SHORT_VERSION forKey:H5_CONFIG_DATA_VERSION_KEY];
    }
    
    #ifdef DEBUG
        [self.cache removeObjectForKey:H5_CONFIG_DATA_KEY];
    #endif

    
    NSDictionary *d = (NSDictionary*)[self.cache objectForKey:H5_CONFIG_DATA_KEY];
    
    [self configDefaultH5URL];
    if (d) [self.h5ConfigData addEntriesFromDictionary:d];
    [self.cache setObject:self.h5ConfigData forKey:H5_CONFIG_DATA_KEY];
    if ([d count] != 0 && [self.cache objectForKey:H5_CONFIG_LAST_UPDATE_TIME_KEY]) {
        self.lastUpdateTime = [(NSNumber*)[self.cache objectForKey:H5_CONFIG_LAST_UPDATE_TIME_KEY] longValue];
    }
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationDidFinishLaunchingNotification:) name:UIApplicationDidFinishLaunchingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationDidBecomeActiveNotification:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

-(void)handleApplicationDidFinishLaunchingNotification:(NSNotification*)notification {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self syncH5Config];
    });
}

-(void)handleApplicationDidBecomeActiveNotification:(NSNotification*)notification {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self syncH5Config];
    });
}

-(NSString *)fetchH5URL:(NSString *)h5Name {
    return _h5ConfigData[h5Name];
}


/**
 *  同步最新的H5
 */
-(void)syncH5Config {
    //每隔10分钟同步一次
    if ([[NSDate date] timeIntervalSince1970] - _syncLastUpdateTime > 60*10) {
        if (![_httpEngine hasLoading]) {
            WJ_WEAK_REF_TYPE weakSelf = self;
            FetchH5ConfigRequest *request = [[FetchH5ConfigRequest alloc] init];
            [request setLastUpdateTime:_lastUpdateTime];
            [_httpEngine asynRequest:request responseClass:[FetchH5ConfigResponse class] responseBlock:^(id<IWJHttpResponse> res, NSError *error) {
                if (error) {
                    WJLogWarn(@"同步H5配置报错%@",error);
                } else {
                    if ([res isError]) {
                        WJLogError(@"%@",[res errorMsg]);
                    } else {
                        FetchH5ConfigResponse *response = (FetchH5ConfigResponse*) res;
                        FetchH5ConfigResDTO *resDTO = [response data];
                        if (resDTO) {
                            weakSelf.lastUpdateTime = [resDTO lastUpdateTime];
                            for (H5ConfigDTO *c in [resDTO h5PageDataList]) {
                                [weakSelf.h5ConfigData setObject:[c h5Url] forKey:[c h5Name]];
                            }
                            [weakSelf.cache setObject:@([resDTO lastUpdateTime]) forKey:H5_CONFIG_LAST_UPDATE_TIME_KEY];
                            [weakSelf.cache setObject:weakSelf.h5ConfigData forKey:H5_CONFIG_DATA_KEY];
                            weakSelf.syncLastUpdateTime = [[NSDate date] timeIntervalSince1970];
                        }
                    }
                }
            }];
        }
    }
}

/**
 *  配置默认H5 url
 */
-(void)configDefaultH5URL {
    NSDictionary *dict = @{
                            H5_URL_NAME_DEPO_PROCESSING:@"https://www.jucaicat.com.cn/activitiesH5/monthly/201706/depository/html/index.html",
                            H5_URL_NAME_FAQ:@"https://www.jucaicat.com.cn/app_outer_h5/app381/contracts/FAQ/index.html",
                            H5_URL_NAME_LOAN_AGREEMENT_LIST:@"https://www.jucaicat.com.cn/app_outer_h5/appH5_300/modules/contractList_yq/html/index.html",
                            H5_URL_NAME_LOAN_AGREEMENT_LIST_FULIN:@"https://www.jucaicat.com.cn/app_outer_h5/appH5_300/modules/contractList_fl/html/index.html",
                            H5_URL_NAME_LOAN_AGREEMENT_LIST_OLD:@"https://www.jucaicat.com.cn/app_outer_h5/appH5_300/modules/averageInterest/html/index.html",
                            H5_URL_NAME_SERVICE_AGREEMENT_TEMPLATE:@"https://www.jucaicat.com.cn/app_outer_h5/app381/contracts/serviceProtocol/index.html",
                            H5_URL_NAME_SERVICE_AGREEMENT_TEMPLATE_FULIN:@"https://www.jucaicat.com.cn/app_outer_h5/appH5_300/modules/contractList_fl/html/template_1.html",
                            H5_URL_NAME_STATIC_SERVICE_AGREEMENT_TEMPLATE:@"https://www.jucaicat.com.cn/app_outer_h5/app381/contracts/loanProtocol/index.html ",
                            H5_URL_NAME_STATIC_SERVICE_AGREEMENT_TEMPLATE_FULIN:@"https://www.jucaicat.com.cn/app_outer_h5/appH5_300/modules/contractList_fl/html/assignmentAgm_template.html",
                            H5_URL_NAME_STATIC_SERVICE_AGREEMENT_DEBT_TEMPLATE_FULIN:@"https://www.jucaicat.com.cn/app_outer_h5/appH5_300/modules/contractList_fl/html/assignmentDebt_template.html",
                            H5_URL_NAME_STATIC_DEPO_SERVICE_AGREEMENT:@"https://www.jucaicat.com.cn/app_outer_h5/appH5_300/modules/contractList_yq/html/1.html",
                            H5_URL_NAME_STATIC_RISK_WARNING:@"https://www.jucaicat.com.cn/app_outer_h5/appH5_300/modules/contractList_yq/html/2.html",
                            H5_URL_NAME_STATIC_RISK_WARNING_FULIN:@"https://www.jucaicat.com.cn/app_outer_h5/appH5_300/modules/contractList_fl/html/riskWarning.html",
                            H5_URL_NAME_STATIC_DISCLAIMER:@"https://www.jucaicat.com.cn/app_outer_h5/appH5_300/modules/contractList_yq/html/3.html",
                            H5_URL_NAME_STATIC_DISCLAIMER_FULIN:@"https://www.jucaicat.com.cn/app_outer_h5/appH5_300/modules/contractList_fl/html/responlibility.html",
                            H5_URL_NAME_SERVICE_AGREEMENT:@"https://www.jucaicat.com.cn/app_outer_h5/appH5_300/modules/contractList_yq/html/4.html",
                            H5_URL_NAME_SERVICE_AGREEMENT_FULIN:@"https://www.jucaicat.com.cn/app_outer_h5/appH5_300/modules/contractList_fl/html/serviceAgm.html",
                            H5_URL_NAME_SERVICE_AGREEMENT_CURRENT:@"https://www.jucaicat.com.cn/app_outer_h5/appH5_300/modules/contractList_yq/html/8.html",
                            H5_URL_NAME_CONDITIONS_CREDITOR_CONFIRM_AGREEMENT:@"https://www.jucaicat.com.cn/app_outer_h5/appH5_300/modules/contractList_yq/html/7.html",
                            H5_URL_NAME_LOAN_AGREEMENT:@"https://www.jucaicat.com.cn/app_outer_h5/appH5_300/modules/contractList_yq/html/6.html",
                            H5_URL_NAME_CREDITOR_TRANSFE_AGREEMENT:@"https://www.jucaicat.com.cn/app_outer_h5/appH5_300/modules/contractList_yq/html/5.html",
                            H5_URL_NAME_CREDITOR_TRANSFE_AGREEMENT_DEMO:@"https://www.jucaicat.com.cn/app_outer_h5/appH5_300/modules/averageInterest/html/contract_3_template.html",
                            H5_URL_NAME_USER_REGISTER_AGREEMENT:@"https://www.jucaicat.com.cn/app_outer_h5/app381/contracts/regist/index.html",
                            H5_URL_NAME_RECENT_EXPIRE_PRODUCT:@"https://www.jucaicat.com.cn/app_outer_h5/appH5_211/modules/expireOrders/html/expireList.html",
#ifdef DEBUG
                            H5_URL_NAME_PRODUCT_DETAIL_FIXED_PERIOD:@"http://www.jucaicat.com.cn/app_outer_h5/app350/productDetail/html/detail_month.html",
                            H5_URL_NAME_INCOME_DETAILED:@"http://www.jucaicat.com.cn/app_outer_h5/appH5_300/modules/userDailyProfit/index.html",
                            H5_URL_NAME_PRODUCT_DETAIL_FIXED_PERIOD_V2:@"http://www.jucaicat.com.cn/app_outer_h5/app381/productDetail/html/index.html",
                            H5_URL_NAME_CREDITOR_DETAIL:@"http://www.jucaicat.com.cn/app_outer_h5/app350/creditorDetail_2/index.html",

                            H5_URL_NAME_STATEMENT_OF_ACCOUNT:@"http://jucaicat.com.cn/activitiesH5/flexible/201711/bill/html/bill_list.html",
                            
                            H5_URL_NAME_AUTH_AUTO_INVESTMENT:@"http://www.jucaicat.com.cn/app_outer_h5/theWander/notice2/html/entrust_lent_coa.html",
                            //上线前修改
                            H5_URL_NAME_AUTH_RISK_NOTICE:@"http://www.jucaicat.com.cn/app_outer_h5/theWander/notice2/html/risk_letter.html",
                            //上线前修改
                            H5_URL_NAME_AUTH_BAN_NOTICE:@"http://www.jucaicat.com.cn/app_outer_h5/theWander/notice2/html/noactive_notice.html",
                            
                            H5_URL_NAME_AUTHAGREEMENT_LIST:@"http://www.jucaicat.com.cn/app_outer_h5/theWander/notice2/html/list_completed.html",
                            
                            
                            H5_URL_NAME_CREDITOR_AGREEMENT_NEW_TEMPLATE:@"http://www.jucaicat.com.cn/app_outer_h5/app381/contracts/creditorAgreementNew/index.html ",
                            H5_URL_NAME_SIGN_SEAL_PROTOCAL_TEMPLATE:@"http://www.jucaicat.com.cn/app_outer_h5/app381/contracts/signSealProtocol/index.html",
                            H5_URL_NAME_AUTO_AUTHORIZATION_TEMPLATE:@"http://www.jucaicat.com.cn/app_outer_h5/app381/contracts/autoAuthorization/index.html",
                            H5_URL_NAME_RISKTIPS_TEMPLATE:@"http://www.jucaicat.com.cn/app_outer_h5/app381/contracts/riskTip/index.html",
                            

#else
                           H5_URL_NAME_INCOME_DETAILED:@"https://www.jucaicat.com.cn/app_outer_h5/appH5_300/modules/userDailyProfit/index.html",
                            H5_URL_NAME_PRODUCT_DETAIL_FIXED_PERIOD:@"https://www.jucaicat.com.cn/app_outer_h5/app350/productDetail/html/detail_month.html",
                            H5_URL_NAME_PRODUCT_DETAIL_FIXED_PERIOD_V2:@"https://www.jucaicat.com.cn/app_outer_h5/app381/productDetail/html/index.html",
                            H5_URL_NAME_CREDITOR_DETAIL:@"https://www.jucaicat.com.cn/app_outer_h5/app350/creditorDetail_2/index.html",
                            H5_URL_NAME_STATEMENT_OF_ACCOUNT:@"https://jucaicat.com.cn/activitiesH5/flexible/201711/bill/html/bill_list.html",
                            H5_URL_NAME_AUTH_AUTO_INVESTMENT:@"https://www.jucaicat.com.cn/app_outer_h5/theWander/notice2/html/entrust_lent_coa.html",
                            //上线前修改
                            H5_URL_NAME_AUTH_RISK_NOTICE:@"https://www.jucaicat.com.cn/app_outer_h5/theWander/notice2/html/risk_letter.html",
                            //上线前修改
                            H5_URL_NAME_AUTH_BAN_NOTICE:@"https://www.jucaicat.com.cn/app_outer_h5/theWander/notice2/html/noactive_notice.html",
                            
                            H5_URL_NAME_AUTHAGREEMENT_LIST:@"https://www.jucaicat.com.cn/app_outer_h5/theWander/notice2/html/list_completed.html",
                            
                            
                            H5_URL_NAME_CREDITOR_AGREEMENT_NEW_TEMPLATE:@"https://www.jucaicat.com.cn/app_outer_h5/app381/contracts/creditorAgreementNew/index.html ",
                            H5_URL_NAME_SIGN_SEAL_PROTOCAL_TEMPLATE:@"https://www.jucaicat.com.cn/app_outer_h5/app381/contracts/signSealProtocol/index.html",
                            H5_URL_NAME_AUTO_AUTHORIZATION_TEMPLATE:@"https://www.jucaicat.com.cn/app_outer_h5/app381/contracts/autoAuthorization/index.html",
                            H5_URL_NAME_RISKTIPS_TEMPLATE:@"https://www.jucaicat.com.cn/app_outer_h5/app381/contracts/riskTip/index.html",
#endif
                            
                            H5_URL_NAME_SAFEGUARD:@"https://www.jucaicat.com.cn/activitiesH5/securityGuard/html/index.html",
                            H5_URL_NAME_ABOUT_JUCAICAT:@"https://www.jucaicat.com.cn/activitiesH5/flexible/201711/about/html/about_company.html",
                            H5_URL_NAME_INVITE_PAGE:@"https://www.jucaicat.com.cn/activitiesH5/flexible/201707/shareInvitationPage/html/index.html",
                            H5_URL_NAME_DISABLE_FAUTURE:@"https://www.jucaicat.com.cn/activitiesH5/monthly/201706/effect/html/index.html",
                            H5_URL_NAME_SIGN:@"https://www.jucaicat.com.cn/activitiesH5/flexible/201709/sign/html/index.html",

                            H5_URL_NAME_TRANSFE_EXPLAIN_RULE:@"https://www.jucaicat.com.cn/app_outer_h5/appH5_300/transferCreditorRight/index.html",

                            H5_URL_NAME_BANK_LIST:@"https://www.jucaicat.com.cn/activitiesH5/theWander/201802/bj_supportbank_list/html/bank_list.html",
                            //上线前修改
//                            H5_URL_NAME_AUTH_AUTO_INVESTMENT:@"https://www.jucaicat.com.cn/app_outer_h5/theWander/notice/html/entrust_lent_coa.html",
                            H5_URL_NAME_BBS_TOPIC_DETAIL:@"https://www.jucaicat.com.cn/activitiesH5/flexible/201710/forum_details/html/index.html",
                            H5_URL_NAME_BBS_MYCOMMENT:@"https://www.jucaicat.com.cn/activitiesH5/flexible/201710/forum_details/html/my_comment.html",
                            H5_URL_NAME_BBS_RULE:@"https://www.jucaicat.com.cn/activitiesH5/flexible/201710/forum_details/html/rule.html",
                            H5_URL_NAME_TRANSFE_EXPLAIN_RULE:@"https://www.jucaicat.com.cn/app_outer_h5/appH5_300/transferCreditorRight/index.html",
                            H5_URL_NAME_BBS_ACTIVITY:@"https://www.jucaicat.com.cn/activitiesH5/activityPage/bbsFouce/index.html",
                            H5_URL_NAME_ANNUALINVESTAMOUNT_EXPLAIN:@"https://www.jucaicat.com.cn/app_outer_h5/app381/explain/index2.html"
                        };
    [self.h5ConfigData addEntriesFromDictionary:dict];
}

@end
