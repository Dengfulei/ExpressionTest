//
//  GuideViewController.m
//  HaiMaYi
//
//  Created by 杭州移领 on 15/12/25.
//  Copyright © 2015年 杭州移领. All rights reserved.
//

#import "DFLLanuchViewController.h"

@interface DFLLanuchViewController ()<UIScrollViewDelegate>
@property (nonatomic , strong) UIScrollView *lanuchScrollView;
@property (nonatomic , strong) UIPageControl *pageControl;
@property (nonatomic , assign) NSInteger pageControlNumber;
@end

@implementation DFLLanuchViewController

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 20)];
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        [_pageControl addTarget:self action:@selector(clickPageControl:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupScrollViewContentSizeWithImageCount:3];
    self.pageControl.numberOfPages = self.pageControlNumber;
    [self.view addSubview:self.pageControl];
    

}

- (void)setupScrollViewContentSizeWithImageCount:(NSInteger)count {
    
    self.pageControlNumber = count;
    CGRect frame = self.view.bounds;
    self.lanuchScrollView = [[UIScrollView alloc] initWithFrame:frame];
    self.lanuchScrollView.showsHorizontalScrollIndicator = NO;
    self.lanuchScrollView.bounces = NO;
    self.lanuchScrollView.pagingEnabled = YES;
    self.lanuchScrollView.delegate = self;
    self.lanuchScrollView.contentSize = CGSizeMake(count * CGRectGetWidth(frame), CGRectGetHeight(frame));
    [self.view addSubview:self.lanuchScrollView];
    
    
    for (NSInteger i = 0; i < count; i ++) {
        CGRect imageFrame = CGRectMake(i * frame.size.width, 0, frame.size.width, frame.size.height);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageFrame];
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.userInteractionEnabled = YES;
        [self.lanuchScrollView addSubview:imageView];
        if (i == count - 1) {
            UIButton *button = [UIButton new];
            button.frame = CGRectMake((frame.size.width - 80)/2,CGRectGetMinY(self.pageControl.frame) - 50  , 80, 40);
            button.backgroundColor = [UIColor blueColor];
            [button setTitle:@"立即进入" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(immediatelyIntoApp) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
        }
        NSString *imageName;
        //  default%@-667h 图片命名规则
        switch ([DFLDevice currentDeviceClass]) {
                //由于5，6 的宽高比例都是 1.775可以共用一套 750 ＊ 1334@2x图
            case thisDeviceClass_iPhone5:
            case thisDeviceClass_iPhone6:
                imageName  = [NSString stringWithFormat:@"default%@-667h", @(i + 1)];
                break;
            default:
                // 6 + 优先加载1242 8 2208@3x 图
                // 4 640 * 960@2x
                imageName  = [NSString stringWithFormat:@"default%@", @(i + 1)];
                break;
        }
        imageView.image = [DFLDevice imageDeviceWithName:imageName];
    }
    
}

- (void)clickPageControl:(UIPageControl *)pageControl {
    
    self.lanuchScrollView.contentOffset = CGPointMake(pageControl.currentPage * self.view.frame.size.width, 0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int page = (int)(scrollView.contentOffset.x / self.view.frame.size.width);
    NSLog(@"page == %d",page);
    self.pageControl.currentPage = page;
    if (scrollView.contentOffset.x > self.pageControlNumber * self.view.frame.size.width) {
        [self immediatelyIntoApp];
    }
}

- (void)immediatelyIntoApp {
    NSLog(@"....");
    if (_delegate && [_delegate respondsToSelector:@selector(endLanuch)]) {
        [self.delegate endLanuch];
    }
}

@end
