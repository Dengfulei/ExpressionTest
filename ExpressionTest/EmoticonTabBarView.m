//
//  EmoticonTabbarView.m
//  ExpressionTest
//
//  Created by 杭州移领 on 17/4/6.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import "EmoticonTabBarView.h"
@interface EmoticonTabBarView ()

@property (nonatomic, strong) UIButton *selectedButton;

@end

@implementation EmoticonTabBarView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupButtonWithTitle:@"最近" type:EmoticonTabBarViewButtonTypeRecent];
        [self setupButtonWithTitle:@"默认" type:EmoticonTabBarViewButtonTypeDefault];
        [self setupButtonWithTitle:@"Emoji" type:EmoticonTabBarViewButtonTypeEmoji];
        [self setupButtonWithTitle:@" 浪小花" type:EmoticonTabBarViewButtonTypeLxh];
    }
    return self;
    
}

- (void)setupButtonWithTitle:(NSString *)title type:(EmoticonTabBarViewButtonType)type {
    
    UIButton *button = [UIButton new];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [button addTarget:self action:@selector(clickTabBarView:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = type;
    [self addSubview:button];
    // 设置背景图片
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *selectImage = @"compose_emotion_table_mid_selected";
    if (self.subviews.count == 1) {
        image = @"compose_emotion_table_left_normal";
        selectImage = @"compose_emotion_table_left_selected";
    }
    if (self.subviews.count == 4) {
        image = @"compose_emotion_table_right_normal";
        selectImage = @"compose_emotion_table_right_selected";
    }
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateDisabled];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSInteger count = self.subviews.count;
    CGFloat btnW = self.width_dfl / count;
    for (NSInteger i = 0; i < count; i ++) {
        UIButton *button = self.subviews[i];
        button.top_dfl = 0;
        button.width_dfl = btnW;
        button.left_dfl = i * btnW;
        button.height_dfl = self.height_dfl;
    }
}

- (void)setDelegate:(id<EmoticonTabBarViewDelegate>)delegate {
    _delegate = delegate;
    [self clickTabBarView:(UIButton *)[self viewWithTag:EmoticonTabBarViewButtonTypeDefault]];
}

- (void)clickTabBarView:(UIButton *)button {
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [self.delegate tabBar:self didClickButton:button.tag];
    }
}

@end
