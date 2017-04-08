//
//  UIView+DFLExtension.m
//  HaiMaYi
//
//  Created by 杭州移领 on 16/12/14.
//  Copyright © 2016年 杭州移领. All rights reserved.
//

#import "UIView+DFLExtension.h"

@implementation UIView (DFLExtension)

- (CGFloat)left_dfl {
    return self.frame.origin.x;
}

- (void)setLeft_dfl:(CGFloat)x_dfl {
    CGRect frame = self.frame;
    frame.origin.x = x_dfl;
    self.frame = frame;
}

- (CGFloat)top_dfl {
    return self.frame.origin.y;
}

- (void)setTop_dfl:(CGFloat)y_dfl {
    CGRect frame = self.frame;
    frame.origin.y = y_dfl;
    self.frame = frame;
}

- (CGFloat)right_dfl {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight_dfl:(CGFloat)right_dfl {
    CGRect frame = self.frame;
    frame.origin.x = right_dfl - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom_dfl {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom_dfl:(CGFloat)bottom_dfl {
    CGRect frame = self.frame;
    frame.origin.y = bottom_dfl - frame.size.height;
    self.frame = frame;
}


- (CGFloat)centerX_dfl
{
    return self.left_dfl + self.width_dfl * 0.5;
}

- (void)setCenterX_dfl:(CGFloat)centerX_dfl
{
    self.left_dfl = centerX_dfl - self.width_dfl * 0.5;
}

- (CGFloat)centerY_dfl
{
    return self.top_dfl + self.height_dfl * 0.5;
}

- (void)setCenterY_dfl:(CGFloat)centerY_dfl
{
    self.top_dfl = centerY_dfl - self.height_dfl * 0.5;
}

- (CGFloat)width_dfl {
    return self.frame.size.width;
}

- (void)setWidth_dfl:(CGFloat)width_dfl {
    CGRect frame = self.frame;
    frame.size.width = width_dfl;
    self.frame = frame;
}

- (CGFloat)height_dfl {
    return self.frame.size.height;
}

- (void)setHeight_dfl:(CGFloat)height_dfl {
    CGRect frame = self.frame;
    frame.size.height = height_dfl;
    self.frame = frame;
}

- (CGPoint)origin_dfl {
    return self.frame.origin;
}

- (void)setOrigin_dfl:(CGPoint)origin_dfl {
    CGRect frame = self.frame;
    frame.origin = origin_dfl;
    self.frame = frame;
}

- (CGSize)size_dfl {
    return self.frame.size;
}

- (void)setSize_dfl:(CGSize)size_dfl {
    CGRect frame = self.frame;
    frame.size = size_dfl;
    self.frame = frame;
}

@end
