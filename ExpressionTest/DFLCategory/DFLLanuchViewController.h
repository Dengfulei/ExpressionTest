//
//  GuideViewController.h
//  HaiMaYi
//
//  Created by 杭州移领 on 15/12/25.
//  Copyright © 2015年 杭州移领. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFLDevice.h"
@class DFLLanuchViewController;
@protocol DFLLanuchViewControllerDelegate <NSObject>

- (void)endLanuch;

@end
@interface DFLLanuchViewController : UIViewController
@property (nonatomic,assign)id <DFLLanuchViewControllerDelegate> delegate;
@end
