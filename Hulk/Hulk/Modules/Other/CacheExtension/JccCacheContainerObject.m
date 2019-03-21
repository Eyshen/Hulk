//
//  JccCacheContainerObject.m
//  ios-jucaicat
//
//  Created by 吴云海 on 16/8/25.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "JccCacheContainerObject.h"

@implementation JccCacheContainerObject

-(instancetype)initWithData:(id)data {
    self = [super init];
    if (self) {
        self.data = data;
        self.versionId = WJ_APPLICATION_SHORT_VERSION;
        self.createtTime = [[NSDate date] timeIntervalSince1970];
    }
    return self;
}

@end
