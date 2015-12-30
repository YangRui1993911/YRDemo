//
//  UIView+Common.h
//  IFreeIos
//
//  Created by qianfeng007 on 15/12/9.
//  Copyright © 2015年 YangRui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Common)
//返回屏幕的宽
// @return 屏幕的宽

CGFloat screenWidth();
CGFloat screenHeight();
//返回屏幕的高
// @return 屏幕的高

//计算视图最大的XY最小的XY
CGFloat maxX(UIView *view);
CGFloat maxY(UIView *view);
CGFloat minX(UIView *view);
CGFloat minY(UIView *view);
//计算当前视图的宽和高
CGFloat width(UIView *view);
CGFloat height(UIView *view);
@end
