//
//  EmoticonKeyBoardView.m
//  ExpressionTest
//
//  Created by 杭州移领 on 17/4/7.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import "EmoticonKeyBoardView.h"

@interface EmoticonKeyBoardView ()<EmoticonTabBarViewDelegate>
@property (nonatomic, strong) EmoticonTabBarView *tabBar;


@end

@implementation EmoticonKeyBoardView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        EmoticonListView *listView = [[EmoticonListView alloc] initWithFrame:CGRectMake(0, 0, self.width_dfl, [EmoticonListView EmoticonListViewHeight])];
        [self addSubview:listView];
        self.listView = listView;
        
        EmoticonTabBarView *tabBar = [[EmoticonTabBarView alloc] initWithFrame:CGRectMake(0, listView.height_dfl, self.width_dfl, 40)];
        tabBar.delegate = self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
    }
    return self;
}

- (void)tabBar:(EmoticonTabBarView *)tabBar didClickButton:(EmoticonTabBarViewButtonType)type {
    
    switch (type) {
        case EmoticonTabBarViewButtonTypeRecent:
            
            break;
        case EmoticonTabBarViewButtonTypeDefault:
            
            self.listView.emoticonArray = [EmoticonManager defaultEmoticons];
            
            break;
        case EmoticonTabBarViewButtonTypeEmoji:
            
            self.listView.emoticonArray = [EmoticonManager emojiEmoticons];
            
            break;
        case EmoticonTabBarViewButtonTypeLxh:
            
            self.listView.emoticonArray = [EmoticonManager lxhEmoticons];
            
            break;
            
        default:
            break;
    }
}


@end
