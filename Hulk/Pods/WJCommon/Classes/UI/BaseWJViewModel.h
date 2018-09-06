//
//  BaseWJViewModel.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by 吴云海 on 16-2-27.
//  Copyright (c) 2016年 WJ. All rights reserved.
//

#import "AbstractWJBusinessObject.h"
#import "IWJViewModel.h"

@interface BaseWJViewModel : AbstractWJBusinessObject<IWJViewModel>

#pragma mark IWJViewModel
@property (nonatomic, assign) BOOL wjActive;

@end
