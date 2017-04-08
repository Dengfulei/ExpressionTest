//
//  DFLUtils.h
//  DFLCategoryExample
//
//  Created by 杭州移领 on 17/1/11.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DFLUtils : NSObject
+ (Class)currentViewControllerClass;
//邮箱
+ (BOOL) validateEmail:(NSString *)email;
//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;

//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo;

//车型
+ (BOOL) validateCarType:(NSString *)CarType;

//用户名
+ (BOOL) validateUserName:(NSString *)name;

//密码
+ (BOOL) validatePassword:(NSString *)passWord;

//昵称
+ (BOOL) validateNickname:(NSString *)nickname;

//身份证号
+ (BOOL) validateIdentityCard:(NSString *)identityCard;

//小数点后两位
+ (BOOL) validateTwodecimalplaces:(NSString *)point;

// 仅含有中文
+ (BOOL) validateChinese:(NSString *)string;

//判断内容是否全部为空格  yes 全部为空格  no 不是
+ (BOOL)isEmpty:(NSString *) str;

// 32位小写MD_5加密
+ (NSString *)xMD5_32BitWithString:(NSString *)str;

// 32位大些写MD_5加密 例如用于微信支付
+ (NSString *)XMD5_32BitWithString:(NSString *)str;
@end
