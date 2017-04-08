//
//  EmoticonModel.h
//  ExpressionTest
//
//  Created by 杭州移领 on 17/4/7.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmoticonModel : NSObject <NSCoding>

/** 表情的文字描述 */
@property (nonatomic, copy) NSString *chs;
/** 表情的png图片名 */
@property (nonatomic, copy) NSString *png;
/** emoji表情的16进制编码 */
@property (nonatomic, copy) NSString *code;
- (instancetype)initWithDic:(NSDictionary *)dict;
+ (instancetype)modelSetValueWithDictionary:(NSDictionary *)dictionary;

@end
