//
//  EmoticonManager.h
//  ExpressionTest
//
//  Created by 杭州移领 on 17/4/7.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EmoticonModel.h"


@interface EmoticonManager : NSObject

/**
 最近表情归档路径
 */
+ (NSString *)recentEmoticonPath;

/**
 最近表情数组
 */
+ (NSArray *)recentEmoticons;

/**
 默认表情数组
 */
+ (NSArray *)defaultEmoticons;

/**
 emoji表情数组
 */
+ (NSArray *)emojiEmoticons;

/**
 小浪花表情数组
 */
+ (NSArray *)lxhEmoticons;

+ (NSAttributedString *)emticonAttributedStringWithString:(id)string ;

+ (NSMutableAttributedString *)emotionStrWithString:(NSString *)text;
@end

@interface EmoticonAttachment: NSTextAttachment

@property (readonly, nonatomic, assign) CGFloat width;
@property (readonly, nonatomic, assign) CGFloat height;

/**
 *  优先级比上面的高，以lineHeight为根据来决定高度
 *  宽度根据imageAspectRatio来定
 */
@property (readonly, nonatomic, assign) CGFloat lineHeightMultiple;

/**
 *  image.size.width/image.size.height
 */
@property (readonly, nonatomic, assign) CGFloat imageAspectRatio;

+ (instancetype)textAttachmentWithWidth:(CGFloat)width height:(CGFloat)height imageBlock:(UIImage * (^)(CGRect imageBounds,NSTextContainer *textContainer,NSUInteger charIndex,EmoticonAttachment *textAttachment))imageBlock;

+ (instancetype)textAttachmentWithLineHeightMultiple:(CGFloat)lineHeightMultiple imageBlock:(UIImage * (^)(CGRect imageBounds,NSTextContainer *textContainer,NSUInteger charIndex,EmoticonAttachment *textAttachment))imageBlock
                                    imageAspectRatio:(CGFloat)imageAspectRatio;
@end


