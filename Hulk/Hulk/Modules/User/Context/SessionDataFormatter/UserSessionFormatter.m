//
//  UserSessionFormatter.m
//  Hulk
//
//  Created by 张学超 on 2018/10/31.
//  Copyright © 2018 张学超. All rights reserved.
//

#import "UserSessionFormatter.h"
#import "UserTokenVO.h"
#import "WJJSON.h"

@implementation UserSessionFormatter

-(id<IWJToken>)toToken:(NSData *)data{
    UserTokenVO *token = nil;
    if(data){
        @try {
            token = [WJJSON fromJsonData:data type:[UserTokenVO class]];
        } @catch (NSException *exception){
            token = nil;
        }
    }
    return token;
}

-(NSData *)toData:(id<IWJToken>)token{
    NSData *data = nil;
    if(token){
        @try{
            data = [WJJSON toJson:token];
        } @catch (NSException *exception){
            data = nil;
        }
    }
    return data;
}

@end
