//
//  ExpressionView.m
//  ExpressionTest
//
//  Created by 杭州移领 on 17/4/6.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import "EmoticonPageView.h"
#import "NSString+Emoji.h"
@interface EmoticonPageView ()
@property (nonatomic , strong) UIButton *deleteButton;

@end

@implementation EmoticonPageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *deleteButton = [UIButton new];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        self.deleteButton = deleteButton;
    }
    return self;
}
- (void)setEmoticonArray:(NSArray *)emoticonArray {
    _emoticonArray = emoticonArray;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat btnW = [EmoticonPageView eachEmoticonWidth];
    CGFloat margin = [EmoticonPageView buttonEdgeMargin];
    NSInteger maxColumns = [EmoticonPageView eachRowMaxColumns];
    [emoticonArray enumerateObjectsUsingBlock:^(EmoticonModel *model,NSUInteger idx,BOOL *stop){
        UIButton *button = [UIButton new];
        if (model.png) {
            [button setImage:[UIImage imageNamed:model.png] forState:UIControlStateNormal];
        } else if(model.code) {
            [button setTitle:model.code.emoji forState:UIControlStateNormal];
        }
        button.tag = idx;
        [self addSubview:button];
        CGFloat x = margin + (idx % maxColumns) *btnW;
        CGFloat y = margin + (idx / maxColumns) *btnW;
        button.frame = CGRectMake(x, y , btnW, btnW);
        [button addTarget:self action:@selector(clickEmoticon:) forControlEvents:UIControlEventTouchUpInside];
    }];
    [self addSubview:self.deleteButton];
    self.deleteButton.width_dfl = btnW;
    self.deleteButton.left_dfl = self.width_dfl - margin - btnW;
    self.deleteButton.top_dfl = self.height_dfl - btnW;
    [self.deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    self.deleteButton.height_dfl = btnW;
}

- (void)deleteClick {
    
}

- (void)clickEmoticon:(UIButton *)emoticonBtn {
    EmoticonModel *model = self.emoticonArray[emoticonBtn.tag];
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageView:didClickButton:)]) {
        [self.delegate pageView:self didClickButton:model];
    }
}


+ (NSInteger)eachPageMaxRows {

    return 3;
}

+ (NSInteger)eachRowMaxColumns {
    
    return 7;
}

+ (NSInteger)eachPageMaxEmoticonsCount {
    
    //减1是给删除按钮的位置
    return [self eachRowMaxColumns] * [self eachPageMaxRows] - 1;
}

+ (CGFloat)buttonEdgeMargin {
    
    return 20;
}
+ (CGFloat)eachEmoticonWidth {
    
    return ([UIScreen mainScreen].bounds.size.width - 2 * [self buttonEdgeMargin])/[self eachRowMaxColumns];
}

+ (CGFloat)emoticonPageViewHeight {
    return [self eachEmoticonWidth] * [self eachPageMaxRows] + [self buttonEdgeMargin];
}
@end
