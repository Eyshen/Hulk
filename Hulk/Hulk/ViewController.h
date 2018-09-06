//
//  ViewController.h
//  Hulk
//
//  Created by 张学超 on 2018/5/9.
//  Copyright © 2018年 Happiness. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NSCopying

- (id)copyWithZone:(nullable NSZone *)zone;

@end

@protocol NSMutableCopying

- (id)mutableCopyWithZone:(nullable NSZone *)zone;

@end

@interface ViewController : UIViewController



@end

