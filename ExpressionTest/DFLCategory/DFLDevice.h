//
//  HMYDevice.h
//  HaiMaYi
//
//  Created by 杭州移领 on 17/1/10.
//  Copyright © 2017年 杭州移领. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, thisDeviceClass) {
    
    thisDeviceClass_iPhone,
    thisDeviceClass_iPhoneRetina,
    thisDeviceClass_iPhone5,
    thisDeviceClass_iPhone6,
    thisDeviceClass_iPhone6plus,
    
    // we can add new devices when we become aware of them
    
    thisDeviceClass_iPad,
    thisDeviceClass_iPadRetina,
    
    thisDeviceClass_unknown
};

@interface DFLDevice : NSObject

+(thisDeviceClass) currentDeviceClass;
+(UIImage *)imageDeviceWithName:(NSString *)fileName;
+(NSString *)magicSuffixForDevice;

@end
