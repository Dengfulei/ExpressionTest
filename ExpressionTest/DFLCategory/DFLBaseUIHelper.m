//
//  WKBaseUIHelper.m
//  paopao
//
//  Created by YiTe on 14-6-13.
//  Copyright (c) 2014年 yite. All rights reserved.
//

#import "DFLBaseUIHelper.h"

#define QQImage(imageName)  [UIImage imageNamed:imageName]

@implementation DFLBaseUIHelper

+ (UIButton *)baseBackButtonWithTarget:(UIViewController *)target
                                action:(SEL)action
                                 isRed:(BOOL)isRed
{
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [button setBackgroundColor:[UIColor clearColor]];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 13.5, 17, 17)];

    [button addSubview:imageView];
    
    return button;
}

+ (UIButton *)baseBackButtonWithTarget:(UIViewController *)target
                                action:(SEL)action
{
    return [DFLBaseUIHelper baseBackButtonWithTarget:target action:action isRed:YES];
}

+ (UIButton *)baseButtonWithFrame:(CGRect)frame
                           target:(id)target
                         selector:(SEL)selector
                            image:(NSString *)image
                     imagePressed:(NSString *)imagePressed
                            title:(NSString *)title
                             font:(NSString *)textFont
                        textColor:(UIColor *)textColor
                         textSize:(CGFloat)textSize
                         textBold:(BOOL)isBold
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    if (image) {
        [button setBackgroundImage:QQImage(image) forState:UIControlStateNormal];
        if (imagePressed)
            [button setBackgroundImage:[UIImage imageNamed:imagePressed] forState:UIControlStateHighlighted];
    }
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:textColor forState:UIControlStateNormal];
        if (isBold)
            [button.titleLabel setFont:[UIFont boldSystemFontOfSize:textSize]];
        else if (textFont)
            [button.titleLabel setFont:[UIFont fontWithName:textFont size:textSize]];
        else
            [button.titleLabel setFont:[UIFont systemFontOfSize:textSize]];
        [button.titleLabel setTextColor:textColor];
    }
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UILabel *)baseLabelWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)color
{
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    if (color)
        label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    
    return label;
}

+ (void)baseAlertViewWithMessage:(NSString *)message
{
    [[[UIAlertView alloc] initWithTitle:@"提示"
                                message:message
                               delegate:nil
                      cancelButtonTitle:@"确定"
                      otherButtonTitles:nil, nil] show];
}


@end
