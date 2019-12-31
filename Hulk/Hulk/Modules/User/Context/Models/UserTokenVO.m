//
//  UserTokenVO.m
//  Hulk
//
//  Created by 张学超 on 2018/10/31.
//  Copyright © 2018 张学超. All rights reserved.
//

#import "UserTokenVO.h"

@implementation UserTokenVO

#pragma mark IWJToken

-(NSString *)currentToken{
    return _userToken;
}

-(NSString *)refreshToken{
    return nil;
}

-(id)currentUid{
    return _userCode;
}

-(NSTimeInterval)invalidTime{
    return 0;
}

-(NSString *)dataSafeKey{
    NSString *safeKey = WJ_SECURITY_HMACMD5(_userCode, _userToken);
    return safeKey;
}

@end
