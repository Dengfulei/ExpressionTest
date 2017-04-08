//
//  EmoticonTabbarView.h
//  ExpressionTest
//
//  Created by 杭州移领 on 17/4/6.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+DFLExtension.h"

typedef NS_ENUM(NSUInteger,EmoticonTabBarViewButtonType)
{
    EmoticonTabBarViewButtonTypeRecent, // 最近
    EmoticonTabBarViewButtonTypeDefault, // 默认
    EmoticonTabBarViewButtonTypeEmoji, // emoji
    EmoticonTabBarViewButtonTypeLxh, // 浪小花
};

@class EmoticonTabBarView;
@protocol EmoticonTabBarViewDelegate <NSObject>

- (void)tabBar:(EmoticonTabBarView *)tabBar didClickButton:(EmoticonTabBarViewButtonType)type;

@end
@interface EmoticonTabBarView : UIView

@property (nonatomic, assign) id <EmoticonTabBarViewDelegate> delegate;

@end
