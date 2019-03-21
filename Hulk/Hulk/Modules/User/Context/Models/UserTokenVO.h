//
//  UserTokenVO.h
//  Hulk
//
//  Created by 张学超 on 2018/10/31.
//  Copyright © 2018 张学超. All rights reserved.
//

#import "AppBaseVO.h"
#import "IWJToken.h"

@interface UserTokenVO : AppBaseVO<IWJToken>

@property (nonatomic, copy) NSString *userCode;

@property (nonatomic, copy) NSString *userToken;

@end
