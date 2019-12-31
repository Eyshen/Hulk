//
//  IWJUploadFileInfo.h
//  WJHttpEngineAPI-example
//
//  Created by 吴云海 on 16/9/26.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  上传文件信息
 */
@protocol IWJUploadFileInfo <NSObject>

/**
 *  文件名称
 */
-(NSString*)fileName;

/**
 *  文件路径
 */
-(NSString*)filePath;

/**
 *  文件内容类型
 */
-(NSString*)mimeType;

@end
