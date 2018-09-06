//
//  BaseWJCollectionView.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 16/2/18.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWJPullRefreshView.h"

@interface BaseWJCollectionView : UICollectionView

@property (nonatomic, weak) UIView<IWJPullRefreshFooterView> *pullRefreshFooterView;

@property (nonatomic, weak) UIView<IWJPullRefreshView> *pullRefreshHeaderView;

@end
