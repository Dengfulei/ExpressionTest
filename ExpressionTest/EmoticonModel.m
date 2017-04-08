//
//  EmoticonModel.m
//  ExpressionTest
//
//  Created by 杭州移领 on 17/4/7.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import "EmoticonModel.h"

@implementation EmoticonModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (instancetype)initWithDic:(NSDictionary *)dict {
    if (self = [super init]) {
       
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)modelSetValueWithDictionary:(NSDictionary *)dictionary {
    
    return [[self alloc] initWithDic:dictionary];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        self.chs = [aDecoder decodeObjectForKey:@"chs"];
        self.png = [aDecoder decodeObjectForKey:@"png"];
        self.code = [aDecoder decodeObjectForKey:@"code"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.chs forKey:@"chs"];
    [aCoder encodeObject:self.png forKey:@"png"];
    [aCoder encodeObject:self.code forKey:@"code"];
}

@end
