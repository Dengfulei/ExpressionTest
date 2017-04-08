//
//  EmoticonManager.m
//  ExpressionTest
//
//  Created by 杭州移领 on 17/4/7.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import "EmoticonManager.h"

static NSArray *_defaultEmoticons, *_emojiEmoticons, *_recentEmoticons, *_lxhEmoticons;

@implementation EmoticonManager

+ (NSString *)recentEmoticonPath {
    
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"emoticons.archive"];
}

+ (NSArray *)recentEmoticons {
    
    return _recentEmoticons;
}

+ (NSArray *)defaultEmoticons {
    if (!_defaultEmoticons) {
        _defaultEmoticons = [self getEmoticonsByFileName:@"default.plist"];
    }
    return _defaultEmoticons;
}

+ (NSArray *)emojiEmoticons {
    if (!_emojiEmoticons) {
        _emojiEmoticons = [self getEmoticonsByFileName:@"emoji.plist"];
    } return _emojiEmoticons;
}

+ (NSArray *)lxhEmoticons {
    if (!_lxhEmoticons) {
        _lxhEmoticons = [self getEmoticonsByFileName:@"lxh.plist"];
    }
    return _lxhEmoticons;
}

+ (NSArray *)getEmoticonsByFileName:(NSString *)file {
    NSString *path = [[NSBundle mainBundle] pathForResource:file ofType:nil];
    NSArray *defaultArray = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *emoticons = [NSMutableArray new];
    for (NSDictionary *dic in defaultArray) {
        EmoticonModel *model = [EmoticonModel modelSetValueWithDictionary:dic];
        [emoticons addObject:model];
    }
    return emoticons;
}


+ (NSAttributedString *)emticonAttributedStringWithString:(id)string {
    NSArray *defaultArray = [EmoticonManager defaultEmoticons];
    
    NSAttributedString *attributedString = nil;
    if ([string isKindOfClass:[NSString class]]) {
        attributedString = [[NSAttributedString alloc]initWithString:string];
    }else{
        attributedString = string;
    }
    
    if (attributedString.length<=0) {
        return attributedString;
    }
    NSString *regex_emoji = @"\\[[a-zA-Z0-9\\/\\u4e00-\\u9fa5]+\\]";  //正则匹配表情
    
    NSMutableAttributedString *resultAttributedString = [NSMutableAttributedString new];
    NSError *error = nil;
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:regex_emoji options:NSRegularExpressionCaseInsensitive error:&error];
    //处理表情
    NSArray *results = [re matchesInString:attributedString.string
                                   options:NSMatchingWithTransparentBounds
                                     range:NSMakeRange(0, [attributedString length])];
    
    //遍历表情，然后找到对应图像名称，并且处理
    NSUInteger location = 0;
    for (NSTextCheckingResult *result in results) {
        NSRange range = result.range;
        NSAttributedString *subAttrStr = [attributedString attributedSubstringFromRange:NSMakeRange(location, range.location - location)];
        //先把非表情的部分加上去
        [resultAttributedString appendAttributedString:subAttrStr];
        
        //下次循环从表情的下一个位置开始
        location = NSMaxRange(range);
        
        NSAttributedString *expressionAttrStr = [attributedString attributedSubstringFromRange:range];
        for (EmoticonModel *model in defaultArray) {
            if ([expressionAttrStr.string isEqualToString:model.chs]) {
                //加个表情到结果中
                UIImage *image = [UIImage imageNamed:model.png];
                
                EmoticonAttachment *textAttachment = [EmoticonAttachment textAttachmentWithLineHeightMultiple:1.0f imageBlock:^UIImage *(CGRect imageBounds, NSTextContainer *textContainer, NSUInteger charIndex, EmoticonAttachment *textAttachment) {
                    return image;
                } imageAspectRatio:image.size.width/image.size.height];
                [resultAttributedString appendAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment]];
                break;
            }
        }
    }
    
    if (location < [attributedString length]) {
        //到这说明最后面还有非表情字符串
        NSRange range = NSMakeRange(location, [attributedString length] - location);
        NSAttributedString *subAttrStr = [attributedString attributedSubstringFromRange:range];
        [resultAttributedString appendAttributedString:subAttrStr];
    }
    
    return resultAttributedString;
    
}


+ (NSMutableAttributedString *)emotionStrWithString:(NSString *)text
{
    
    NSArray *defaultArray = [EmoticonManager defaultEmoticons];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:text];
    NSString *regex_emoji = @"\\[[a-zA-Z0-9\\/\\u4e00-\\u9fa5]+\\]";  //正则匹配表情
    
    NSError *error = nil;
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:regex_emoji options:NSRegularExpressionCaseInsensitive error:&error];
    if (!re) {
        NSLog(@"%@", [error localizedDescription]);
        return attributeString;
    }
    
    NSArray *resultArray = [re matchesInString:text options:0 range:NSMakeRange(0, text.length)];
    //3、获取所有的表情以及位置
    //用来存放字典，字典中存储的是图片和图片对应的位置
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:resultArray.count];
    //根据匹配范围来用图片进行相应的替换
    for(NSTextCheckingResult *match in resultArray) {
        //获取数组元素中得到range
        NSRange range = [match range];
        //获取原字符串中对应的值
        NSString *subStr = [text substringWithRange:range];
        
        for (EmoticonModel * model in defaultArray) {
            if ([model.chs isEqualToString:subStr]) {
                //faceName就是我们要加载的图片
                //新建文字附件来存放我们的图片,iOS7才新加的对象
                NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
                //给附件添加图片
                textAttachment.image = [UIImage imageNamed:model.png];
                //调整一下图片的位置,如果你的图片偏上或者偏下，调整一下bounds的y值即可
                textAttachment.bounds = CGRectMake(0, -8, textAttachment.image.size.width, textAttachment.image.size.height);
                //把附件转换成可变字符串，用于替换掉源字符串中的表情文字
                NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
                //把图片和图片对应的位置存入字典中
                NSMutableDictionary *imageDic = [NSMutableDictionary dictionaryWithCapacity:2];
                [imageDic setObject:imageStr forKey:@"image"];
                [imageDic setObject:[NSValue valueWithRange:range] forKey:@"range"];
                //把字典存入数组中
                [imageArray addObject:imageDic];
                break;
            }
        }
    }
    
    //4、从后往前替换，否则会引起位置问题
    for (int i = (int)imageArray.count -1; i >= 0; i--) {
        NSRange range;
        [imageArray[i][@"range"] getValue:&range];
        //进行替换
        [attributeString replaceCharactersInRange:range withAttributedString:imageArray[i][@"image"]];
    }
    return attributeString;
}

@end

@interface EmoticonAttachment()

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat lineHeightMultiple;
@property (nonatomic, assign) CGFloat imageAspectRatio;

@property (nonatomic, copy) UIImage * (^imageBlock)(CGRect imageBounds,NSTextContainer *textContainer,NSUInteger charIndex,EmoticonAttachment *textAttachment);

@end

@implementation EmoticonAttachment

+ (instancetype)textAttachmentWithWidth:(CGFloat)width height:(CGFloat)height imageBlock:(UIImage * (^)(CGRect imageBounds,NSTextContainer *textContainer,NSUInteger charIndex,EmoticonAttachment *textAttachment))imageBlock
{
    EmoticonAttachment *textAttachment = [EmoticonAttachment new];
    textAttachment.width = width;
    textAttachment.height = height;
    textAttachment.imageBlock = imageBlock;
    return textAttachment;
}

+ (instancetype)textAttachmentWithLineHeightMultiple:(CGFloat)lineHeightMultiple imageBlock:(UIImage * (^)(CGRect imageBounds,NSTextContainer *textContainer,NSUInteger charIndex,EmoticonAttachment *textAttachment))imageBlock
                                    imageAspectRatio:(CGFloat)imageAspectRatio
{
    EmoticonAttachment *textAttachment = [EmoticonAttachment new];
    textAttachment.lineHeightMultiple = lineHeightMultiple;
    textAttachment.imageBlock = imageBlock;
    textAttachment.imageAspectRatio = imageAspectRatio;
    return textAttachment;
}

//重写以绘制
- (UIImage *)imageForBounds:(CGRect)imageBounds textContainer:(NSTextContainer *)textContainer characterIndex:(NSUInteger)charIndex
{
    if (self.imageBlock)
    {
        return self.imageBlock(imageBounds,textContainer,charIndex,self);
    }
    
    return [super imageForBounds:imageBounds textContainer:textContainer characterIndex:charIndex];
}

//重写以返回附件的大小
- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex
{
    if (self.imageBlock)
    {
        CGFloat width = self.width;
        CGFloat height = self.height;
        
        // 找到其是否有设置字体，如果有，就根据字体的descender调整下位置,以及lineHeight调整大小
        UIFont *font = [textContainer.layoutManager.textStorage attribute:NSFontAttributeName
                                                                  atIndex:charIndex
                                                           effectiveRange:nil];
        CGFloat baseLineHeight = (font?font.lineHeight:lineFrag.size.height);
        
        if (self.lineHeightMultiple>0) {
            width = height = baseLineHeight*self.lineHeightMultiple;
            if (self.imageAspectRatio>0) {
                width = height*self.imageAspectRatio;
            }
        }else{
            if (width==0&&height==0) {
                width = height = lineFrag.size.height;
            }else if (width==0&&height!=0) {
                width = height;
            }else if (height==0&&width!=0) {
                height = width;
            }
        }
        
        CGFloat y = font.descender;
        y -= (height-baseLineHeight)/2;
        
        return CGRectMake(0, y, width, height);
        
    }
    
    return [super attachmentBoundsForTextContainer:textContainer proposedLineFragment:lineFrag glyphPosition:position characterIndex:charIndex];
}

#pragma mark - setter
- (void)setLineHeightMultiple:(CGFloat)lineHeightMultiple
{
    NSAssert(lineHeightMultiple>0, @"lineHeightMultiple必须大于0");
    
    _lineHeightMultiple = lineHeightMultiple;
}
@end
