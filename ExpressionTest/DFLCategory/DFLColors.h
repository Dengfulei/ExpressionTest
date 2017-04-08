//
//  DFLColors.h
//  DFLCategoryExample
//
//  Created by 杭州移领 on 17/1/11.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIColor+HexColor.h"
@interface DFLColors : NSObject

//  背景色
+ (UIColor *)bgColor;

//  tabBar背景色
+ (UIColor *)tabBarColor;

//  基色
+ (UIColor *)themeColor;

// 导航栏title颜色
+ (UIColor *)navBarTitleColor;

//  主字体颜色
+ (UIColor *)titleColor;

//  二级字体颜色
+ (UIColor *)secondTitleColor;

//  导航栏颜色
+ (UIColor *)navBarColor;

@end
