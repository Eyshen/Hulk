//
//  H5ConfigAPI.h
//  ios-jucaicat
//
//  Created by 张大宗 on 16/8/12.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "AppBaseHttpRequest.h"
#import "AppBaseHttpResponse.h"
#import "H5ConfigDTO.h"

@interface FetchH5ConfigRequest : AppBaseHttpRequest

@property (nonatomic,assign)long lastUpdateTime;

@end


@interface FetchH5ConfigResDTO : AppBaseDTO

@property(nonatomic, assign) long lastUpdateTime;

@property(nonatomic, copy) NSArray *h5PageDataList;

@end

@interface FetchH5ConfigResponse : AppBaseHttpResponse

@property(nonatomic, copy) FetchH5ConfigResDTO *data;

@end
