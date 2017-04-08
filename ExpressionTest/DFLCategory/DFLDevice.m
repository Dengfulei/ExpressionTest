//
//  HMYDevice.m
//  HaiMaYi
//
//  Created by 杭州移领 on 17/1/10.
//  Copyright © 2017年 杭州移领. All rights reserved.
//

#import "DFLDevice.h"

@implementation DFLDevice

+ (thisDeviceClass)currentDeviceClass {
    
    CGFloat greaterPixelDimension = (CGFloat) fmaxf(((float)[[UIScreen mainScreen]bounds].size.height),
                                                    ((float)[[UIScreen mainScreen]bounds].size.width));
    
    switch ((NSInteger)greaterPixelDimension) {
        case 480:
             // 4/4s
            return (( [[UIScreen mainScreen] scale] > 1.0) ? thisDeviceClass_iPhoneRetina : thisDeviceClass_iPhone );
           
            break;
        case 568:
            // 5/5c/5s
            return thisDeviceClass_iPhone5;
            break;
        case 667:
            // 6 / 6s
            return thisDeviceClass_iPhone6;
            break;
        case 736:
            // 6+ / 7+
            return thisDeviceClass_iPhone6plus;
            break;
        case 1024:
            return (( [[UIScreen mainScreen] scale] > 1.0) ? thisDeviceClass_iPadRetina : thisDeviceClass_iPad );
            break;
        default:
            return thisDeviceClass_unknown;
            break;
    }
}

+ (NSString *)magicSuffixForDevice
{
    switch ([self currentDeviceClass]) {
        case thisDeviceClass_iPhone:
            return @"";
            break;
        case thisDeviceClass_iPhoneRetina:
            return @"@2x";
            break;
        case thisDeviceClass_iPhone5:
            return @"-568h@2x";
            break;
        case thisDeviceClass_iPhone6:
            return @"-667h@2x"; //or some other arbitrary string..
            break;
        case thisDeviceClass_iPhone6plus:
            return @"-736h@3x";
            break;
            
        case thisDeviceClass_unknown:
        default:
            return @"";
            break;
    }
}

+ (UIImage *)imageDeviceWithName:(NSString *)fileName
{
    UIImage *result = nil;
    NSString *nameWithSuffix = [fileName stringByAppendingString:[self magicSuffixForDevice]];
    
    result = [UIImage imageNamed:nameWithSuffix];
    if (!result)
        result = [UIImage imageNamed:fileName];
    return result;
}

@end
