//
//  EmoticonListView.h
//  ExpressionTest
//
//  Created by 杭州移领 on 17/4/6.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmoticonPageView.h"
@class EmoticonListView;
@protocol EmoticonListViewDelegate <NSObject>

- (void)listView:(EmoticonListView *)listView didClickButton:(EmoticonModel *)model;

@end
@interface EmoticonListView : UIView

@property (nonatomic, strong) NSArray *emoticonArray;
@property (nonatomic, assign) id <EmoticonListViewDelegate>delegate;

+ (CGFloat)EmoticonListViewHeight;
@end
