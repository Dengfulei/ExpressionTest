//
//  EmoticonListView.m
//  ExpressionTest
//
//  Created by 杭州移领 on 17/4/6.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import "EmoticonListView.h"

@interface EmoticonListView() <UIScrollViewDelegate,EmoticonPageViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@end
@implementation EmoticonListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // 1.UIScollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.frame = CGRectMake(0, 0, self.width_dfl, [EmoticonPageView emoticonPageViewHeight]);
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        // 去除水平方向的滚动条
        scrollView.showsHorizontalScrollIndicator = NO;
        // 去除垂直方向的滚动条
        scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 2.pageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.frame = CGRectMake(0, self.scrollView.height_dfl, self.width_dfl, 15);
        // 当只有1页时，自动隐藏pageControl
        pageControl.hidesForSinglePage = YES;
        pageControl.backgroundColor = [UIColor whiteColor];
        pageControl.userInteractionEnabled = NO;
        // 设置内部的圆点图片
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}

- (void)setEmoticonArray:(NSArray *)emoticonArray {
    _emoticonArray = emoticonArray;
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
   
    //每页最大表情数删除按钮不再表情内
    NSInteger eachPageMaxEmoticonsCount = [EmoticonPageView eachPageMaxEmoticonsCount];
    //总共有几页表情
    NSInteger pagesCount = (emoticonArray.count + eachPageMaxEmoticonsCount -1) / eachPageMaxEmoticonsCount;
    self.pageControl.numberOfPages = pagesCount;
    for (NSInteger i = 0; i< pagesCount; i++) {
        EmoticonPageView *pageView = [[EmoticonPageView alloc] init];
        pageView.delegate = self;
        NSRange range;
        range.location = i * eachPageMaxEmoticonsCount;
        //剩余表情数
        NSInteger left = emoticonArray.count - range.location;
        if (left >= eachPageMaxEmoticonsCount) { //这一页表情够20
            range.length = eachPageMaxEmoticonsCount;
        } else {
            range.length = left;
        }
        NSArray *subArray = [emoticonArray subarrayWithRange:range];
        pageView.frame = self.scrollView.frame;
        pageView.left_dfl = i * self.width_dfl;
        pageView.emoticonArray = subArray;
        [self.scrollView addSubview:pageView];
    }
    self.pageControl.currentPage = 0;
    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.scrollView.contentSize = CGSizeMake(self.width_dfl * pagesCount,0);
}


+ (CGFloat)EmoticonListViewHeight {
    
    return [EmoticonPageView emoticonPageViewHeight] + 15;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / self.scrollView.width_dfl;
    self.pageControl.currentPage = index;
}

- (void)pageView:(EmoticonPageView *)pageView didClickButton:(EmoticonModel *)model {
    if (self.delegate && [self.delegate respondsToSelector:@selector(listView:didClickButton:)]) {
        [self.delegate listView:self didClickButton:model];
    }
}

@end
