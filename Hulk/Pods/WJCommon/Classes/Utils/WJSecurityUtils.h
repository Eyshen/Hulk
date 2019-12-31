//
//  WJSecurityUtils.h
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

#import <Foundation/Foundation.h>

#define WJ_SECURITY_MD2(D)                  [WJSecurityUtils MD2:D]
#define WJ_SECURITY_MD4(D)                  [WJSecurityUtils MD4:D]
#define WJ_SECURITY_MD5(D)                  [WJSecurityUtils MD5:D]
#define WJ_SECURITY_SHA1(D)                 [WJSecurityUtils SHA1:D]
#define WJ_SECURITY_SHA224(D)               [WJSecurityUtils SHA224:D]
#define WJ_SECURITY_SHA256(D)               [WJSecurityUtils SHA256:D]
#define WJ_SECURITY_SHA384(D)               [WJSecurityUtils SHA384:D]
#define WJ_SECURITY_SHA512(D)               [WJSecurityUtils SHA512:D]
#define WJ_SECURITY_HEXADEDIMAL(D)          [WJSecurityUtils hexadedimalString:D]
#define WJ_SECURITY_ENCODING_BASE64(D)      [WJSecurityUtils base64:D]
#define WJ_SECURITY_DECODE_BASE64(D)        [WJSecurityUtils dataWithBase64:D]
#define WJ_SECURITY_HMACMD5(C,K)            [WJSecurityUtils HMACMD5:C secretKey:K]
#define WJ_SECURITY_HMACSHA256(C,K)         [WJSecurityUtils HMACSHA256:C secretKey:K]
#define WJ_SECURITY_DES_ENCRY(C,K)          [WJSecurityUtils desEncrypt:C secretKey:K]
#define WJ_SECURITY_DES_DECRY(C,K)          [WJSecurityUtils desDecrypt:C secretKey:K]
/**
 *  安全工具类
 */
@interface WJSecurityUtils : NSObject

/**
 *  MD2 散列
 */
+ (NSString *) MD2:(NSData*) data;

/**
 *  MD4 散列
 */
+ (NSString *) MD4:(NSData*) data;

/**
 *  MD5 散列
 */
+ (NSString *) MD5:(NSData*) data;

/**
 *  SHA1 散列
 */
+ (NSString *) SHA1:(NSData*) data;

+ (NSString *) SHA224:(NSData*) data;

+ (NSString *) SHA256:(NSData*) data;

+ (NSString *) SHA384:(NSData*) data;

+ (NSString *) SHA512:(NSData*) data;

/**
 *  将NSData转换成十六进制字符串
 *
 *  @param data 数据
 *
 *  @return 字符串
 */
+ (NSString *)hexadedimalString:(NSData*) data;

+ (NSString *)base64:(NSData*) data;

+ (NSData *)dataWithBase64:(NSString *)base64String;




/**
 *  HMAC MD5
 *
 *  @param content 需要加密内容
 *  @param secret  密钥
 *
 *  @return 结果
 */
+ (NSString *)HMACMD5:(NSString*)content secretKey:(NSString*)secret;

/**
 *  HMAC SHA256
 *
 *  @param content 需要加密内容
 *  @param secret  密钥
 *
 *  @return 结果
 */
+ (NSString *)HMACSHA256:(NSString*)content secretKey:(NSString*)secret;

//des加密
+(NSData *)desEncrypt:(NSData *)data secretKey:(NSString *)secretKey;

//des解密
+(NSData *)desDecrypt:(NSData *)data secretKey:(NSString *)secretKey;

@end
