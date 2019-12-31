//
//  JccUserInfoVO.m
//  ios-jucaicat
//
//  Created by wuyunhai on 16/5/16.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "ZYUserInfoVO.h"
#import "IWJSession.h"

@implementation ZYUserInfoVO

-(void)incrChangeCounterAction {
    [self willChangeValueForKey:@"changeCounter"];
    _changeCounter++;
    [self didChangeValueForKey:@"changeCounter"];
}

-(void)incrSerializationUserDataCounterAction {
    [self willChangeValueForKey:@"serializationUserDataCounter"];
    _serializationUserDataCounter++;
    [self didChangeValueForKey:@"serializationUserDataCounter"];
}

-(void)cleanData {
    _phoneNumber = nil;
    _emailDress = nil;
    _idNumber = nil;
    _realName = nil;
    _userCode = nil;
    
    [self performSelectorOnMainThread:@selector(incrChangeCounterAction) withObject:nil waitUntilDone:NO];
}

-(NSString*)phoneNumber {
    return _phoneNumber;
}

-(NSString*)idNumber {
    return _idNumber;
}

-(NSString*)realName {
    return _realName;
}

-(NSString *)userCode {
    return _userCode;
}

-(NSString *)emailDress{
    return _emailDress;
}

-(NSString *)accessToken {
    return [[[WJSession sharedInstance] getToken] currentToken];
}

-(void)fillLoginData:(id<ILoginData>)loginData {
    self.phoneNumber = [loginData phoneNumber];
    self.idNumber = [loginData idNumber];
    self.realName = [loginData realName];
    self.userCode = [loginData userCode];
    self.emailDress = [loginData emailDress];
    [self performSelectorOnMainThread:@selector(incrChangeCounterAction) withObject:nil waitUntilDone:NO];
    [self performSelectorOnMainThread:@selector(incrSerializationUserDataCounterAction) withObject:nil waitUntilDone:NO];
}

-(void)fillRealUserData:(id<IRealUserData>)realUserData {
    NSString *realName = [realUserData realName];
    NSString *idNumber = [realUserData idNumber];
    if (realName) self.realName = realName;
    if (idNumber) self.idNumber = idNumber;
}

-(void)fillUserDetailData:(id<IUserDetailData>)userDetailData {
    self.phoneNumber = [userDetailData phoneNumber];
    self.emailDress = [userDetailData emailDress];
    self.idNumber = [userDetailData idNumber];
    self.realName = [userDetailData realName];
    [self performSelectorOnMainThread:@selector(incrChangeCounterAction) withObject:nil waitUntilDone:NO];
    [self performSelectorOnMainThread:@selector(incrSerializationUserDataCounterAction) withObject:nil waitUntilDone:NO];
}


@end
