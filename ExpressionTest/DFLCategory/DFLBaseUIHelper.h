//
//  WKBaseUIHelper.h
//  paopao
//
//  Created by YiTe on 14-6-13.
//  Copyright (c) 2014年 yite. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DFLBaseUIHelper : NSObject

+ (UIButton *)baseBackButtonWithTarget:(UIViewController *)target
                                action:(SEL)action
                                 isRed:(BOOL)isRed;
+ (UIButton *)baseBackButtonWithTarget:(UIViewController *)target action:(SEL)action;

+ (UIButton *)baseButtonWithFrame:(CGRect)frame target:(id)target selector:(SEL)selector image:(NSString *)image imagePressed:(NSString *)imagePressed title:(NSString *)title font:(NSString *)textFont textColor:(UIColor *)textColor textSize:(CGFloat)textSize textBold:(BOOL)isBold;

+ (UILabel *)baseLabelWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)color;

+ (void)baseAlertViewWithMessage:(NSString *)message;


@end
