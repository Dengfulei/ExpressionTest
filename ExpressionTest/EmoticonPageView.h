//
//  ExpressionView.h
//  ExpressionTest
//
//  Created by 杭州移领 on 17/4/6.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmoticonTabBarView.h"
#import "EmoticonModel.h"

// 一页中最多3行
#define EmoticonMaxRows 3
// 一行中最多7列
#define EmoticonMaxCols 7
// 每一页的表情个数
#define EmoticonPageSize ((EmoticonMaxRows * EmoticonMaxCols) - 1)
@class EmoticonPageView;
@protocol EmoticonPageViewDelegate <NSObject>

- (void)pageView:(EmoticonPageView *)pageView didClickButton:(EmoticonModel *)model;

@end
@interface EmoticonPageView : UIView
@property (nonatomic, strong) NSArray *emoticonArray;
@property (nonatomic, assign) id <EmoticonPageViewDelegate>delegate;

+ (NSInteger)eachPageMaxRows;  //每页最大行数
+ (NSInteger)eachRowMaxColumns; //每行最大列数
+ (NSInteger)eachPageMaxEmoticonsCount;//每页最大表情数
+ (CGFloat)buttonEdgeMargin;           //表情按钮距离左右两边的距离
+ (CGFloat)eachEmoticonWidth;//每个表情的宽度
+ (CGFloat)emoticonPageViewHeight;//表情页面的高度

@end
