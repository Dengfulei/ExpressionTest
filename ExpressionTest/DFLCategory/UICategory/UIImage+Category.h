//
//  UIImage+Category.h
//  paopao
//
//  Created by yite on 14-4-28.
//  Copyright (c) 2014年 yite. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)

- (UIImage *)resizeImageWithCapInsets:(UIEdgeInsets)capInsets;
- (UIImage *)fixOrientation;
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;
//等比例缩放
- (UIImage*)scaleToSize:(CGSize)size;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+ (UIImage *)scaleImage:(UIImage *)image scaleFactor:(float)scaleFloat;

- (UIImage *)blurImageWithInputRadius:(CGFloat)radius;

// icon ！＝ nil带有头像的二维码 为nil不带头像的二维码
+ (UIImage *)imageWithQRCodeImageMessage:(NSString *)string
                               imageSize:(CGFloat)imageSize
                                    icon:(NSString *)icon iconSize:(CGSize)iconSize;
@end
